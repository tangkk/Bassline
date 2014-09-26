function peaks = comparePeaks(fpeaks, newPeaks, firmPeaks)

peaks = zeros(1,length(fpeaks));

for i = 1:1:length(fpeaks)
    thisPeak = fpeaks(i);
     % if it is a firm peak, it won't out
    if ~isempty(firmPeaks)
        for j = 1:1:length(firmPeaks)
            if thisPeak == firmPeaks(j)
                peaks(i) = fpeaks(i);
            end
        end
    end

    % if it's not a firm peak, it may die out
    if ~isempty(newPeaks)
        for j = 1:1:length(newPeaks)
            if thisPeak == newPeaks(j)
                peaks(i) = fpeaks(i);
            end
        end
    end
end
            