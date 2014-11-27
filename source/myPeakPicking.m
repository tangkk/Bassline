function bass = myPeakPicking(f,input, minHeight, minDist, minProm, threshold, isdebug)

% newinput = preprocess(input);
% [pks,locs] = findpeaks(newinput, 'MinPeakHeight', minHeight, 'MinPeakProminence', minProm);
[pks,locs] = findpeaks(input, 'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm, 'Threshold', threshold);
fpeaks = f(locs);

if isdebug    
    display(fpeaks);
%     plot(f, newinput);
%     hold;
%     plot(f, input);
end

bass = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
%     pksavg = rms(pks);
    pitchPeaks = freq2pitchclass(fpeaks);
    
    selectThres = 0.07;
    wlength = 25;
%     select = selectPeaks(input, locs, pks, selectThres, wlength);
    bass = pitch2name(pitchPeaks(1));
%     bass = pitch2name(pitchPeaks(select));
%     display(select);
end