%CCCP
%Scan Stacked Cross Correlations
%Scans stacked three component cross correlations
%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m

templates
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

%Check for directory structure
directory_check = sprintf('./%s/%s',base_folder,station_stack_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Cross Correlation directory created \n');
end
directory_check = sprintf('./%s/%s',base_folder,waveform_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Waveform directory created \n');
end
directory_check = sprintf('./%s/%s',base_folder,result_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Result directory created \n');
end




%Failure Control
failure = 0;




%Loop over data for requested time and stack cross correlation functions
event_match_printout = sprintf('./%s/%s/TEL_%s_to_%s_events.csv',base_folder,result_folder,datestr(start_date),datestr(end_date));
event_match_matlab = sprintf('./%s/%s/TEL_%s_to_%s_events.mat',base_folder,result_folder,datestr(start_date),datestr(end_date));
events = {'Time Index', 'CC Value','Time (UTC)','MATLAB Time','Threshold Value','Station','Network','Template', 'Phase','MAD','CC Relation to MAD'};
row = 2;
repeat = 1;
total_detections = 0;



for template_count = 1:length(template_list(:,1))
    single_template = template_list{template_count};
    template_events = {'Time Index', 'CC Value','Time (UTC)','MATLAB Time','Threshold Value','Station','Network','Template', 'Phase','MAD','CC Relation to MAD'};
    template_row = 2;
    template_detections = 0;
    total_event_number = {};
    
    
    for station_count = 1:length(single_template);
        
        
        station_specific_template = single_template(station_count);
        numberofchannels = length(station_specific_template.channel_list);
        template = station_specific_template.template;
        station = station_specific_template.station;
        network = station_specific_template.network;
        phase = station_specific_template.trigger;
        
        station_match_printout = sprintf('%s/%s/%s_%s_to_%s_%s_events.csv',base_folder,result_folder,template,datestr(start_date),datestr(end_date),station);
        station_match_matlab = sprintf('%s/%s/%s_%s_to_%s_%s_events.mat',base_folder,result_folder,template,datestr(start_date),datestr(end_date),station);
        station_events = {'Time Index', 'CC Value','Time (UTC)','MATLAB Time','Threshold Value','Station','Network','Template', 'Phase','MAD','CC Relation to MAD'};
        station_row = 2;
        station_detections = 0;
        
        
        %Check to see if previous Stacked CC has been generated
        
        for time = start_date:CC_increment:end_date
            
            start_time = time;
            end_time = time + CC_increment;
            fprintf('Start Time: %s\n',datestr(start_time));
            fprintf('End Time: %s\n',datestr(end_time));
            fprintf('Operation Time/Date: %s\n',datestr(clock));
            CC_Stacked_savename = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,template,station,datestr(start_time,30));
            if exist(CC_Stacked_savename,'file') == 2
                fprintf('Previous Stacked Cross Correlation found\n');
                fprintf('%s %s %s\n',datestr(time),template,station);
                load(CC_Stacked_savename);
                data = get(Stacked_CC,'data'); %Review CC for prospects
                threshold = 9*mad(data);
                freq = get(Stacked_CC,'freq');
                [PeakCorr,PeakIndex] = getpeaks(data,'NPEAKS',candidates);
                TimeIndex = PeakIndex/freq;
                DisplayTime = time;
                detections = 0;
                for z = 1:candidates
                    
                    if PeakCorr(z) >= threshold
                        DisplayTime = time + (TimeIndex(z)/(60*60*24));
                        events{row,1} = TimeIndex(z);
                        events{row,2} = PeakCorr(z);
                        events{row,3} = datestr(DisplayTime,'dd mmmm yyyy HH:MM:SS.FFF');
                        events{row,4} = DisplayTime;
                        events{row,5} = threshold;
                        events{row,6} = station;
                        events{row,7} = network;
                        events{row,8} = template;
                        events{row,9} = phase;
                        events{row,10} = threshold/9;
                        events{row,11} = PeakCorr(z)/(threshold/9);
                        station_events{station_row,1} = TimeIndex(z);
                        station_events{station_row,2} = PeakCorr(z);
                        station_events{station_row,3} = datestr(DisplayTime,'dd mmmm yyyy HH:MM:SS.FFF');
                        station_events{station_row,4} = DisplayTime;
                        station_events{station_row,5} = threshold;
                        station_events{station_row,6} = station;
                        station_events{station_row,7} = network;
                        station_events{station_row,8} = template;
                        station_events{station_row,9} = phase;
                        station_events{station_row,10} = threshold/9;
                        station_events{station_row,11} = PeakCorr(z)/(threshold/9);
                        template_events{template_row,1} = TimeIndex(z);
                        template_events{template_row,2} = PeakCorr(z);
                        template_events{template_row,3} = datestr(DisplayTime,'dd mmmm yyyy HH:MM:SS.FFF');
                        template_events{template_row,4} = DisplayTime;
                        template_events{template_row,5} = threshold;
                        template_events{template_row,6} = station;
                        template_events{template_row,7} = network;
                        template_events{template_row,8} = template;
                        template_events{template_row,9} = phase;
                        template_events{template_row,10} = threshold/9;
                        template_events{template_row,11} = PeakCorr(z)/(threshold/9);
                        
                        
                        row = row + 1;
                        station_row = station_row + 1;
                        template_row = template_row + 1;
                        detections = detections + 1;
                        station_detections = station_detections + 1;
                        template_detections = template_detections + 1;
                        total_detections = total_detections + 1;
                    end
                end
                fprintf('%d events detected\n',detections);
                fprintf('%d events detected for station %s\n',station_detections,station);
                fprintf('%d events detected for template %s\n',template_detections,template);
                fprintf('%d total events detected\n',total_detections);
                repeat = 0;
            else
                %If the stacked cross correlation have not be
                %generated, run the program to generate them.
                fprintf('Running Single Station Stack Program\n');
                CC_SingleStation_Stack
            end
            
            
        end
        save(station_match_matlab,'station_events');
        fprintf('%s saved\n',station_match_matlab);
        dlmcell(station_match_printout,station_events,',');
        fprintf('Printout %s saved\n',station_match_printout);
        total_event_number = [total_event_number {station;station_detections}];
        
    end
    template_match_matlab = sprintf('./%s/%s/%s_%s_to_%s_events.mat',base_folder,result_folder,template,datestr(start_date),datestr(end_date));
    save(template_match_matlab,'template_events');
    fprintf('%s saved\n',event_match_matlab);
    %Use dlmcell to spit out a text file
    template_match_printout = sprintf('%s/%s/%s_%s_to_%s.csv',base_folder,result_folder,template,start_date,end_date);
    dlmcell(template_match_printout,template_events,',');
    fprintf('Printout %s saved\n',template_match_printout);
    
end
    save(event_match_matlab,'events');
    fprintf('%s saved\n',event_match_matlab);
    %Use dlmcell to spit out a text file
    dlmcell(event_match_printout,events,',');
    fprintf('Printout %s saved\n',event_match_printout);
















%         save(savename_Overall,'overall');
%
%         if grab_snippets == 0
%             new_cor = 0;
%             list = numel(events(:,3));
%             for K = 2:list
%                 d = events{K,2};
%                 Mth = M;
%                 start = events{K,3}/24/3600;
%                 time = datestr(start,'HH:MM:SS.FFF');
%                 ending = events{K,3} + 20;
%                 if ending > 86400
%                     d = d +1;
%                     if d > MCount(Mth),
%                         Mth = MOrder(Mth) + 1;
%                         d = 1;
%                     end
%                 end
%
%                 ending = ending/24/3600;
%                 endmoment = datestr(ending,'HH:MM:SS.FFF');
%                 starttime = sprintf('2011-%02d-%02d %s',Mth,d,time);
%                 endtime = sprintf('2011-%02d-%02d %s',Mth,d,endmoment);
%                 WF_trace = irisFetch.Traces(network, station, location, channel, starttime,endtime,'verbose');
%                 WF = waveform(WF_trace.station, WF_trace.channel,WF_trace.sampleRate,WF_trace.startTime,WF_trace.data);
%                 WF = fillgaps(WF,0);
%                 WF = filtfilt(filter,WF);
%                 WF = set(WF,'network',network);
%                 new_correl = correlation(WF);
%                 if new_cor == 0;
%                     correl = new_correl;
%                     new_cor = new_cor + 1;
%                 else
%                     correl = cat(correl,new_correl);
%                 end
%             end
%             savename_Correlation = sprintf('Seismic/XC/Correlation_Stack_2011_%02d_%s_%s_%s.mat',M,station,channel,template);
%             save(savename_Correlation,'correl');
%         end


