function ws = convertTraces(traces)
   for i = 1:length(traces)
       w = waveform;
      %Use initial location for all forms
       myscnl = scnlobject(char(traces(i).station), ...
           char(traces(i).channel), ...
           char(traces(i).network), ...
           char(traces(1).location));
       w = set(w,'scnlobject',myscnl,'freq',traces(i).sampleRate); %, 'start', datenum(startDateStr, 'yyyy-mm-dd HH:MM:SS.FFF'));
       w = set(w,'start', datestr(traces(i).startTime));
       w = addfield(w,'end',traces(i).endTime);
       w = addfield(w,'latitude',traces(i).latitude);
       w = addfield(w,'longitude', traces(i).longitude);
       w = addfield(w,'elevation',traces(i).elevation);
       w = addfield(w,'depth',traces(i).depth);
       w = addfield(w,'azimuth',traces(i).azimuth);
       w = addfield(w,'dip',traces(i).dip);
       w = addfield(w,'sensitivity',traces(i).sensitivity);
       w = addfield(w,'sensitivityFrequency',traces(i).sensitivityFrequency);
       w = addfield(w,'instrument',char(traces(i).instrument));
       w = set(w,'units',char(traces(i).sensitivityUnits));
       w = addfield(w,'calib',1 ./ traces(i).sensitivity);
       w = addfield(w,'calib_applied','NO');
       w = set(w,'data', traces(i).data);
       w = addfield(w,'sacPZ',traces(i).sacpz);
       ws = addfield(w,'calib_applied','NO');
       ws(i) = w;
   end 
end
