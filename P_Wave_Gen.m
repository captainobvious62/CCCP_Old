%Script to determine P Wave Arrival Times
%Adjust time data to MATLAB readable format
start_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',start_year,start_month,start_day,start_minute,start_second);
end_date = sprintf('%04d-%02d-%02d %02d:%02d.%d',end_year,end_month,end_day,end_minute,end_second);




sWaveArrival = template_list(1).sWaveArrival;
collect = snippet_collection(events,station,'BHZ',network,'*',sWaveArrival);
correlation_savename = sprintf('%s/%s/correlation_%s_%s_%s_to_%s.mat',base_folder,correlationObject_folder,template,station,start_date,end_date);
save(correlation_savename,'collect');


%Next: use initial P and S wave arrival times to align correlation object,
%generate an interferogram and lag matrix with small enough steps to
%determine the differences at the appropriate points
%print out results
%???
%profit

%NOTE: Cross correlation DOES NOT pick precise S wave arrivals!!!!!!!!!!
%Need to align for best fit first