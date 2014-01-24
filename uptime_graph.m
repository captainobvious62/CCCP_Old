% function uptime = uptime_graph(station,network,channel,location)
check = irisFetch.Stations('CHANNEL',network,station,location, channel);

UptimeStartDateArray = zeros(1,length(check.Channels));
UptimeEndDateArray = zeros(1,length(check.Channels));
for n = 1:length(check.Channels(1,:))
    UptimeEndDateArray(n) = datenum(check.Channels(1,n).EndDate);
    UptimeStartDateArray(n) = datenum(check.Channels(1,n).StartDate);
end

UptimeStartDateArray = sort(UptimeStartDateArray);
UptimeEndDateArray = sort(UptimeEndDateArray);

UptimeArray = zeros(length(UptimeStartDateArray),2);

UptimeArray(:,1) = UptimeStartDateArray;
UptimeArray(:,2) = UptimeEndDateArray;


DowntimeStartDateArray = [];
DowntimeEndDateArray = [];

if isempty(check.Comment) == 0
    for n = 1:length(check.Comment)
        begin_effective_date = datenum(check.Comment(n).BeginEffectiveDate);
        end_effective_date = datenum(check.Comment(n).EndEffectiveDate);
        elapsed = end_effective_date - begin_effective_date;
        if elapsed < 500 && begin_effective_date ~= end_effective_date
            DowntimeStartDateArray = [DowntimeStartDateArray; begin_effective_date];
            DowntimeEndDateArray = [DowntimeEndDateArray; end_effective_date];            
        end
   end
end

DowntimeArray = zeros(length(DowntimeStartDateArray),2);
DowntimeArray(:,1) = DowntimeStartDateArray;
DowntimeArray(:,2) = DowntimeEndDateArray;


UptimeDateText(:,1) = cellstr(datestr(UptimeStartDateArray));
UptimeDateText(:,2) = cellstr(datestr(UptimeEndDateArray));
DowntimeDateText(:,1) = cellstr(datestr(DowntimeStartDateArray));
DowntimeDateText(:,2) = cellstr(datestr(DowntimeEndDateArray));
check.uptime = UptimeArray;
check.downtime = DowntimeArray;
check.uptimeDates = UptimeDateText;
check.downtimeDates = DowntimeDateText;
% check.uptime = [StartDateArray;EndDateArray];
% cellstr(datestr(check.uptime(:,2)))
% uptimeDates = zeros(length(check.uptime);
% for n = length(check.uptime)
%   up
% end





