%CCCP
%Template Run



starttime = '2011-03-17 10:50:00';
endtime = '2011-03-17 11:00:00';
radius = 5;%Degrees
channel = 'BHZ';
longitude = -80.69;
latitude = 41.11;

[list, closest_station] = radialStationFinder(starttime,endtime,radius,channel,longitude,latitude)

snip = templatePickGather(list,closest_station,starttime,endtime,channel);
snip = filter_waveform_BP(snip,1,100);

plot(snip,'xunit','date')
datetick('x','HH:MM:SS.FFF')

fprintf('Please Pick Arrival Times\n')
eventPWave = '2011-03-17 10:53:20.075';
eventSWave =  '2011-03-17 10:53:27.325';
before_time = 30;%s
after_time = 30;%s
lower_band = 1
upper_band = 100
pick_number = 0;
for i = 1:length(list)
    station = list(i).StationCode;
    network = list(i).NetworkCode;
    location = '*';
    match_starttime = datenum(eventSWave) - (before_time/86400);
    match_endtime = datenum(eventSWave) + (after_time/86400);
    WF_Snippet = waveform();
    counts = 0;
    
%     if strcmp(network,'US') == 1
%         if strcmp(channel,'BHE') == 1 || strcmp(channel,'BH1') == 1
%             check_savename = sprintf('%s/%s/DATA_%s_%s.mat',base_folder,check_folder,station,'BHE');
%             load(check_savename);
%             if time < datenum(check.Channels(1,1).EndDate)
%                 channel = 'BHE';
%             elseif time > datenum(check.Channels(1,1).EndDate)
%                 channel = 'BH1';
%             end;
%         end
%         if strcmp(channel,'BHN') == 1 || strcmp(channel,'BH2') == 1;
%             check_savename = sprintf('%s/%s/DATA_%s_%s.mat',base_folder,check_folder,station,'BHE');
%             load(check_savename);
%             
%             if time < datenum(check.Channels(1,1).EndDate)
%                 channel = 'BHN';
%             elseif time > datenum(check.Channels(1,1).EndDate)
%                 channel = 'BH2';
%             end
%         end
%     end
    while isempty(WF_Snippet) == 1
        try
            fprintf('Downloading trace\n')
            WF_Snippet = irisFetch.Traces(network,station,location, channel, datestr(match_starttime), datestr(match_endtime),'verbose','includePZ');
            WF_Snippet = convertTracesRM_IR(WF_Snippet);
        catch exception
            fprintf('Trying again....\n');
        end
        if counts > 4;
            break
        end
        counts = counts + 1;
    end
    if isempty(WF_Snippet) == 1
        fprintf('No Data\n');
    else
        %Not sure if we just want to add a filter function later
        %and not filter it in situ
        WF_Snippet = fillgaps(WF_Snippet,0);
        WF_Snippet = filter_waveform_BP(WF_Snippet,lower_band,upper_band);
        WF_Snippet = correlation(WF_Snippet);
        
        if pick_number == 0;
            correlation_object = WF_Snippet;
        else
            correlation_object = cat(correlation_object,WF_Snippet);
        end
        pick_number = pick_number + 1;
    end
end
