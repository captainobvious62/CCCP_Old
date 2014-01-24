%This file controls the template event to be used for cross correlation.
%At the moment, the format is rather self explanatory, with the fields as follows:
%Station
%Network
%S Wave arrival time (Template focus time)
%Template name
%Channel list denoting channels of interest
%Move out time (will be automated, if it hasn't already been)

%Ignore move outs for right now (12-18)


%Quick attempt to pick out events using MCWV 12/20
% T01 = struct();
% T01.station = 'MCWV';
% T01.network = 'US';
% T01.pWaveArrival = '2011-12-31 20:05:28.81';
% T01.sWaveArrival = '2011-12-31 20:05:48.650';
% T01.trigger = 'P';
% T01.sideWindows = [1 20];
% T01.template = 'M4_Mainshock_P';
% T01.channel_list = ['BH1';'BH2';'BHZ'];
% T01.channel_list = cellstr(T01.channel_list);
%
% T01(2).station = 'N54A';
% T01(2).network = 'TA';
% T01(2).pWaveArrival = '2011-12-31 20:05:10.32';
% T01(2).sWaveArrival = '2011-12-31 20:05:17.70';
% T01(2).trigger = 'P';
% T01(2).sideWindows = [1 20];
% T01(2).template = 'M4_Mainshock_P';
% T01(2).channel_list = ['BHE';'BHN';'BHZ'];
% T01(2).channel_list = cellstr(T01(2).channel_list);

% T01 = struct();
% T01.station = 'MCWV';
% T01.network = 'US';
% T01.pWaveArrival = '2011-12-31 20:05:28.81';
% T01.sWaveArrival = '2011-12-31 20:05:48.650';
% T01.trigger = 'S';
% T01.sideWindows = [15 5];
% T01.template = 'M4_Mainshock_S';
% T01.channel_list = ['BH1';'BH2';'BHZ'];
% T01.channel_list = cellstr(T01.channel_list);
% % 
% % 
% % 
% % 
% % T01(2).station = 'N54A';
% % T01(2).network = 'TA';
% % T01(2).pWaveArrival = '2011-12-31 20:05:10.32';
% % T01(2).sWaveArrival = '2011-12-31 20:05:17.70';
% % T01(2).trigger = 'S';
% % T01(2).sideWindows = [15 5];
% % T01(2).template = 'M4_Mainshock_S';
% % T01(2).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(2).channel_list = cellstr(T01(2).channel_list);
% % 
% % T01(3).station = 'ERPA';
% % T01(3).network = 'US';
% % T01(3).pWaveArrival = '2011-12-31 20:05:20.18';
% % T01(3).sWaveArrival = '2011-12-31 20:05:33.050';
% % T01(3).trigger = 'S';
% % T01(3).sideWindows = [15 5];
% % T01(3).template = 'M4_Mainshock_S';
% % T01(3).channel_list = ['BH1';'BH2';'BHZ'];
% % T01(3).channel_list = cellstr(T01(2).channel_list);
% 
% 
% %25 November 2011 event - previous baseline template. don't recall P wave arrival offhand.
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
% T02 = struct();
% T02.station = 'N54A';
% T02.network = 'TA';
% T02.pWaveArrival = '2011-11-25 06:47:37.400';
% T02.sWaveArrival = '2011-11-25 06:47:45.050';
% T02.template = '25_Nov';
% T02.trigger = 'S';
% T02.sideWindows = [15 5];
% T02.channel_list = ['BHE';'BHN';'BHZ'];
% T02.channel_list = cellstr(T02.channel_list);


T02 = struct();
T02.station = 'ACSO';
T02.network = 'US';
T02.pWaveArrival = '2011-11-25 06:48:01.310';
T02.sWaveArrival = '2011-11-25 06:48:25.900';
T02.template = '25_Nov';
T02.trigger = 'S';
T02.sideWindows = [30 5];
T02.channel_list = ['BH1';'BH2';'BHZ'];
T02.channel_list = cellstr(T02.channel_list);

% T02 = struct();
% T02.station = 'O56A';
% T02.network = 'TA';
% T02.pWaveArrival = '2011-11-25 06:47:59.675';
% T02.sWaveArrival = '2011-11-25 06:48:26.925';
% T02.trigger = 'S';
% T02.sideWindows = [30 5];
% T02.template = '25_Nov';
% T02.channel_list = ['BHE';'BHN';'BHZ'];
% T02.channel_list = cellstr(T02.channel_list);
% 



T02(2).station = 'MCWV';
T02(2).network = 'US';
T02(2).pWaveArrival = '2011-11-25 06:47:55.730';
T02(2).sWaveArrival = '2011-11-25 06:48:17.750';
T02(2).template = '25_Nov';
T02(2).trigger = 'S';
T02(2).sideWindows = [25 5];
T02(2).channel_list = ['BH1';'BH2';'BHZ'];
T02(2).channel_list = cellstr(T02(2).channel_list);

% %After this point numbers are just [bad] guesses - mostly need the IR corrected waveforms for now
T02(3).station = 'ERPA';
T02(3).network = 'US';
T02(3).pWaveArrival = '2011-11-25 06:47:47.400';
T02(3).sWaveArrival = '2011-11-25 06:48:01.625';
T02(3).trigger = 'S';
T02(3).sideWindows = [20 5];
T02(3).template = '25_Nov';
T02(3).channel_list = ['BH1';'BH2';'BHZ'];
T02(3).channel_list = cellstr(T02(3).channel_list);

% T02(4).station = 'UPAO';
% T02(4).network = 'PE';
% T02(4).pWaveArrival = '2011-11-25 06:48:10.730';
% T02(4).sWaveArrival = '2011-11-25 06:48:17.750';
% T02(4).trigger = 'S';
% T02(4).sideWindows = [15 5];
% T02(4).template = '25_Nov';
% T02(4).channel_list = ['BHE';'BHN';'BHZ'];
% T02(4).channel_list = cellstr(T02(4).channel_list);

%SSPA needs location integrated
% T02(5).station = 'SSPA';
% T02(5).network = 'IU';
% T02(5).pWaveArrival = '2011-11-25 06:48:10.730';
% T02(5).sWaveArrival = '2011-11-25 06:48:17.750';
% T02(5).trigger = 'S';
% T02(5).sideWindows = [15 5];
% T02(5).template = '25_Nov';
% T02(5).channel_list = ['BH1';'BH2';'BHZ'];
% T02(5).channel_list = cellstr(T02(5).channel_list);


% 
% % % 
% T02(4).station = 'M54A';
% T02(4).network = 'TA';
% T02(4).pWaveArrival = '2011-11-25 06:47:42.675';
% T02(4).sWaveArrival = '2011-11-25 06:47:53.875';
% T02(4).trigger = 'S';
% T02(4).sideWindows = [20 5];
% T02(4).template = '25_Nov';
% T02(4).channel_list = ['BHE';'BHN';'BHZ'];
% T02(4).channel_list = cellstr(T02(4).channel_list);
% 








% 
% 
% %Template is 31 December 2011 M4.0/3.7 Youngstown Earthquake
% %
% 
% % T01 = struct();
% % T01.station = 'N54A';
% % T01.network = 'TA';
% % T01.pWaveArrival = '2011-12-31 20:05:10.32';
% % T01.sWaveArrival = '2011-12-31 20:05:17.70';
% % T01.trigger = 'P';
% % T01.sideWindows = [1 20];
% % T01.template = 'M4_Mainshock';
% % T01.channel_list = ['BHE';'BHN';'BHZ'];
% % T01.channel_list = cellstr(T01.channel_list);
% %
% %
% % T01(2).station = 'ERPA';
% % T01(2).network = 'US';
% % T01(2).pWaveArrival = '2011-12-31 20:05:20.18';
% % T01(2).sWaveArrival = '2011-12-31 20:05:33.050';
% % T01(2).trigger = 'P';
% % T01(2).sideWindows = [1 20];
% % T01(2).template = 'M4_Mainshock';
% % T01(2).channel_list = ['BH1';'BH2';'BHZ'];
% % T01(2).channel_list = cellstr(T01(2).channel_list);
% %
% %
% %
% % T01(3).station = 'MCWV';
% % T01(3).network = 'US';
% % T01(3).pWaveArrival = '2011-12-31 20:05:28.81';
% % T01(3).sWaveArrival = '2011-12-31 20:05:48.650';
% % T01(3).trigger = 'P';
% % T01(3).sideWindows = [1 20];
% % T01(3).template = 'M4_Mainshock';
% % T01(3).channel_list = ['BH1';'BH2';'BHZ'];
% % T01(3).channel_list = cellstr(T01(3).channel_list);
% %
% %
% % T01(4).station = 'M54A';
% % T01(4).network = 'TA';
% % T01(4).pWaveArrival = '2011-12-31 20:05:15.62';
% % T01(4).sWaveArrival = '2011-12-31 20:05:27.321';
% % T01(4).trigger = 'P';
% % T01(4).sideWindows = [1 20];
% % T01(4).template = 'M4_Mainshock';
% % T01(4).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(4).channel_list = cellstr(T01(4).channel_list);
% %
% % T01(5).station = 'UPAO';
% % T01(5).network = 'PE';
% % T01(5).pWaveArrival = '2011-12-31 20:05:15.18';
% % T01(5).sWaveArrival = '2011-12-31 20:05:25.64';
% % T01(5).trigger = 'P';
% % T01(5).sideWindows = [1 20];
% % T01(5).template = 'M4_Mainshock';
% % T01(5).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(5).channel_list = cellstr(T01(5).channel_list);
% %
% % T01(6).station = 'O56A';
% % T01(6).network = 'TA';
% % T01(6).pWaveArrival = '2011-12-31 20:05:32.30';
% % T01(6).sWaveArrival = '2011-12-31 20:05:51.15';
% % T01(6).trigger = 'P';
% % T01(6).sideWindows = [1 20];
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(6).channel_list = cellstr(T01(6).channel_list);
% %
% %
% % T02 = struct();
% % T02.station = 'N54A';
% % T02.network = 'TA';
% % T02.pWaveArrival = '2011-12-31 20:05:10.32';
% % T02.sWaveArrival = '2011-12-31 20:05:17.70';
% % T02.trigger = 'P';
% % T02.sideWindows = [1 20];
% % T02.template = 'M4_Mainshock';
% % T02.channel_list = ['BHE';'BHN';'BHZ'];
% % T02.channel_list = cellstr(T01.channel_list);
% %
% % T02(2).station = 'ERPA';
% % T02(2).network = 'US';
% % T02(2).pWaveArrival = '2011-12-31 20:05:20.18';
% % T02(2).sWaveArrival = '2011-12-31 20:05:33.050';
% % T02(2).trigger = 'P';
% % T02(2).sideWindows = [1 20];
% % T02(2).template = 'M4_Mainshock';
% % T02(2).channel_list = ['BH1';'BH2';'BHZ'];
% % T02(2).channel_list = cellstr(T01(2).channel_list);
% %
% %
% %
% % T02(3).station = 'MCWV';
% % T02(3).network = 'US';
% % T02(3).pWaveArrival = '2011-12-31 20:05:28.81';
% % T02(3).sWaveArrival = '2011-12-31 20:05:48.650';
% % T02(3).trigger = 'P';
% % T02(3).sideWindows = [1 20];
% % T02(3).template = 'M4_Mainshock';
% % T02(3).channel_list = ['BH1';'BH2';'BHZ'];
% % T02(3).channel_list = cellstr(T01(3).channel_list);
% %
% %
% % T01(4).station = 'M54A';
% % T01(4).network = 'TA';
% % T01(4).pWaveArrival = '2011-12-31 20:05:15.62';
% % T01(4).sWaveArrival = '2011-12-31 20:05:27.321';
% % T01(4).trigger = 'P';
% % T01(4).sideWindows = [1 20];
% % T01(4).template = 'M4_Mainshock';
% % T01(4).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(4).channel_list = cellstr(T01(4).channel_list);
% %
% % T01(5).station = 'UPAO';
% % T01(5).network = 'PE';
% % T01(5).pWaveArrival = '2011-12-31 20:05:15.18';
% % T01(5).sWaveArrival = '2011-12-31 20:05:25.64';
% % T01(5).trigger = 'P';
% % T01(5).sideWindows = [1 20];
% % T01(5).template = 'M4_Mainshock';
% % T01(5).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(5).channel_list = cellstr(T01(5).channel_list);
% %
% % T01(6).station = 'O56A';
% % T01(6).network = 'TA';
% % T01(6).pWaveArrival = '2011-12-31 20:05:32.30';
% % T01(6).sWaveArrival = '2011-12-31 20:05:51.15';
% % T01(6).trigger = 'P';
% % T01(6).sideWindows = [1 20];
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(6).channel_list = cellstr(T01(6).channel_list);
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % T01(6).station = 'AAM';
% % T01(6).network = 'US';
% % T01(6).sWaveArrival = '2011-12-31 20:06:12.16';
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['BH1';'BH2';'BHZ'];
% % T01(6).channel_list = cellstr(T01(6).channel_list);
% %
% %
% % %
% % % T01(6).station = 'SSPA';
% % % T01(6).network = 'IU';
% % % T01(6).sWaveArrival = '2011-12-31 20:06:04.83';
% % % T01(6).template = 'M4_Mainshock';
% % % T01(6).channel_list = ['BH1';'BH2';'BHZ'];
% % % T01(6).channel_list = cellstr(T01(6).channel_list);
% %
% %
% % % T01(6).station = 'WVNY';
% % % T01(6).network = 'LD';
% % % T01(6).sWaveArrival = '2011-12-31 20:05:58.86';
% % % T01(6).template = 'M4_Mainshock';
% % % T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% % % T01(6).channel_list = cellstr(T01(6).channel_list);
% %
% % %Station has HHx components
% %
% % % T01(6).station = 'PLIO';
% % % T01(6).network = 'PO';
% % % T01(6).sWaveArrival = '2011-12-31 20:05:48.31';
% % % T01(6).template = 'M4_Mainshock';
% % % T01(6).channel_list = ['HHE';'HHN';'HHZ'];
% % % T01(6).channel_list = cellstr(T01(7).channel_list);
% 
% 
% %These templates, 5 - 8, correspond with 20 second correlation windows.
% 
% 
% %At the moment, this controls the listing of all the templates to be used,
% %and ultimately stacked by the move out stacking script
% %(CC_Scan_All_Stations_Stacked.m and family). It is poorly designed - I know

template_list = [T02];
%For P Wave
for j = 1:length(template_list)
    item = template_list(j);
    
    
    for i = 1:length(item);
        if item(i).trigger == 'P'
            if i == 1;
                initial = datenum(item(i).pWaveArrival);
            else
                if initial > datenum(item(i).pWaveArrival)
                    initial = datenum(item(i).pWaveArrival);
                end
            end
        elseif item(i).trigger == 'S'
            if i == 1;
                initial = datenum(item(i).sWaveArrival);
            else
                if initial > datenum(item(i).sWaveArrival)
                    initial = datenum(item(i).sWaveArrival);
                end
            end
            
        end
    end
    for i = 1:length(item);
        item(i).moveOut = (datenum(item(i).pWaveArrival))*86400 - initial*86400;
    end
end



%For S Wave

% for i = 1:length(T01);
%     if i == 1;
%         initial = datenum(T01(i).sWaveArrival);
%     else
%         if initial > datenum(T01(i).sWaveArrival)
%             initial = datenum(T01(i).sWaveArrival);
%         end
%     end
% end
%
% for i = 1:length(T01);
%    T01(i).moveOut = (datenum(T01(i).sWaveArrival))*86400 - initial*86400;
% end


