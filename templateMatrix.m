station = 'ACSO'
network = 'US'
location = '*'
starttime = '2011-11-25 06:45'
endtime = '2011-11-25 06:50'

upper_band = 1
lower_band = 12

Temp1 = irisFetch.Traces(network,station,location, 'BH1',starttime, endtime,'verbose','includePZ');
Temp2 = irisFetch.Traces(network,station,location, 'BH2',starttime, endtime,'verbose','includePZ');

TempZ = irisFetch.Traces(network,station,location, 'BHZ',starttime, endtime,'verbose','includePZ');


%To Waveforms

wf_Temp1 = convertTracesRM_IR(Temp1);
wf_Temp2 = convertTracesRM_IR(Temp2);
wf_TempZ = convertTracesRM_IR(TempZ);

%Filter

wf_Temp1 = filter_waveform_BP(wf_Temp1,lower_band,upper_band);
wf_Temp2 = filter_waveform_BP(wf_Temp2,lower_band,upper_band);
wf_TempZ = filter_waveform_BP(wf_TempZ,lower_band,upper_band);

BHZ = wf_TempZ;
BH1 = wf_Temp1;
BH2 = wf_Temp2;
% 
% BH1 = get(wf_Temp1,'data');
% BH2 = get(wf_Temp2,'data'); 
% BHZ = get(wf_TempZ,'data');

%stationMatrix = [BH1(1:12000) BH2(1:12000) BHZ(1:12000)];

ACSO = [BHZ BH2 BH1];

threecomp = threecomp(ACSO)