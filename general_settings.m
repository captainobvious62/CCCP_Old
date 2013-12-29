%General Settings File

%Folder Structure
%Check and if necessary create folder structure
base_folder = 'CCCP';
result_folder = 'outputs';
template_folder = 'templates';
crosscorrelation_folder = 'CC';
waveform_folder = 'WF';
all_stack_folder = 'ALLStack';
station_stack_folder = 'StationStack';
check_folder = 'check';
correlation_object_folder = 'CorrelationObject';


%Time Settings
%All times for program are in UTC
month_length = [31,28,31,30,31,30,31,31,30,31,30,31];

%Starting Date/Time
% start_year = 2010;
% start_month = 11;
% start_day = 06;
% start_minute = 00;
% start_second = 00;

start_year = 2010;
start_month = 12;
start_day = 01;
start_minute = 00;
start_second = 00;


%Ending Date/Time
end_year = 2012;
end_month = 03;
end_day = 01;
end_minute = 00;
end_second = 00;

%IRIS database doesn't seem to care much about the location
location = '*';

%Template Settings

%Snippet Settings
%Snippet window settings (sec)

%For P Wave Arrrival
time_before = 1;
time_after = 20;


%Typical for S Wave
% time_before = 10;
% time_after = 10;

%Filter Settings
lower_band = 1;
upper_band = 12;
filter = filterobject('B',[1 12], 4);
scan_increment = 10; % seconds
scan_increment = scan_increment/86400;




%Cross Correlation Review Settings
candidates = 20;
CC_increment = 1; %Value in days
Master_CC_Scan_Threshold = 0.5;

%Correlation object settings
%Time before and after S-Wave pick to grab
before_P_Wave = 5;
after_P_Wave = 25;
before_S_Wave = 60;
after_S_Wave = 30;
correlation_channel = 'BHZ';















