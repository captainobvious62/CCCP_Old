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
T01 = struct();
T01.station = 'MCWV';
T01.network = 'US';
T01.pWaveArrival = '2011-12-31 20:05:28.81';
T01.sWaveArrival = '2011-12-31 20:05:48.650';
T01.trigger = 'P';
T01.sideWindows = [1 20];
T01.template = 'M4_Mainshock_P';
T01.channel_list = ['BH1';'BH2';'BHZ'];
T01.channel_list = cellstr(T01.channel_list);

T01(2).station = 'N54A';
T01(2).network = 'TA';
T01(2).pWaveArrival = '2011-12-31 20:05:10.32';
T01(2).sWaveArrival = '2011-12-31 20:05:17.70';
T01(2).trigger = 'P';
T01(2).sideWindows = [1 20];
T01(2).template = 'M4_Mainshock_P';
T01(2).channel_list = ['BHE';'BHN';'BHZ'];
T01(2).channel_list = cellstr(T01(2).channel_list);

T02 = struct();
T02.station = 'MCWV';
T02.network = 'US';
T02.pWaveArrival = '2011-12-31 20:05:28.81';
T02.sWaveArrival = '2011-12-31 20:05:48.650';
T02.trigger = 'S';
T02.sideWindows = [15 5];
T02.template = 'M4_Mainshock_S';
T02.channel_list = ['BH1';'BH2';'BHZ'];
T02.channel_list = cellstr(T02.channel_list);




T02(2).station = 'N54A';
T02(2).network = 'TA';
T02(2).pWaveArrival = '2011-12-31 20:05:10.32';
T02(2).sWaveArrival = '2011-12-31 20:05:17.70';
T02(2).trigger = 'S';
T02(2).sideWindows = [15 5];
T02(2).template = 'M4_Mainshock_S';
T02(2).channel_list = ['BHE';'BHN';'BHZ'];
T02(2).channel_list = cellstr(T02(2).channel_list);

















%Template is 31 December 2011 M4.0/3.7 Youngstown Earthquake
%

