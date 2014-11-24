function bass = myPeakPicking(f,input, minHeight, minDist, minProm, isdebug)

newinput = preprocess(input);
[pks,locs] = findpeaks(newinput, f, 'MinPeakHeight', minHeight, 'MinPeakProminence', minProm);
% [pks,locs] = findpeaks(input,'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm);

if isdebug    
    display(locs);
    plot(f, newinput);
    hold;
    plot(f, input);
end

bass = [];

% assign values if fpeaks is not empty
if ~isempty(locs)
%     pksavg = rms(pks);
    pitchPeaks = freq2pitchclass(locs);
    
%     threshold = 0.07;
%     wlength = 25;
%     select = selectPeaks(input, locs, pks, threshold, wlength);
    bass = pitch2name(pitchPeaks(1));
end