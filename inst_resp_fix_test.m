function result = remove_response(traces)


poles = 2*pi()*traces.sacpz.poles;
zeros = 2*pi()*traces.sacpz.zeros;
null = -2^31;
flo = 0.1;
fhi = 0.8*traces.sampleRate;
ordl = 3;
ordh = 5;
digout = 1/traces.sensitivity;
oversampl = traces.sampleRate/10;
idelay = 0;
data = rm_instrum_resp(traces.data,null,traces.sampleRate,poles,zeros,flo,fhi,ordl,ordh,digout,traces.sensitivityFrequency,oversampl,idelay);
traces.data = data;
w = convertTraces(traces);