% T01 = struct();
% T01.station = 'N54A';
% T01.network = 'TA';
% T01.pWaveArrival = '2011-12-31 20:05:10.32';
% T01.sWaveArrival = '2011-12-31 20:05:17.70';
% T01.trigger = 'P';
% T01.sideWindows = [1 20];
% T01.template = 'M4_Mainshock';
% T01.channel_list = ['BHE';'BHN';'BHZ'];
% T01.channel_list = cellstr(T01.channel_list);
%
%
% T01(2).station = 'ERPA';
% T01(2).network = 'US';
% T01(2).pWaveArrival = '2011-12-31 20:05:20.18';
% T01(2).sWaveArrival = '2011-12-31 20:05:33.050';
% T01(2).trigger = 'P';
% T01(2).sideWindows = [1 20];
% T01(2).template = 'M4_Mainshock';
% T01(2).channel_list = ['BH1';'BH2';'BHZ'];
% T01(2).channel_list = cellstr(T01(2).channel_list);
%
%
%
% T01(3).station = 'MCWV';
% T01(3).network = 'US';
% T01(3).pWaveArrival = '2011-12-31 20:05:28.81';
% T01(3).sWaveArrival = '2011-12-31 20:05:48.650';
% T01(3).trigger = 'P';
% T01(3).sideWindows = [1 20];
% T01(3).template = 'M4_Mainshock';
% T01(3).channel_list = ['BH1';'BH2';'BHZ'];
% T01(3).channel_list = cellstr(T01(3).channel_list);
%
%
% T01(4).station = 'M54A';
% T01(4).network = 'TA';
% T01(4).pWaveArrival = '2011-12-31 20:05:15.62';
% T01(4).sWaveArrival = '2011-12-31 20:05:27.321';
% T01(4).trigger = 'P';
% T01(4).sideWindows = [1 20];
% T01(4).template = 'M4_Mainshock';
% T01(4).channel_list = ['BHE';'BHN';'BHZ'];
% T01(4).channel_list = cellstr(T01(4).channel_list);
%
% T01(5).station = 'UPAO';
% T01(5).network = 'PE';
% T01(5).pWaveArrival = '2011-12-31 20:05:15.18';
% T01(5).sWaveArrival = '2011-12-31 20:05:25.64';
% T01(5).trigger = 'P';
% T01(5).sideWindows = [1 20];
% T01(5).template = 'M4_Mainshock';
% T01(5).channel_list = ['BHE';'BHN';'BHZ'];
% T01(5).channel_list = cellstr(T01(5).channel_list);
%
% T01(6).station = 'O56A';
% T01(6).network = 'TA';
% T01(6).pWaveArrival = '2011-12-31 20:05:32.30';
% T01(6).sWaveArrival = '2011-12-31 20:05:51.15';
% T01(6).trigger = 'P';
% T01(6).sideWindows = [1 20];
% T01(6).template = 'M4_Mainshock';
% T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% T01(6).channel_list = cellstr(T01(6).channel_list);
%
%
% T02 = struct();
% T02.station = 'N54A';
% T02.network = 'TA';
% T02.pWaveArrival = '2011-12-31 20:05:10.32';
% T02.sWaveArrival = '2011-12-31 20:05:17.70';
% T02.trigger = 'P';
% T02.sideWindows = [1 20];
% T02.template = 'M4_Mainshock';
% T02.channel_list = ['BHE';'BHN';'BHZ'];
% T02.channel_list = cellstr(T01.channel_list);
%
% T02(2).station = 'ERPA';
% T02(2).network = 'US';
% T02(2).pWaveArrival = '2011-12-31 20:05:20.18';
% T02(2).sWaveArrival = '2011-12-31 20:05:33.050';
% T02(2).trigger = 'P';
% T02(2).sideWindows = [1 20];
% T02(2).template = 'M4_Mainshock';
% T02(2).channel_list = ['BH1';'BH2';'BHZ'];
% T02(2).channel_list = cellstr(T01(2).channel_list);
%
%
%
% T02(3).station = 'MCWV';
% T02(3).network = 'US';
% T02(3).pWaveArrival = '2011-12-31 20:05:28.81';
% T02(3).sWaveArrival = '2011-12-31 20:05:48.650';
% T02(3).trigger = 'P';
% T02(3).sideWindows = [1 20];
% T02(3).template = 'M4_Mainshock';
% T02(3).channel_list = ['BH1';'BH2';'BHZ'];
% T02(3).channel_list = cellstr(T01(3).channel_list);
%
%
% T01(4).station = 'M54A';
% T01(4).network = 'TA';
% T01(4).pWaveArrival = '2011-12-31 20:05:15.62';
% T01(4).sWaveArrival = '2011-12-31 20:05:27.321';
% T01(4).trigger = 'P';
% T01(4).sideWindows = [1 20];
% T01(4).template = 'M4_Mainshock';
% T01(4).channel_list = ['BHE';'BHN';'BHZ'];
% T01(4).channel_list = cellstr(T01(4).channel_list);
%
% T01(5).station = 'UPAO';
% T01(5).network = 'PE';
% T01(5).pWaveArrival = '2011-12-31 20:05:15.18';
% T01(5).sWaveArrival = '2011-12-31 20:05:25.64';
% T01(5).trigger = 'P';
% T01(5).sideWindows = [1 20];
% T01(5).template = 'M4_Mainshock';
% T01(5).channel_list = ['BHE';'BHN';'BHZ'];
% T01(5).channel_list = cellstr(T01(5).channel_list);
%
% T01(6).station = 'O56A';
% T01(6).network = 'TA';
% T01(6).pWaveArrival = '2011-12-31 20:05:32.30';
% T01(6).sWaveArrival = '2011-12-31 20:05:51.15';
% T01(6).trigger = 'P';
% T01(6).sideWindows = [1 20];
% T01(6).template = 'M4_Mainshock';
% T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% T01(6).channel_list = cellstr(T01(6).channel_list);












% T01(6).station = 'AAM';
% T01(6).network = 'US';
% T01(6).sWaveArrival = '2011-12-31 20:06:12.16';
% T01(6).template = 'M4_Mainshock';
% T01(6).channel_list = ['BH1';'BH2';'BHZ'];
% T01(6).channel_list = cellstr(T01(6).channel_list);
%
%
% %
% % T01(6).station = 'SSPA';
% % T01(6).network = 'IU';
% % T01(6).sWaveArrival = '2011-12-31 20:06:04.83';
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['BH1';'BH2';'BHZ'];
% % T01(6).channel_list = cellstr(T01(6).channel_list);
%
%
% % T01(6).station = 'WVNY';
% % T01(6).network = 'LD';
% % T01(6).sWaveArrival = '2011-12-31 20:05:58.86';
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['BHE';'BHN';'BHZ'];
% % T01(6).channel_list = cellstr(T01(6).channel_list);
%
% %Station has HHx components
%
% % T01(6).station = 'PLIO';
% % T01(6).network = 'PO';
% % T01(6).sWaveArrival = '2011-12-31 20:05:48.31';
% % T01(6).template = 'M4_Mainshock';
% % T01(6).channel_list = ['HHE';'HHN';'HHZ'];
% % T01(6).channel_list = cellstr(T01(7).channel_list);


%These templates, 5 - 8, correspond with 20 second correlation windows.


%At the moment, this controls the listing of all the templates to be used,
%and ultimately stacked by the move out stacking script
%(CC_Scan_All_Stations_Stacked.m and family). It is poorly designed - I know

template_list = [T01 T02];
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


