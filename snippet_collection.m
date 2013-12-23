%This script is designed to take resultant values from the scanning
%programs, the events variable, and generate correlation objects from them.
%


function snippets = snippet_collection(events,station,channel,network,location,template_arrival)
%Put these control values in the general control script!
general_settings
filter = filterobject('B',[1 12], 4);
event_time_listing = events(:,1);
for i = 2:length(event_time_listing)
    S_Wave_Arrival = events{i,4};
    starttime = S_Wave_Arrival - (before_S_Wave/86400);
    endtime = S_Wave_Arrival + (after_S_Wave/86400);
    WF_Snippet = waveform();
    while isempty(WF_Snippet) == 1
        try
            fprintf('Downloading template\n')
            WF_Snippet = irisFetch.Traces(network,station,location, channel, datestr(starttime), datestr(endtime),'verbose','includePZ');
            WF_Snippet = convertTraces(WF_Snippet);
        catch exception
            fprintf('Trying again....\n');
        end
    end
    WF_Snippet = fillgaps(WF_Snippet,0);
    WF_Snippet = filtfilt(filter,WF_Snippet);
    WF_Snippet = correlation(WF_Snippet);
    if i == 2;
        correlation_object = WF_Snippet;
        correlation_object = cat(correlation_object,WF_Snippet);
    end     
end
template_savename = sprintf('%s/%s/%s_%s_%s.mat',base_folder,template_folder,template,station,channel);
load(template_savename);                    
correlation_object = cat(wf_Temp,correlation_object);

snippets = correlation_object;