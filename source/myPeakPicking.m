function bass = myPeakPicking(f,rawinput, newinput, minHeight, minDist, minProm, threshold, isdebug)

[pks,locs] = findpeaks(newinput, 'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm, 'Threshold', threshold);
fpeaks = f(locs);

if isdebug    
    display(fpeaks);
end

bass = [];

if ~isempty(fpeaks)
    pitchPeaks = freq2pitchclass(fpeaks);
    
    % the pitchPeaks are candidates, the true bass are somewhere in these
    % candidates, we have to find it out based on a various of criteria
    select = overtoneFilter(rawinput, pks, locs, 0, isdebug);
    
%     selectThres = 0.07;
%     wlength = 30;
%     select = selectPeaks(input, locs, pks, selectThres, wlength);
%     display(select);
    bass = pitch2name(pitchPeaks(select));
%     bass = pitch2name(pitchPeaks(1));

end