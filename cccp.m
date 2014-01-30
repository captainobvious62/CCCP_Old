%Script for CCCP v1.0
%
%
%Program generates cross correlations from template matching for a chosen
%interval.
%
%Stations are three components seismometers, as of right now BH* @40 Hz

%%Process
%1) User selects template event, interval of investigation, chooses stations, and provides P and S wave arrival times,
%1.5) Program checks for published dropout times. At the moment user selects channels (this will be changed)
%2) Program template matches for the given interval, creating cross
%correlation waveforms. These are placed in the denoted cross correlation
%folder.
%3) Program stacks cross correlations for each component to improve
%resolution.
%4) For each station, events of high correlation are picked and noted.
%These results are outputted in .csv format
%5) For each station, Snippet waveforms for the picks of interest are taken
%and placed into a correlation object. The waveforms are then compared
%against the template waveform.



% Process general input parameters
general_settings
% Take orders from input scripts as to which templates to gather
template_data_input
% Generate templates
generateTemplates
% Generate cross correlations for selected timeframe, stations, and channels, 
CC_SingleChannel_Java
% Stack individual components
CC_SingleStation_Stack
% Scan individual station stacks for matches
CC_Scan_Stack
%Build Correlation Objects
generateCorrelationObject
%Find P and S wave Arrival Times
getArrivalTimes
