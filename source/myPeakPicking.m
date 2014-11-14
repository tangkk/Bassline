function bass = myPeakPicking(f,input, minHeight, minDist, minProm, isdebug)

[pks,locs] = findpeaks(input,'MinPeakHeight', minHeight, 'MinPeakDistance', minDist, 'MinPeakProminence', minProm);
fpeaks = f(locs);

bass = [];

% assign values if fpeaks is not empty
if ~isempty(fpeaks)
%     pksavg = rms(pks);
    pitchPeaks = freq2pitchclass(fpeaks);
    
    % select which peak to be the true bass, analysis first peak first
    % algorithm:
    % 1. pick a neighbourhood of N points around the peak location
    % 2. compute the value of this neighbourhood
    % 3. compute the local maximas of this neighbourhood
    % 4. take the median of the result of 3
    % 5. compute the difference of the original peak value and the median
    % 6. if the difference larger than threshold, accept, otherwise, reject
    
    threshold = 0.07;
    wlength = 25;
    select = 1;
    for i = 1:1:length(locs)
%         display(locs);
%         display(fpeaks);
        N = 0;
        if (locs(i) > wlength)
            N = (locs(i)-wlength:1:locs(i)+wlength);
        else
            break;
        end
%         display(N);
        V = input(N);
%         display(V);
        localMaximas = findpeaks(V);
%         display(localMaximas);
        if length(localMaximas) > 1
            localMaximas = sort(localMaximas);
            localMaximas = localMaximas(1:end-1);
        end
        localMaximas = sort(localMaximas);
        medlocalMaximas = median(localMaximas);
        meanlocalMaximas = mean(localMaximas);
%         display(medlocalMaximas);
%         display(meanlocalMaximas);
        D = pks(i) - meanlocalMaximas;
%         display(D);
        stdlocalMaximas = std(localMaximas);
%         display(stdlocalMaximas);
        
        if D < threshold
            continue;
        else
            select = i;
            break;
        end
    end
%     display(select);
    
    bass = pitch2name(pitchPeaks(select));
end