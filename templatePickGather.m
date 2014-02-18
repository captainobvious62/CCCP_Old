%CCCP
%Template Pick Gather

function wf_Temp = templatePickGather(list,closest_station,starttime,endtime,channel)
network = closest_station.NetworkCode;
location = '*';
station = closest_station.StationCode;

wf_Temp = [];
iterations = 0;
failure = 0;
while isempty(wf_Temp) == 1
    try
        fprintf('Downloading template\n')
        wf_Temp = irisFetch.Traces(network,station,location, channel, starttime, endtime,'verbose','includePZ')
        
    catch exception
        fprintf('Trying again....\n');
        iterations = iterations +1;
        
        
    end
    iterations = iterations +1;
    if iterations >4
        fprintf('No Data\n');
        failure = 1;
        wf_Temp  = 1;
    end
end
if failure == 1;
    wf_Temp = [];
else
    wf_Temp = convertTracesRM_IR(wf_Temp);
end
end