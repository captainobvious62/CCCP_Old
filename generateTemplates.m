%CCCP
%Grab Correlation Object Script
%Code is optimized for Debian based Linux
%Grabs snippets from picks in events file
%Loads into correlation object
%At the moment, offset is +/- 10 sec(ish).
%Later on, this will be defined in the input file

%Snippet Settings
%Snippet window settings (sec)




%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m
templates
general_settings


directory_check = sprintf('./%s/%s',base_folder,template_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Template directory created \n');
end

%Narrowing down focus to individual stations and channels
for template_count = 1:length(template_list(:,1))
    single_template = template_list{template_count};
    
    
    for station_count = 1:length(single_template);
        station_specific_template = single_template(station_count);
        P_Pick_time = datenum(station_specific_template.pWaveArrival);
        S_Pick_time = datenum(station_specific_template.sWaveArrival);
        
        %Choose which point to use for correlation, P or S break
        
        %For P Wave
        if strcmp(station_specific_template.trigger,'P') == 1

            starttime = P_Pick_time - (time_before/86400);
            endtime = P_Pick_time + (time_after/86400);
        elseif strcmp(station_specific_template.trigger,'S') == 1
        %For S Wave

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
                attempts = 0;
                while isempty(wf_Temp) == 1
                    try
                        fprintf('Downloading template\n')
                        Temp = irisFetch.Traces(network,station,location, channel, starttime, endtime,'verbose','includePZ');
                        %wf_Temp = convertTracesRM_IR(Temp);
                        wf_Temp = convertTraces(Temp);
                    catch exception
                        fprintf('Trying again....\n');
                    end      
                    attempts = attempts +1;
                    if attempts >5
                        break
                    end
                end
                if strcmp(station_specific_template.trigger,'P') == 1 
                    wf_Temp = addfield(wf_Temp,'TRIGGER',datenum(station_specific_template.pWaveArrival));
                elseif strcmp(station_specific_template.trigger,'S') == 1
                    wf_Temp = addfield(wf_Temp,'TRIGGER',datenum(station_specific_template.sWaveArrival));
                end
                save(template_savename,'wf_Temp');
                fprintf('Template %s saved.\n',template_savename)
            end
        end
    end  
end

