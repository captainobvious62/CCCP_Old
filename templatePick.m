%CCCP
%Template Run
%For P Wave template generation, this function is little better than an
%educated guess


starttime = '2014-01-22 18:40:00';
endtime = '2014-01-22 18:45:00';
radius = 5;%Degrees
channel = 'BHZ';
longitude = -104.650;
latitude = 37.272;
phase_picked = 'P';




%%
%Vestigal stuff for US network

switch_date = '2011-05-02 00:00:00';
time = datenum(starttime);
if strcmp(network,'US') == 1
    
    if strcmp(channel,'BHE') == 1
        if time > datenum(switch_date)
            channel = 'BH1';
        end;
    end
    if strcmp(channel,'BHN') == 1
        if time > datenum(switch_date)
            channel = 'BH2';
        end
    end
    if strcmp(channel,'BH1') == 1
        if time < datenum(switch_date)
            channel = 'BHE';
        end
    end
    if strcmp(channel,'BH2') == 1
        if time < datenum(switch_date)
            channel = 'BHN';
        end
    end
end


[list, closest_station] = radialStationFinder(starttime,endtime,radius,channel,longitude,latitude)

snip = templatePickGather(list,closest_station,starttime,endtime,channel);
snip = filter_waveform_BP(snip,1,100);


%%
%Plot initial results
plot(snip,'xunit','date')
datetick('x','HH:MM:SS.FFF')


%User determined (or USGS) arrivals


fprintf('Please Pick Arrival Times\n')
eventPWave = '2014-01-22 18:40:39.86';
eventSWave =  '2014-01-22 18:40:42.59';



if strcmp(phase_picked,'P') == 1
    before_time = 10/86400;%s
    after_time = 80/86400;%s
elseif strcmp(phase_picked,'S') == 1
    before_time = 40/86400;%s
    after_time = 80/86400;%s
end




lower_band = 1;
upper_band = 100;
location = '*';


template_snippet = [];
while isempty(template_snippet) == 1
    try
        template_snippet = irisFetch.Traces(closest_station.NetworkCode,closest_station.StationCode,location, channel, datestr(datenum(eventSWave) - before_time), datestr(datenum(eventSWave) + after_time),'verbose','includePZ');
    catch exception
    end
end
template_snippet = convertTracesRM_IR(template_snippet);
template_snippet = filter_waveform_BP(template_snippet,lower_band,upper_band);
match_starttime = datenum(eventSWave) - (before_time);
match_endtime = datenum(eventSWave) + (after_time);
base_rate = closest_station.Channels.SampleRate;
template_snippet = addfield(template_snippet,'Rad_Dist',deg2km(list(length(list)).radialDistance));
template_snippet = addfield(template_snippet, 'POI_Azimuth', list(length(list)).azimuth);
template_snippet = addfield(template_snippet,'Elevation',list(length(list)).Elevation);



pick_number = 0;
for i = 1:(length(list)-1)
    station = list(i).StationCode;
    network = list(i).NetworkCode;
    
    
    %For this, we are just going to assume that only one channel will be
    %addressed at a time. This takes care of figuring out what the inane
    %location values are
    
    %Right now, we are just dumping the seismometers with different sample
    %rates. Will figure out how to deal with this.
    
    %To incorporate: Resampling
    equal_freq = 0;
    for j = 1: length(list(i).Channels)
        if list(i).Channels(j).SampleRate == base_rate
            location = list(i).Channels(j).LocationCode;
            channel = list(i).Channels(j).ChannelCode;
            equal_freq = 1;
        end
    end
    if equal_freq == 1;
        WF_Snippet = waveform();
        counts = 0;
        
        
        
        while isempty(WF_Snippet) == 1
            try
                fprintf('Downloading trace\n')
                WF_Snippet = irisFetch.Traces(network,station,location, channel, datestr(match_starttime), datestr(match_endtime),'verbose','includePZ');
                
            catch exception
                fprintf('Trying again....\n');
            end
            if counts > 4;
                fprintf('Data not available\n');
                break
            end
            counts = counts + 1;
        end
        if isempty(WF_Snippet) == 1
            fprintf('No Data\n');
        else
            %Not sure if we just want to add a filter function later
            %and not filter it in situ
            WF_Snippet = convertTracesRM_IR(WF_Snippet);
            WF_Snippet = fillgaps(WF_Snippet,0);
            WF_Snippet = filter_waveform_BP(WF_Snippet,lower_band,upper_band);
            WF_Snippet = addfield(WF_Snippet,'Rad_Dist',deg2km(list(i).radialDistance));
            WF_Snippet = addfield(WF_Snippet, 'POI_Azimuth', list(i).azimuth);
            WF_Snippet = addfield(WF_Snippet,'Elevation',list(i).Elevation);
            if get(WF_Snippet,'freq') == base_rate;
                WF_Snippet = correlation(WF_Snippet);
                
                if strcmp(phase_picked,'P') == 1
                    WF_Snippet = set(WF_Snippet,'trig',datenum(eventPWave));
                elseif strcmp(phase_picked, 'S') == 1;
                    WF_Snippet = set(WF_Snippet,'trig',datenum(eventSWave));
                end
                
                if pick_number == 0;
                    correlation_object = WF_Snippet;
                else
                    correlation_object = cat(correlation_object,WF_Snippet);
                end
                pick_number = pick_number + 1;
            else
                fprintf('Wrong sampling rate\n');
            end
        end
    end
end
template_correlation = correlation(template_snippet)
if strcmp(phase_picked,'P') == 1
    template_correlation = set(template_correlation,'trig',datenum(eventPWave));
elseif strcmp(phase_picked, 'S') == 1;
    template_correlation = set(template_correlation,'trig',datenum(eventSWave));
end

template_set = cat(correlation_object,template_correlation)
template_set = xcorr(template_set)
template_set_moved_out = adjusttrig(template_set,'index',length(get(template_set,'trig')))
arrivals = cellstr(datestr(get(template_set_moved_out,'trig'),'yyyy-mm-dd HH:MM:SS.FFF'))
waveforms = waveform(template_set_moved_out)
elevation = cellstr(get(waveforms,'Elevation'));
rad_dist = cellstr(get(waveforms,'Rad_Dist'));
elevation = cellstr(num2str(elevation))
names = get(waveforms,'station');
arrivals_header = [{'Station'}, {'Radial Distance (km)'}, {'Elevation (m)'},{'Arrival Time (UTC)'}];
arrivals = [arrivals_header;names rad_dist elevation arrivals]

