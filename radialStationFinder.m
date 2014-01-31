%CCCP
%Radial Station Finder
%function [list closest_station] = radialStationFinder(StartTime, EndTime,radius,channel,longitude,latitude);
%Beginnings of a function to generate data about stations surrounding a given point so that
%waveforms can be gathered
%Outputs a list of stations within the given radius, as well as the closest
%station to use for picks for the determinination of template arrivals.
function [list closest_station] = radialStationFinder(StartTime, EndTime,radius,channel,longitude,latitude);



% StartTime = '2011-11-11 00:00:00';
% EndTime = '2011-11-15 00:00:00';
% searchRadius = 5;
% sensorType = 'B??';

list = irisFetch.Stations('CHANNEL','*','*','*',channel,'IncludeRestricted',false,'StartBefore',StartTime,'EndAfter',EndTime,'Latitude',latitude,'Longitude',longitude,'MinimumRadius',0,'MaximumRadius',radius,'includeAvailability',true,'includePZ');
delta = 1;
while delta ~= 0
    delta = 0;
    for i = 1:length(list)
        item = list(i);
        if strcmp(item.RestrictedStatus,'CLOSED') == 1;
            list(i) = [];
            delta = 1;
        end
        if strcmp(item.NetworkCode,'SY') == 1;
            list(i) = [];
            delta = 1;
        end
        if i >=  length(list);
            break
        end
    end
end
%     item = list(length(list));
%     if strcmp(item.RestrictedStatus,'CLOSED') == 1;
%         list(i) = [];
%     end
%     if strcmp(item.NetworkCode,'SY') == 1;
%         list(i) = [];
%     end



closest = 5000;
for i = 1:length(list)
    [arclen az] = distance([latitude,longitude],[list(i).Latitude,list(i).Longitude]);
    if arclen < closest
        closest = arclen;
        closest_station = list(i);
        
    end
end
end






