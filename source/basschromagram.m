% Filename: basschromagram.m
% Function: compute the bass chromagram of the input fft amplitude spectrum
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

function [basschroma, bassmax] = basschromagram(fftAmpSpec, f)

% bass chroma
% bass range: 20Hz - 450Hz
% A = 69, mod (69, 12) = 9, thus
% C 1
% C# 2
% D 3
% D# 4
% E 5
% F 6
% F# 7
% G 8
% G# 9
% A 10
% A# 11
% B 12
idxLow = 0;
idxHigh = 0;
for i = 1:1:length(f)
    if f(i) >= 20
        idxLow = i;
        break;
    end
end

for i = idxLow:1:length(f)
    if f(i) >= 450
        idxHigh = i;
        break;
    end
end

fm = f(idxLow:idxHigh);
fftAmpSpecShort = fftAmpSpec(idxLow:idxHigh);
fmidiNumber = round(12.*log2(fm./440)+69);
fmidiPitchClass = mod (fmidiNumber, 12) + 1;
basschroma = [0,0,0,0,0,0,0,0,0,0,0,0];

for i=1:1:length(fmidiPitchClass)
    basschroma(fmidiPitchClass(i)) = basschroma(fmidiPitchClass(i)) + fftAmpSpecShort(i);
end
[basschromaMax, bassmax] = max(basschroma);
basschroma = basschroma/basschromaMax;
