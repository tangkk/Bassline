% Filename: chromagram.m
% Function: compute the chromagram of the input fft amplitude spectrum
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

function [chroma,chromaMax] = chromagram(fftAmpSpec, f)

% chroma
% the mid feature is chroma of the song
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
for i = 1:1:length(f)
    if f(i) >= 20
        fm = f(i:length(f));
        fftAmpSpecShort = fftAmpSpec(i:length(fftAmpSpec));
        break;
    end
end
fmidiNumber = round(12.*log2(fm./440)+69);
fmidiPitchClass = mod (fmidiNumber, 12) + 1;
chroma = [0,0,0,0,0,0,0,0,0,0,0,0];

for i=1:1:length(fmidiPitchClass)
    chroma(fmidiPitchClass(i)) = chroma(fmidiPitchClass(i)) + fftAmpSpecShort(i);
end
[chromagramMax, chromaMax] = max(chroma);
chroma = chroma/chromagramMax;
