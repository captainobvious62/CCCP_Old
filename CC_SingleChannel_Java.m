%CCCP
%JAVA-WS Cross Correlation
%Generates Cross Correlation function for a single channel of a single
%station of a single template
%If data is not found for a requested time interval, a daylong waveform placeholder of zeros is created.

%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m

template_data_input
general_settings

%Run script to gather station background data
reviewChannels



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

%Check for directory structure
directory_check = sprintf('./%s/%s',base_folder,crosscorrelation_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Cross Correlation directory created \n');
end
directory_check = sprintf('./%s/%s',base_folder,waveform_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Waveform directory created \n');
end

%Failure Control
failure = 0;




%Loop over data for requested time and generate cross correlation functions

for time = start_date:CC_increment:end_date
    
    start_time = time;
    fprintf('%s\n',datestr(time));
    end_time = time + CC_increment;
    fprintf('Start Time: %s\n',datestr(start_time));
    fprintf('End Time: %s\n',datestr(end_time));
    
    for template_count = 1:length(template_list(:,1))
        single_template = template_list(template_count,:);
        
        
        for station_count = 1:length(single_template);
            station_specific_template = single_template(station_count);
            numberofchannels = length(station_specific_template.channel_list);
            template = station_specific_template.template;
            station = station_specific_template.station;
            network = station_specific_template.network;
            
            
            for chan_count = 1:numberofchannels
                channel = station_specific_template.channel_list{chan_count};
                %For idiot IRIS Stations only
                
                
                %Filenames for saved components
                %Dates represent start time
                CC_savename = sprintf('%s/%s/CC_%s_%s_%s_%s.mat',base_folder,crosscorrelation_folder,template,station,channel,datestr(start_time,30));
                WF_savename = sprintf('%s/%s/WF_Virgin_%s_%s_%s.mat',base_folder,waveform_folder,station,channel,datestr(start_time,30));
                template_savename = sprintf('%s/%s/%s_%s_%s.mat',base_folder,template_folder,template,station,channel);
                
                if strcmp(network,'US') == 1
                    check_savename = sprintf('%s/%s/DATA_%s_%s.mat',base_folder,check_folder,station,channel);
                    load(check_savename);
                    if strcmp(channel,'BHE') == 1
                        if time > datenum(check.Channels(1,1).EndDate)
                            channel = 'BH1';
                        end
                    end
                    if strcmp(channel,'BHN') == 1
                        if time > datenum(check.Channels(1,1).EndDate)
                            channel = 'BH2';
                        end
                    end
                    if strcmp(channel,'BH1') == 1
                        if time < datenum(check.Channels(1,1).EndDate)
                            channel = 'BHE';
                        end
                    end
                    if strcmp(channel,'BH2') == 1
                        if time < datenum(check.Channels(1,1).EndDate)
                            channel = 'BHN';
                        end
                    end
                end
                %End idiot IRIS compensation (US Stations change from BHE/BHN/BHZ to BH1/BH2/BHZ in the middle of 2011)
                
                
                
                %Check to see if previous CC has been generated
                CC_EXIST = 0;
                if exist(CC_savename,'file') == 2
                    load(CC_savename);
                    if isempty(CC) == 0;
                        fprintf('%s Cross Correlation found\n',CC_savename);
                        CC_EXIST = 1;
                    end
                end
                if CC_EXIST == 0;
                    
                    load(template_savename);
                    fprintf('Template %s loaded.\n',template_savename);
                    %Check to see if waveform has been downloaded before
                    if exist(WF_savename,'file') == 2
                        fprintf('Previously saved waveform found\n');
                        load(WF_savename);
                        fprintf('Previously saved waveform loaded\n');
                        WF = combine(WF);
                        WF = fillgaps(WF,0);
                        WF = filter_waveform_BP(WF,lower_band,upper_band);
                        [WF,CC] = mastercorr_scan(WF,wf_Temp,0.3);
                        CC = addfield(CC,'isCrossCorrelation', true);
                        CC = fillgaps(CC,0);
                        CC = set(CC,'location',location);
                        CC = set(CC,'network',network);
                        CC = set(CC,'channel',channel);
                        save(CC_savename,'CC');
                        fprintf('%s saved.\n',CC_savename);
                        
                        
                    else
                        WF = waveform();
                        tries = 0;
                        failure = 0;
                        %Check to see if daata exists for the desired
                        %time interval
                        
                        
                        while isempty(WF) == 1
                            
                            if check_uptime(station,network,channel,location,time) == 1;
                                try
                                    WF_trace = irisFetch.Traces(network, station, location, channel, start_time, end_time,'verbose','includePZ');
                                    WF = convertTraces(WF_trace);
                                catch exception
                                    if tries >= 3;
                                        fprintf('Guess it is not there....\n');
                                        WF = waveform(station,channel,check.Channels(1).SampleRate, start_time, zeros((86400*check.Channels(1).SampleRate),1));                                            failure = 1;
                                        failure = 1;
                                    end
                                    tries = tries +1;
                                end
                            elseif check_uptime(station,network,channel,location,time) == 0;
                                fprintf('No data for requested interval\n');
                                failure = 1;
                                WF = waveform(station,channel,check.Channels(1).SampleRate, start_time, zeros((86400*check.Channels(1).SampleRate),1));
                            end
                        end
                        if failure == 0;
                            WF = combine(WF);
                            WF = fillgaps(WF,0);
                            %Test of new filter function to enable use
                            %of varied sensitivities
                            WF = filter_waveform_BP(WF,lower_band,upper_band);
                            save(WF_savename,'WF');
                            fprintf('%s saved.\n',WF_savename);
                        elseif failure == 1;
                            save(WF_savename,'WF');
                            fprintf('Placeholder(zeros) %s saved.\n',WF_savename);
                            CC = WF;
                            save(CC_savename,'CC');
                            fprintf('Placeholder(zeros) %s saved.\n',CC_savename);
                        end
                    end
                    if failure == 0;
                        [WF,CC] = mastercorr_scan(WF,wf_Temp,Master_CC_Scan_Threshold);
                        CC = addfield(CC,'isCrossCorrelation', true);
                        CC = fillgaps(CC,0);
                        CC = set(CC,'location',location);
                        CC = set(CC,'network',network);
                        CC = set(CC,'channel',channel);
                        save(CC_savename,'CC');
                        fprintf('%s saved.\n',CC_savename);
                    else
                        [WF,CC] = mastercorr_scan(WF,wf_Temp,0.3);
                        CC = addfield(CC,'isCrossCorrelation', true);
                        CC = fillgaps(CC,0);
                        CC = set(CC,'location',location);
                        CC = set(CC,'network',network);
                        CC = set(CC,'channel',channel);
                        save(CC_savename,'CC');
                        fprintf('Placeholder values saved\n');
                        fprintf('%s saved.\n',CC_savename);
                        
                    end
                end
            end
        end
    end
end




