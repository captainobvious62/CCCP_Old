%CCCP
%Template Pick Gather

function wf_Temp = templatePickGather(list,closest_station,starttime,endtime,channel)
network = closest_station.NetworkCode;
location = '*';
station = closest_station.StationCode;

wf_Temp = [];
while isempty(wf_Temp) == 1
    try
        fprintf('Downloading template\n')
        wf_Temp = irisFetch.Traces(network,station,location, channel, starttime, endtime,'verbose','includePZ')
        
    catch exception
        fprintf('Trying again....\n');
    end
    
end

wf_Temp = convertTracesRM_IR(wf_Temp);

end