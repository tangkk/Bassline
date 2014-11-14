function bass = myPeakPicking(f,input, minHeight, minDist, minProm, isdebug)

[pks,locs] = findpeaks(input,'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm);
fpeaks = f(locs);

bass = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
%     pksavg = rms(pks);
    [pitchPeaks, bass] = freq2pitchclass(fpeaks);
end