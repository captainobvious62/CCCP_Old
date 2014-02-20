
templates
general_settings





%Adjust time data to MATLAB readable format
start_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',start_year,start_month,start_day,start_minute,start_second);
end_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',end_year,end_month,end_day,end_minute,end_second);


    for template_count=1:length(template_list)
        template = template_list{template_count};     
        for station_count = 1:length(template)
            temp = template(station_count).template;
            network = template(station_count).network;
            station = template(station_count).station;
            if strcmp(template(station_count).trigger,'S') == 1
                date = datenum(template(station_count).sWaveArrival);
                date = datestr(date,29);
                date = datestr(datenum(date),30);
            elseif strcmp(template(station_count).trigger,'P') == 1
                date = datenum(template(station_count).pWaveArrival);
                date = datestr(date,29);
                date = datestr(datenum(date),30);
            end
            CC_Stacked_savename = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,temp,station,date);
            load(CC_Stacked_savename);
            data = get(Stacked_CC,'data');
            threshold = 9*mad(data);
            freq = get(Stacked_CC,'freq');
            [PeakCorr,PeakIndex] = getpeaks(data,'NPEAKS',1);
            template(station_count).MoveOut = PeakIndex/freq;
            template(station_count).PeakCorr = PeakCorr;
        end
        [corr, index] = sort([template(:).PeakCorr],'descend');
        template = template(index);
        first_break = template(1).MoveOut;
        for station_count = 1:length(template)
            template(station_count).MoveOut = template(station_count).MoveOut - first_break;
        end
        template_list{template_count} = template;
    end




