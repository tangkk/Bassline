function bass = peakPicking(f,input, minHeight, minDist, minProm,isdebug)

[pks,locs] = findpeaks(input,'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm);
fpeaks = f(locs);
pksavg = rms(pks);

% reduce noisy peaks
fpeaks = reducePeaks(fpeaks);

if isdebug == 1
    display(fpeaks);
end

firmfpeaks = zeros(1,length(fpeaks));
for i = 1:1:5 
    %%% Sweep up to confirm
    [pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight + 0.01*i, 'MINPEAKDISTANCE', minDist, 'MinPeakProminence', minProm);
    newfpeaks = f(locs);
    % reduce noisy peaks
    newfpeaks = reducePeaks(newfpeaks);
    if isdebug == 1
        display(newfpeaks);
    end
    
    newfirmfpeaks = comparePeaks(fpeaks, newfpeaks, []);
    firmfpeaks = combinePeaks(firmfpeaks, newfirmfpeaks);
    if isdebug == 1
        display(firmfpeaks);
    end
end

firmfpeaks(firmfpeaks == 0) = [];
if isdebug == 1
    display(firmfpeaks);
end

for i = 1:1:5
    %%% Sweep down to reduce
    [pks,locs] = findpeaks(input,'MINPEAKHEIGHT', minHeight - 0.01*i, 'MINPEAKDISTANCE', minDist, 'MinPeakProminence', minProm);
    newfpeaks = f(locs);
    % reduce noisy peaks
    newfpeaks = reducePeaks(newfpeaks);
    if isdebug == 1
        display(newfpeaks);
    end
    
    fpeaks = comparePeaks(fpeaks, newfpeaks, firmfpeaks);
    if isdebug == 1
        display(fpeaks);
    end
end

fpeaks(fpeaks == 0) = [];
if isdebug == 1
    display(fpeaks);
end

bassfreq = [];
pitchPeaks = [];
bass = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
%     pksavg = rms(pks);
    [pitchPeaks, bass] = freq2pitchclass(fpeaks);
    bassfreq = fpeaks(1);
end