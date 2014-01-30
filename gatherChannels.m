%Channel information gather sandbox


% in UTC
StartDate = '2011-03-11 05:46:24';
EndDate = '2011-03-11 06:30:00';


%Numeric values must be doubles
Latitude = 30.5072;
Longitude = -121.1275;
MinimumRadius = 0.0;
MaximumRadius = 25.0;

list = irisFetch.Stations('STATION','US','','','','StartBefore',StartDate,'EndAfter',EndDate,'Latitude',Latitude,'Longitude',Longitude,'MaximumRadius',MaximumRadius,'verbose')


for i = 1:length(list)
    stations{i} = list(i).StationCode;
end


stationDetail = irisFetch.Channels('CHANNEL',list(2).NetworkCode,list(2).StationCode,'','')
trace = irisFetch.Traces(stationDetail(1).NetworkCode,stationDetail(1).StationCode,stationDetail(1).LocationCode,stationDetail(1).ChannelCode,StartDate,EndDate,'verbose','includePZ')
trace = convertTracesRM_IR(trace)