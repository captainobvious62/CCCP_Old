function result = removeIR(ws)

    sacpz = get(ws,'sacpz');
    poles = 2*pi()*sacpz.poles;
    zeros = 2*pi()*sacpz.zeros;
    samplerate = get(ws,'freq');
    sensitivityFrequency = get(ws,'sensitivityFrequency');
    null = -2^31;
    flo = 0.0001+ 5/(length(get(ws,'data'))*(1/samplerate));
    fhi = 0.8*samplerate;
    ordl = 3;
    ordh = 5;
    digout = 1 ./ get(ws,'sensitivity');
    oversampl = samplerate/10;
    idelay = 0;
    rawdata = get(ws,'data');
    fprintf('Performing Instrument Response Correction\n');
    data = rm_instrum_resp(rawdata,null,samplerate,poles,zeros,flo,fhi,ordl,ordh,digout,sensitivityFrequency,oversampl,idelay);
    ws = set(ws,'data',data);
    ws = addfield(ws,'calib_applied','YES');
    result = ws;
end