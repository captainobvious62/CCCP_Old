load('./CCCP/CorrelationObject/CO_25_Nov_S_N54A_BHE.mat')
%Use BHE/BHN for S waves, average, BHZ for P waves
%Load template

C = correlation_object;
template = waveform(C,83);
subject = correlation_object;
sWaveArrival = datenum('2011-11-25 06:47:44.450');
template = correlation(template,sWaveArrival);
TEST = cat(subject,template);
TEST = xcorr(TEST,'interp')
TEST = adjusttrig(TEST,'index')
trig = get(TEST,'trig')
datestr(trig,'yyyy-mm-dd HH:MM:SS.FFF')
TEST = xcorr(TEST,'interp')
TEST = adjusttrig(TEST,'INDEX',2)
trig = get(TEST,'trig')
datestr(trig,'yyyy-mm-dd HH:MM:SS.FFF')
%TEST = crop(TEST,[-15 10])
%[TEST,TIME,INDEX,MAXCORR,LAG] = interferogram(TEST,0.2,0.1,2)
%plot(TEST,'int',1,'lag')
