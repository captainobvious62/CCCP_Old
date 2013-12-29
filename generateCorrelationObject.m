%CCCP
%Grab Correlation Object Script
%Code is optimized for Debian based Linux
%Grabs snippets from picks in events file
%Loads into correlation object
%At the moment, all correlations come from the BHZ component
%Need to include Template




%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m
template_data_input
general_settings

%Adjust time data to MATLAB readable format
start_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',start_year,start_month,start_day,start_minute,start_second);
end_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',end_year,end_month,end_day,end_minute,end_second);

%Check to ensure the proper flow of time
start_date = datenum(start_date);
end_date = datenum(end_date);
delta_time = end_date - start_date;
is_real = delta_time > 0;
if is_real == 0;
    fprintf('The Campaign for Real Time requests that you please ensure that your ending date follows your starting date. \n');
end





directory_check = sprintf('./%s/%s',base_folder,correlation_object_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Correlation object directory created \n');
end
event_match_matlab = sprintf('./%s/%s/TEL_%s_to_%s_events.mat',base_folder,result_folder,datestr(start_date),datestr(end_date));
load(event_match_matlab);
fprintf('Event listing loaded\n');


%Narrowing down focus to individual stations and channels
for template_count = 1:length(template_list(:,1));
    single_template = template_list(template_count,:);
    
    
    for station_count = 1:length(single_template);
        station_specific_template = single_template(station_count);
        
        template = station_specific_template.template;
        station = station_specific_template.station;
        network = station_specific_template.network;
        phase = station_specific_template.trigger;
        channel = correlation_channel;
        fprintf('Template: %s\n',template);
        fprintf('Station: %s\n',station);
        fprintf('Network: %s\n',network);
        fprintf('Phase: %s\n',phase);
        fprintf('Correlating Channel: %s\n',channel);
        
        
        correlation_object_savename = sprintf('./%s/%s/CO_%s_%s_%s_%s',base_folder,correlation_object_folder,template,phase,station,channel);
        correlation_object = correlation();
        pick_number = 0;
        
        for events_count = 2:length(events)
            if strcmp(events(events_count,6),station) == 1 && strcmp(events(events_count,8),template) == 1 && strcmp(events(events_count,9),phase) == 1
                pick_time = events{events_count,4};
                if phase == 'P'
                    before_time = before_P_Wave;
                    after_time = after_P_Wave;
                elseif phase == 'S'
                    before_time = before_S_Wave;
                    after_time = after_S_Wave;
                end
                starttime = pick_time - (before_time/86400);
                endtime = pick_time + (after_time/86400);
                WF_Snippet = waveform();
                while isempty(WF_Snippet) == 1
                    try
                        fprintf('Downloading template\n')
                        WF_Snippet = irisFetch.Traces(network,station,location, channel, starttime, endtime,'verbose','includePZ');
                        WF_Snippet = convertTraces(WF_Snippet);                      
                    catch exception
                        fprintf('Trying again....\n');
                    end
                end
                
                %Not sure if we just want to add a filter function later
                %and not filter it in situ
                WF_Snippet = fillgaps(WF_Snippet,0);
                WF_Snippet = removeIR(WF_Snippet);
                WF_Snippet = filter_waveform_BP(WF_Snippet,lower_band,upper_band);
                WF_Snippet = addfield(WF_Snippet,'Rel_MAD',events{events_count,11});
                WF_Snippet = addfield(WF_Snippet,'Phase',events{events_count,9});
                WF_Snippet = correlation(WF_Snippet);
                if pick_number == 0;
                    correlation_object = WF_Snippet;
                else
                    correlation_object = cat(correlation_object,WF_Snippet);
                end
                pick_number = pick_number + 1;
            end
            
        end
        if pick_number == 0;
            fprintf('No events found\n');
        else
            save(correlation_object_savename,'correlation_object');
            fprintf('Correlation object %s saved.\n',correlation_object_savename);
        end
    end
       
end

