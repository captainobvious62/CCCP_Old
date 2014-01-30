%CCCP
%Arrival Time Picker
%Adjusts snippets and determines arrivals


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
        numberofchannels = length(station_specific_template.channel_list);
        template = station_specific_template.template;
        station = station_specific_template.station;
        network = station_specific_template.network;
        phase = station_specific_template.trigger;
        
        for chan_count = 1:numberofchannels
            channel = station_specific_template.channel_list{chan_count};
            fprintf('Template: %s\n',template);
            fprintf('Station: %s\n',station);
            fprintf('Network: %s\n',network);
            fprintf('Phase: %s\n',phase);
            fprintf('Correlating Channel: %s\n',channel);
            fprintf('Operation Time/Date: %s\n',datestr(clock));
            correlation_object_savename = sprintf('./%s/%s/CO_%s_%s_%s_%s',base_folder,correlation_object_folder,template,phase,station,channel);
            adjusted_correlation_object_savename = sprintf('./%s/%s/Adjusted_CO_%s_%s_%s_%s',base_folder,correlation_object_folder,template,phase,station,channel);
            load(correlation_object_savename);
            C = correlation_object;
            template_waveform = waveform(C,get(correlation_object,'Traces'));
            
            row = 2;
            %Need to change this for universal channel use
            if strcmp(channel,'BHE') == 1 || strcmp(channel,'BH1') == 1
                
                arrivals  = 'S';
                template_waveform = correlation(template_waveform);
                sWaveArrival = station_specific_template.sWaveArrival;
                timeAdjust = cat(C,template_waveform);
                timeAdjust = xcorr(timeAdjust);
                %timeAdjust = xcorr(timeAdjust,'interp');
                timeAdjust = adjusttrig(timeAdjust,'index');
                S_Arrivals_E = datestr(get(timeAdjust,'trig'),'yyyy-mm-dd HH:MM:SS.FFF');
                
            elseif strcmp(channel,'BHN') == 1|| strcmp(channel,'BH2') == 1;
                arrivals = 'S';
                template_waveform = correlation(template_waveform);
                sWaveArrival = station_specific_template.sWaveArrival;
                timeAdjust = cat(C,template_waveform);
                timeAdjust = xcorr(timeAdjust);
                %timeAdjust = xcorr(timeAdjust,'interp');
                timeAdjust = adjusttrig(timeAdjust,'index');
                S_Arrivals_N = datestr(get(timeAdjust,'trig'),'yyyy-mm-dd HH:MM:SS.FFF');
                
            elseif strcmp(channel,'BHZ') == 1
                arrivals = 'P';
                template_waveform = correlation(template_waveform);
                sWaveArrival = station_specific_template.sWaveArrival;
                timeAdjust = cat(C,template_waveform);
                timeAdjust = xcorr(timeAdjust);
                %timeAdjust = xcorr(timeAdjust,'interp');
                timeAdjust = adjusttrig(timeAdjust,'index');
                P_Arrivals_Z = datestr(get(timeAdjust,'trig'),'yyyy-mm-dd HH:MM:SS.FFF');
            end

            
            
            save(adjusted_correlation_object_savename,'timeAdjust');
        end
        SE_SN_PZ_Arrivals = {{'BHE/1 (S)', 'BHN/2 (S)', 'BHZ (P)'};{S_Arrivals_E,S_Arrivals_N,P_Arrivals_Z}};
        arrivals_savename = sprintf('./%s/%s/%s_%s_%s_to_%s_events.mat',base_folder,result_folder,template,station,datestr(start_date),datestr(end_date));
        save(arrivals_savename,'SE_SN_PZ_Arrivals');
        
    end
end


