function [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,input, minHeight, minDist)

[pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight, 'MINPEAKDISTANCE', minDist);
fpeaks = f(locs);
% reduce noisy peaks
fpeaks = reducePeaks(fpeaks);

display(fpeaks);

firmfpeaks = zeros(1,length(fpeaks));
for i = 1:1:5 
    %%% Sweep up to confirm
    [pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight + 0.01*i, 'MINPEAKDISTANCE', minDist);
    newfpeaks = f(locs);
    % reduce noisy peaks
    newfpeaks = reducePeaks(newfpeaks);
    display(newfpeaks);
    
    newfirmfpeaks = comparePeaks(fpeaks, newfpeaks, []);
    firmfpeaks = combinePeaks(firmfpeaks, newfirmfpeaks);
    display(firmfpeaks);
end

firmfpeaks(firmfpeaks == 0) = [];
display(firmfpeaks);

for i = 1:1:5
    %%% Sweep down to reduce
    [pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight - 0.01*i, 'MINPEAKDISTANCE', minDist);
    newfpeaks = f(locs);
    % reduce noisy peaks
    newfpeaks = reducePeaks(newfpeaks);
    display(newfpeaks);
    
    fpeaks = comparePeaks(fpeaks, newfpeaks, firmfpeaks);
    display(fpeaks);
end

fpeaks(fpeaks == 0) = [];
display(fpeaks);

bassfreq = [];
pitchPeaks = [];
bass = [];
pksavg = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
    pksavg = rms(pks);
    [pitchPeaks, bass] = freq2pitchclass(fpeaks);
    bassfreq = fpeaks(1);
end