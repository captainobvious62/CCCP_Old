%CCCP
%Cross Correlation Stack
%Stacks All Stations All Channels for a template
%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m


%Notes - Program has a weird wrap around problem that I dont understand.
%Just ensure that scanned dates are one more day longer than actual.

template_data_input
general_settings
generateTemplates




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

%Failure Control
failure = 0;




%Loop over data for requested time and stack cross correlation functions

for time = start_date:CC_increment:(end_date-CC_increment)
    
    start_time = time;
    fprintf('Start time: %s\n',datestr(start_time));
    end_time = time + CC_increment;
    
    for template_count = 1:length(template_list(:,1))
        single_template = template_list(template_count,:);
        move_out_listing = template_move_out{1,template_count};
        move_out_times = move_out_listing{1};
        template = single_template(template_count).template;
        generate = 1;
        
        
        ALL_CC_Stacked_savename = sprintf('%s/%s/ALL_CC_Stacked_%s_%s.mat',base_folder,all_stack_folder,template,datestr(start_time,30));
        
        if exist(ALL_CC_Stacked_savename,'file') == 2
            load(ALL_CC_Stacked_savename)
            
            if isempty(ALL_Stacked_CC) == 1
                fprintf('%s %s\n',datestr(time),template);
                fprintf('Previous ALL Stacked Cross Correlation found\n');
                fprintf('%s found\n',ALL_CC_Stacked_savename);
                fprintf('Selected interval is empty\n');
            elseif isempty(ALL_Stacked_CC) == 0
                
                
                fprintf('%s %s\n',datestr(time),template);
                fprintf('Previous ALL Stacked Cross Correlation found\n');
                fprintf('%s found\n',ALL_CC_Stacked_savename);
                generate = 0;
            end
        end
        if generate == 1
            fprintf('%s %s\n',datestr(time),template);
            fprintf('Previous Total Stack not found\n');
            ALL_Stacked_CC =[];
            
            for station_count = 1:length(single_template);
                station_specific_template = single_template(station_count);
                station = station_specific_template.station;
                network = station_specific_template.network;
                template = station_specific_template.template;
                %Check to see if previous Stacked CC has been generated
                
                
                CC_Stacked_savename = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,template,station,datestr(start_time,30));
                CC_Stacked_following_day = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,template,station,datestr(end_time,30));
                
                
                if exist(CC_Stacked_savename,'file') == 2
                    
                    if exist(CC_Stacked_following_day,'file') == 0;
                        fprintf('%s NOT found\n',CC_Stacked_following_day);
                        fprintf('**************************************\n');
                        fprintf('*Running Single Station Stack Program*\n');
                        fprintf('**************************************\n');
                        CC_SingleStation_Stack
                        
                    else
                        load(CC_Stacked_savename);
                        fprintf('Stacked Cross Correlation loaded\n');
                        fprintf('Current day: %s\n',CC_Stacked_savename);
                        fprintf('   Next day: %s\n',CC_Stacked_following_day);
                        MO_start_time = get(Stacked_CC,'start') + move_out_times(station_count)/86400;
                        
                        MO_adjusted_CC = extract(Stacked_CC,'TIME',MO_start_time,end_time);
                        MO_adjusted_CC = set(MO_adjusted_CC,'start',start_time);
                        MO_adjusted_CC = set(MO_adjusted_CC,'network',network);
                        MO_adjusted_CC = set(MO_adjusted_CC,'location',location);
                        load(CC_Stacked_following_day);
                        
                        CC_Next = extract(Stacked_CC,'TIME',end_time,end_time+ move_out_times(station_count)/86400);
                        CC_Next = set(CC_Next,'start',end_time - move_out_times(station_count)/86400);
                        CC_Next = set(CC_Next,'network',network);
                        CC_Next = set(CC_Next,'location',location);
                        
                        Stacked_CC = combine([MO_adjusted_CC,CC_Next]);
                        Stacked_CC = set(Stacked_CC,'start',start_time);
                        Stacked_CC = extract(Stacked_CC,'TIME',start_time,end_time);
                        Stacked_CC = combine(Stacked_CC);
                        Stacked_CC = fillgaps(Stacked_CC,0);
                        size_check = 0;
                        
                        for Stacked_Count = 1:length(Stacked_CC)
                            Stacked_CC(Stacked_Count) = set(Stacked_CC(Stacked_Count),'network',network);
                            Stacked_CC(Stacked_Count) = set(Stacked_CC(Stacked_Count),'location',location);
                            if isempty(Stacked_CC(Stacked_Count)) == 1;
                                Stacked_CC(Stacked_Count) = [];
                                size_check = 1;
                            end
                        end
                        if size_check == 1;
                        else
                            Stacked_CC = combine(Stacked_CC);
                            Stacked_CC = fillgaps(Stacked_CC,0);
                        end
                    end
                    ALL_Stacked_CC =[ALL_Stacked_CC Stacked_CC];
                    repeat = 0;
                    
                else
                    fprintf('**************************************\n');
                    fprintf('*Running Single Station Stack Program*\n');
                    fprintf('**************************************\n');
                    CC_SingleStation_Stack
                end
            end
            if isempty(ALL_Stacked_CC) ~=1
                ALL_Stacked_CC = wave_stack(ALL_Stacked_CC);
            end
            save(ALL_CC_Stacked_savename,'ALL_Stacked_CC');
            fprintf('%s saved.\n',ALL_CC_Stacked_savename);
        end
    end
end
 





