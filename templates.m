%This file controls the template event to be used for cross correlation.
%At the moment, the format is rather self explanatory, with the fields as follows:
%Station
%Network
%S Wave arrival time (Template focus time)
%Template name
%Channel list denoting channels of interest
%Move out time (will be automated, if it hasn't already been)

% 
% % %25 November 2011 event - previous baseline template. don't recall P wave arrival offhand.
% T01 = struct();
% T01.station = 'N54A';
% T01.network = 'TA';
% %Change
% T01.pWaveArrival = '2011-03-17 10:53:19.900';
% T01.sWaveArrival = '2011-03-17 10:53:27.325';
% T01.template = '17_Mar';
% T01.trigger = 'S';
% T01.sideWindows = [15 5];
% T01.channel_list = ['BHE';'BHN';'BHZ'];
% T01.channel_list = cellstr(T01.channel_list);
% 
% 
% T01(2).station = 'MCWV';
% T01(2).network = 'US';
% %change
% T01(2).pWaveArrival = '2011-03-17 20:05:28.81';
% 
% T01(2).sWaveArrival = '2011-03-17 10:54:01.550';
% T01(2).trigger = 'S';
% T01(2).sideWindows = [15 5];
% T01(2).template = '17_Mar';
% T01(2).channel_list = ['BHE';'BHN';'BHZ'];
% T01(2).channel_list = cellstr(T01(2).channel_list);
% 







T01(1).station = 'MCWV';
T01(1).network = 'US';
T01(1).sWaveArrival = '2011-03-17 10:54:01.550';
T01(1).trigger = 'S';
T01(1).template = '25_Nov';
T01(1).channel_list = ['BHE';'BHN';'BHZ'];
T01(1).channel_list = cellstr(T01(1).channel_list);
T01(1).moveOut = 34.225;




T01(2).station = 'ACSO';
T01(2).network = 'US';
T01(2).sWaveArrival = '2011-03-17 10:54:09.100';
T01(2).trigger = 'S';
T01(2).template = '25_Nov';
T01(2).channel_list = ['BHE';'BHN';'BHZ'];
T01(2).channel_list = cellstr(T01(2).channel_list);
T01(2).moveOut = 41.775;

% %Totally false. Only need
% T01(3).station = 'ERPA';
% T01(3).network = 'US';
% T01(3).pWaveArrival = '2011-03-17 06:47:55.730';
% T01(3).sWaveArrival = '2011-03-17 06:48:17.750';
% T01(3).trigger = 'S';
% T01(3).sideWindows = [15 5];
% T01(3).template = '17_Mar';
% T01(3).channel_list = ['BH1';'BH2';'BHZ'];
% T01(3).channel_list = cellstr(T01(3).channel_list);
% 
% T01(4).station = 'MCWV';
% T01(5).station = 'ERPA';


%%
%25 November 2011


%T02 = struct();
%T02.station = 'N54A';
%T02.network = 'TA';
%T02.pWaveArrival = '2011-11-25 06:47:37.400';
%T02.sWaveArrival = '2011-11-25 06:47:45.050';
%T02.template = '25_Nov';
%T02.trigger = 'S';
%T02.channel_list = ['BHE';'BHN';'BHZ'];
%T02.channel_list = cellstr(T02.channel_list);

T02 = struct();
T02.station = 'ACSO';
T02.network = 'US';
T02.pWaveArrival = '2011-11-25 06:48:01.310';
T02.sWaveArrival = '2011-11-25 06:48:25.900';
T02.template = '25_Nov';
T02.trigger = 'S';
T02.channel_list = ['BH1';'BH2';'BHZ'];
T02.channel_list = cellstr(T02.channel_list);

%T02(3).station = 'O56A';
%T02(3).network = 'TA';
%T02(3).pWaveArrival = '2011-11-25 06:47:59.675';
%T02(3).sWaveArrival = '2011-11-25 06:48:26.925';
%T02(3).trigger = 'S';
%T02(3).template = '25_Nov';
%T02(3).channel_list = ['BHE';'BHN';'BHZ'];
%T02(3).channel_list = cellstr(T02(3).channel_list);

T02(2).station = 'MCWV';
T02(2).network = 'US';
T02(2).pWaveArrival = '2011-11-25 06:47:55.730';
T02(2).sWaveArrival = '2011-11-25 06:48:17.750';
T02(2).template = '25_Nov';
T02(2).trigger = 'S';
T02(2).channel_list = ['BH1';'BH2';'BHZ'];
T02(2).channel_list = cellstr(T02(2).channel_list);

T02(3).station = 'ERPA';
T02(3).network = 'US';
T02(3).pWaveArrival = '2011-11-25 06:47:47.400';
T02(3).sWaveArrival = '2011-11-25 06:48:01.625';
T02(3).trigger = 'S';
T02(3).template = '25_Nov';
T02(3).channel_list = ['BH1';'BH2';'BHZ'];
T02(3).channel_list = cellstr(T02(3).channel_list);


%T02(6).station = 'M54A';
%T02(6).network = 'TA';
%T02(6).pWaveArrival = '2011-11-25 06:47:42.675';
%T02(6).sWaveArrival = '2011-11-25 06:47:53.875';
%T02(6).trigger = 'S';
%T02(6).template = '25_Nov';
%T02(6).channel_list = ['BHE';'BHN';'BHZ'];
%T02(6).channel_list = cellstr(T02(6).channel_list);



template_list = {T02};


