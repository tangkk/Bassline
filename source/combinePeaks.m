function peaks = combinePeaks(peaksA, peaksB)

peaks = zeros(1,length(peaksA));
for i = 1:1:length(peaksA)
    if peaksA(i) > 0
        peaks(i) = peaksA(i);
    end
    
    if peaksB(i) > 0
        peaks(i) = peaksB(i);
    end
end