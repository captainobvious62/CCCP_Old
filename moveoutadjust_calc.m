function MO = moveoutadjust_calc(template_list,trigger)


for i = 1:length(template_list)
    if i == 1;
        P_initial = datenum(template_list(i).pWaveArrival);
        S_initial = datenum(template_list(i).sWaveArrival);
    else
        if P_initial > datenum(template_list(i).pWaveArrival)
            P_initial = datenum(template_list(i).pWaveArrival);
        end
        if S_initial > datenum(template_list(i).sWaveArrival)
            S_initial = datenum(template_list(i).sWaveArrival);
        end
    end
end
for j = 1:length(template_list)
    template_list(j).PmoveOut = (datenum(template_list(j).pWaveArrival))*86400 - P_initial*86400;
    template_list(j).SmoveOut = (datenum(template_list(j).sWaveArrival))*86400 - S_initial*86400;
end
if strcmp(trigger,'P') == 1
    [MO_val, index] = sort([template_list(:).PmoveOut],'ascend');
    MO = template_list(index);
elseif strcmp(trigger,'S') == 1
    [MO, index] = sort([template_list(:).SmoveOut],'ascend');
    MO = template_list(index);
end;
