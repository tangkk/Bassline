function bass = myPeakPicking(f,input, minHeight, minDist, isdebug)

[pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight, 'MINPEAKDISTANCE', minDist, 'MinPeakProminence', 0.1);
fpeaks = f(locs);

bass = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
%     pksavg = rms(pks);
    [pitchPeaks, bass] = freq2pitchclass(fpeaks);
end