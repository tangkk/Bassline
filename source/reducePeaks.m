function newPeaks = reducePeaks(oldPeaks)

% to mark the noisy peaks
newPeaks = [];
markers = zeros(1, length(oldPeaks));

lastPeak = oldPeaks(1);
markers(1) = 1;
if length(oldPeaks) > 1
    for i = 2:1:length(oldPeaks)
        thisPeak = oldPeaks(i);
        if (thisPeak - lastPeak <= 10)
            markers(i-1) = 0;
            markers(i) = 0;
        else
            markers(i) = 1;
        end
        lastPeak = thisPeak;
    end
    
    % select new peaks based on markers
    for i = 1:1:length(markers)
        if (markers(i) == 1)
            newPeaks = [newPeaks oldPeaks(i)];
        end
    end
end