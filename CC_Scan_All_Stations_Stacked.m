%CCCP
%Scan All Stacked Cross Correlations
%Scans stacks of cross correlations from all components, all stations
%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m


%Load data about templates
templates
%Load control Settings
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
directory_check = sprintf('./%s/%s',base_folder,all_stack_folder);
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
All_event_listing_savename = sprintf('./%s/%s_to_%s_events_All_stacks',base_folder,datestr(start_date),datestr(end_date));
events = {'Time Index', 'CC Value','Time (UTC)','MATLAB Time','Threshold Value','Template'};
row = 2;
total_detections = 0;


for time = start_date:CC_increment:end_date
    
    start_time = time;
    end_time = time + CC_increment;
    if end_time >= end_date
        end_time = end_date;
    end
    
    for template_count = 1:length(template_list(:,1))
        single_template = template_list{template_count};
        template = single_template(template_count).template;
        ALL_CC_Stacked_savename = sprintf('%s/%s/CC_Template_Stacked_%s_%s.mat',base_folder,template_stack_folder,template,datestr(start_time,30));
        
%         repeat = 1;
        %Check each day for found events
        %         while repeat == 1;
        %Check to see if the stacked cross correlation file exists
        %             if exist(ALL_CC_Stacked_savename,'file') == 0
        %                 while exist(ALL_CC_Stacked_savename,'file') == 0
        %                     fprintf('%s %s\n',datestr(time),template);
        %                     fprintf('Previous ALL Stacked Cross Correlation NOT found\n');
        %                     fprintf('Running Stacking Program\n');
        %                     CC_All_Stack
        %                 end
        %             elseif exist(ALL_CC_Stacked_savename,'file') == 2
                        fprintf('%s %s\n',datestr(time),template);
                        fprintf('Previous ALL Stacked Cross Correlation found\n');
                        load(ALL_CC_Stacked_savename);
        %                 %Check to see that the stacked cross correlation file has
        %                 %data
        %                 if isempty(ALL_Stacked_CC) == 1
        %                     while isempty(ALL_Stacked_CC) == 1
        %                         fprintf('%s %s\n',datestr(time),template);
        %                         fprintf('Previous ALL Stacked Cross Correlation is empty\n');
        %                         fprintf('Running Stacking Program\n');
        %                         CC_All_Stack
        %                     end
        %                 end
        
        data = get(Multi_Stack,'data'); %Review CC for prospects
        threshold = 9*mad(data);
        freq = get(Multi_Stack,'freq');
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
                events{row,6} = template;
                row = row + 1;
                detections = detections + 1;
                total_detections = total_detections + 1;
            end
        end
        fprintf('%d events detected\n',detections);
        fprintf('%d total events detected\n',total_detections);
        repeat = 0;
        
        
    end
end

save(All_event_listing_savename,'events');
%Use dlmcell to spit out a text file
text_savename = sprintf('%s/%s/%s_%s_to_%s_multiple_station.csv',base_folder,result_folder,template,start_date,end_date);
dlmcell(text_savename,events,',');
fprintf('%s saved\n',All_event_listing_savename);
















