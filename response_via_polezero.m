function response = response_via_polezero(WF,frequencies,station,network,location,channel)

%RESPONSE_GET_FROM_POLEZERO Create response structure from poles/zeros
%  RESPONSE = RESPONSE_GET_FROM_POLEZERO(FREQUENCIES,POLEZERO) Reads in
%  pole zero information and returns the complex response at the
%  frequencies specified by FREQUENCIES. FREQUENCIES is a vector of
%  freqeuncies specified in Hz.
%Modification for functionality by Robert Walker


%     
%     
% polezero.poles = [
%       -4.21+4.66i
%       -4.21-4.66i
%     -133.29+133.29i
%     -133.29-133.29i
%     -133.29+133.29i
%     -133.29-133.29i ];
% 
% polezero.poles = [
%     0
%     0];
% 
% polezero.normalization = 1.6916e+009;

response = irisFetch.Channels('Response',network,station,location,channel);
polezero = get(WF,'SACPZ');

% INITIALIZE THE OUTPUT ARGUMENT
%Check to see if units should be in volts or M/S
response.scnl = scnlobject(station,channel,network,location);
response.time = datenum(get(WF,'start'));
response.frequencies = reshape(frequencies,numel(frequencies),1);
%response.values =response.InstrumentSensitivity.Value; %don't know this one either
response.calib = get(WF,'CALIB');
response.units = polezero.units;
response.sampleRate = response.SampleRate;
response.source = 'FUNCTION: RESPONSE_GET_FROM_POLEZERO';


% Pole/zeros can be normalized with the following if not already normalized:
polezero.normalization = 1/abs(polyval(poly(polezero.zeros),2*pi*1i)/polyval(poly(polezero.poles),2*pi*1i));


% CALCULATE COMPLEX RESPONSE AT SPECIFIED FREQUENCIES
ws = (2*pi) .* response.frequencies;
response.values = freqs(polezero.normalization*poly(polezero.zeros),poly(polezero.poles),ws);


