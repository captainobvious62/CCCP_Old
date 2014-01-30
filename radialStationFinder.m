%CCCP
%Radial Station Finder
%Beginnings of a function to generate data about stations surrounding a given point so that
%waveforms can be gathered

StartTime = '2011-11-11 00:00:00';
EndTime = '2011-11-15 00:00:00';
searchRadius = 5;
sensorType = 'B??';

list = irisFetch.Stations('CHANNEL','*','*','*',sensorType,'IncludeRestricted',false,'StartBefore',StartTime,'EndAfter',EndTime,'Latitude',40.1,'Longitude',-80.5,'MinimumRadius',0,'MaximumRadius',searchRadius,'includeAvailability',true,'includePZ');



for i = 1:length(list)
removed = 1;
while removed == 1
	item = list(i);
	removed = 0;
	if strcmp(item.RestrictedStatus,'CLOSED') == 1;
	list(i) = [];
	removed = 1;
	end
	if strcmp(item.NetworkCode,'SY') == 1;
	list(i) = [];
	removed = 1;
	end	
end
if i ==  length(list);
break
end
end






