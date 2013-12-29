


%General Settings
template = 1;


%Time Settings
Year = 2011;
Month = 11;





%Loop Settings

%Filter Settings
start_M = 11;
end_M = 11;

location = '*';


%Filter Settings
filter = filterobject('B',[1 12], 4);
scan_increment = 10; % seconds
scan_increment = scan_increment/86400;
tempStruct




%Cross Correlation Review Settings
candidates = 20;





%Import/Review data from control files here
template_data
%(for this case, single station, single channel)
station = T01.code;
network = T01.network;
channel = 'BHZ';
location = '*';














