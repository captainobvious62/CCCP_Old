function ws = convertTracesRM_IR(traces)
%Converts irisFetch gathered traces to waveform objects and applies
%instrument response removal
%This only works for one type of channel each
for i = 1:length(traces)
    
    ws(i) = waveform;
    myscnl = scnlobject(char(traces(i).station),char(traces(i).channel),char(traces(i).network),char(traces(1).location));
    ws(i) = set(ws(i),'scnlobject',myscnl,'freq',traces(i).sampleRate); %, 'start', datenum(startDateStr, 'yyyy-mm-dd HH:MM:SS.FFF'));
    ws(i) = set(ws(i),'start', datestr(traces(i).startTime));
    ws(i) = addfield(ws(i),'end',traces(i).endTime);
    ws(i) = addfield(ws(i),'latitude',traces(i).latitude);
    ws(i) = addfield(ws(i),'longitude', traces(i).longitude);
    ws(i) = addfield(ws(i),'elevation',traces(i).elevation);
    ws(i) = addfield(ws(i),'depth',traces(i).depth);
    ws(i) = addfield(ws(i),'azimuth',traces(i).azimuth);
    ws(i) = addfield(ws(i),'dip',traces(i).dip);
    ws(i) = addfield(ws(i),'sensitivity',traces(i).sensitivity);
    ws(i) = addfield(ws(i),'sensitivityFrequency',traces(i).sensitivityFrequency);
    ws(i) = addfield(ws(i),'instrument',char(traces(i).instrument));
    ws(i) = set(ws(i),'units',char(traces(i).sensitivityUnits));
    ws(i) = addfield(ws(i),'calib',1 ./ traces(i).sensitivity);
    ws(i) = set(ws(i),'data', traces(i).data);
    ws(i) = addfield(ws(i),'sacPZ',traces(i).sacpz);
    

end
ws = combine(ws);
ws = fillgaps(ws,0);
sacpz = get(ws,'sacpz');
poles = 2*pi()*sacpz.poles;
zeros = 2*pi()*sacpz.zeros;
samplerate = get(ws,'freq');
sensitivityFrequency = get(ws,'sensitivityFrequency');
null = -2^31;
%Add miniscule value to ensure is > 5*flo
flo =0.0001+ 5/(length(get(ws,'data'))*(1/samplerate));
fhi = 0.8*samplerate;
ordl = 3;
ordh = 5;
digout = 1 ./ get(ws,'sensitivity');
oversampl = samplerate/10;
idelay = 0;
rawdata = get(ws,'data');
done = 0;
corrected = 0;
while done == 0;
    while  ordl > 0 && done == 0;
        try
            fprintf('Performing Instrument Response Correction\n');
            data = rm_instrum_resp(rawdata,null,samplerate,poles,zeros,flo,fhi,ordl,ordh,digout,sensitivityFrequency,oversampl,idelay);
        catch exception
        end
        if exist('data','var') == 0;
            MsgString = getReport(exception)
            ordl = ordl - 1;
        elseif exist('data','var') == 1;
            done = 1;
            corrected = 1;
        end
        if ordl == 0 && exist('data','var') == 0;
            fprintf('Data not corrected\n');
            done = 1;
        end
    end
end

if corrected == 1
    ws = set(ws,'data',data);
    ws = addfield(ws,'IR_CORRECTED','YES');
end
ws = fillgaps(ws,0);
end