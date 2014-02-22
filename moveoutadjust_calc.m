function MO = moveoutadjust_calc(base_folder,station_stack_folder,template_list,trigger)


for i = 1:length(template_list)
    template = template_list(i).template;
    station = template_list(i).station;
    if strcmp(template_list(i).trigger,'S') == 1
        date = datenum(template_list(i).sWaveArrival);
        date = datestr(date,29);
        date = datestr(datenum(date),30);
    elseif strcmp(template_list(i).trigger,'P') == 1
        date = datenum(template_list(i).pWaveArrival);
        date = datestr(date,29);
        date = datestr(datenum(date),30);
    end
    CC_Stacked_savename = sprintf('%s/%s/CC_Stacked_%s_%s_%s.mat',base_folder,station_stack_folder,template,station,date);
    load(CC_Stacked_savename);
    data = get(Stacked_CC,'data');
    freq = get(Stacked_CC,'freq');
    [PeakCorr,PeakIndex] = getpeaks(data,'NPEAKS',1);
    template_list(i).MoveOut = PeakIndex/freq;
    template_list(i).PeakCorr = PeakCorr;
    fprintf('%s\n',template_list(i).station);
    fprintf('%d\n',PeakIndex/freq);
end
[corr, index] = sort([template_list(:).MoveOut],'ascend');
template_list = template_list(index);
first_break = template_list(1).MoveOut;
for i = 1:length(template_list)
    template_list(i).MoveOut = template_list(i).MoveOut - first_break;
end

MO = template_list;
end