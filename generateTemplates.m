%CCCP
%Grab Correlation Object Script
%Code is optimized for Debian based Linux
%Grabs snippets from picks in events file
%Loads into correlation object
%At the moment, offset is +/- 10 sec.
%Later on, this will be defined in the input file

%Snippet Settings
%Snippet window settings (sec)




%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m
template_data_input
general_settings


directory_check = sprintf('./%s/%s',base_folder,template_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Template directory created \n');
end



%Create Move Out matrix
template_move_out = cell(1,length(template_list(:,1)));


%Narrowing down focus to individual stations and channels
for template_count = 1:length(template_list(:,1))
    single_template = template_list(template_count,:);
    
    
    for station_count = 1:length(single_template);
        station_specific_template = single_template(station_count);
        P_Pick_time = datenum(station_specific_template.pWaveArrival);
        S_Pick_time = datenum(station_specific_template.sWaveArrival);
        
        %Choose which point to use for correlation, P or S break
        
        %For P Wave
        if station_specific_template.trigger == 'P'
            time_before = station_specific_template.sideWindows(1);
            time_after = station_specific_template.sideWindows(2);
            starttime = P_Pick_time - (time_before/86400);
            endtime = P_Pick_time + (time_after/86400);
        elseif station_specific_template.trigger == 'S'            
            %For S Wave
            time_before = station_specific_template.sideWindows(1);
            time_after = station_specific_template.sideWindows(2);
            starttime = S_Pick_time - (time_before/86400);
            endtime = S_Pick_time + (time_after/86400);
        end
        numberofchannels = length(station_specific_template.channel_list);
        template = station_specific_template.template;
        station = station_specific_template.station;
        network = station_specific_template.network;

        
        for chan_count = 1:numberofchannels
            channel = station_specific_template.channel_list{chan_count};
            template_savename = sprintf('%s/%s/%s_%s_%s.mat',base_folder,template_folder,template,station,channel);
            if exist(template_savename,'file') == 2
                fprintf('Template Exists. Yay.\n')
                load(template_savename);
                fprintf('Template %s loaded.\n',template_savename)
            else
                wf_Temp = waveform();
                while isempty(wf_Temp) == 1
                    try
                        fprintf('Downloading template\n')
                        Temp = irisFetch.Traces(network,station,location, channel, starttime, endtime,'verbose','includePZ');
                        wf_Temp = convertTraces(Temp);
                    catch exception
                        fprintf('Trying again....\n');
                    end
                end
                wf_Temp = fillgaps(wf_Temp,0);
                wf_Temp = filtfilt(filter,wf_Temp);
                save(template_savename,'wf_Temp');
                fprintf('Template %s saved.\n',template_savename)
            end
        end       
    end

end
    
