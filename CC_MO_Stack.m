%CCCP
%Cross Correlation Stack
%Stacks Cross Correlations for ONE station
%Read in written/generated template data from file
%all input parameters are modifiable in template_data_input.m
%all general parameters are modifiable in general_settings.m

templates
general_settings

directory_check = sprintf('./%s/%s',base_folder,template_stack_folder);
if exist(directory_check,'dir') ~= 7;
    mkdir(directory_check);
    fprintf('Template Stacked Cross Correlation directory created \n');
end

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

%Failure Control
failure = 0;


%Replace this with a function
%CC_Move_Out_Adjust

%Loop over data for requested time and stack cross correlation functions




for time = start_date:CC_increment:end_date
    
    start_time = time;
    end_time = time + CC_increment;
    fprintf('Start Time: %s\n',datestr(start_time));
    fprintf('End Time: %s\n',datestr(end_time));
    fprintf('Operation Time/Date: %s\n',datestr(clock));
    
    
    for template_count = 1:length(template_list)
        single_template = template_list{template_count};
        single_template = moveoutadjust_calc(base_folder,station_stack_folder,single_template,trigger);
        Multi_Stack = [];
        
        for station_count = 1:length(single_template);
            station_specific_template = single_template(station_count);
            numberofchannels = length(station_specific_template.channel_list);
            template = station_specific_template.template;
            station = station_specific_template.station;
            network = station_specific_template.network;
            template_stack_savename = sprintf('%s/%s/CC_Template_Stacked_%s_%s.mat',base_folder,template_stack_folder,template,datestr(start_time,30));
            offset = station_specific_template.MoveOut;
            CC_Stacked_savename = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,template,station,datestr(start_time,30));
            load(CC_Stacked_savename);
            fprintf('%s loaded\n',CC_Stacked_savename);
            Stacked_CC = fillgaps(Stacked_CC,0);
            Stacked_CC = set(Stacked_CC,'start',start_time - offset/86400);
            Stacked_CC = set(Stacked_CC,'station','Multi-Stack');
            Stacked_CC = set(Stacked_CC,'network','--');
            Multi_Stack = [Multi_Stack Stacked_CC];
        end
        Control = Multi_Stack;
        Multi_Stack = stack(Multi_Stack);
        save(template_stack_savename,'Multi_Stack');
        fprintf('%s saved\n',template_stack_savename);
        fprintf(' \n');
    end
end




















%
%         if isempty(Stacked_CC) == 0;
%             fprintf('Stacked Cross Correlation %s found\n',CC_Stacked_savename);
%             CC_EXIST = 1;
%         end
%     end
%     if CC_EXIST == 0;
%         Stacked_CC = [];
%         for chan_count = 1:numberofchannels
%             channel = station_specific_template.channel_list{chan_count};
%
%             %Filenames for saved components
%             %Dates represent start time
%             CC_savename = sprintf('%s/%s/CC_%s_%s_%s_%s.mat',base_folder,crosscorrelation_folder,template,station,channel,datestr(start_time,30));
%             repeat = 1;
%             while repeat == 1;
%
%                 if exist(CC_savename,'file') == 2
%                     load(CC_savename);
%                     fprintf('Cross Correlation %s loaded\n',CC_savename);
%
%                     Stacked_CC = fillgaps(CC,0);
%
%                     if length(Stacked_CC) > 1
%                         for Stacked_Count = 1:length(Stacked_CC)
%                             Stacked_CC(Stacked_Count) = set(Stacked_CC(Stacked_Count),'network',network);
%                             Stacked_CC(Stacked_Count) = set(Stacked_CC(Stacked_Count),'location',location);
%                         end
%                         Stacked_CC = combine(Stacked_CC);
%                         Stacked_CC = fillgaps(Stacked_CC,0);
%                     end
%                     Stacked_CC =[Stacked_CC CC];
%
%                     repeat = 0;
%                 else
%                     fprintf('***********************************\n');
%                     fprintf('*Running Cross Correlation Program*\n');
%                     fprintf('***********************************\n');
%                     CC_SingleChannel_Java
%                 end
%             end
%         end
%         Stacked_CC = waveform_stack(Stacked_CC);
%         save(CC_Stacked_savename,'Stacked_CC');
%         fprintf('%s saved.\n',CC_Stacked_savename);
%
%     end
% end
% end
% end
%
%
