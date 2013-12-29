function output = filter_waveform(station,network,channel,location,time)
check = irisFetch.Stations('CHANNEL',network,station,location, channel);
exists = 0; 
for i = 1:length(check.Channels)
    if datenum(time) >= datenum(check.Channels(i).StartDate) && datenum(time) <= datenum(check.Channels(i).EndDate)
        exists = 1;
    end
end
uptime = exists;