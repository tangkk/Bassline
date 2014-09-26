% Filename: tonality.m
% Function: compute the tonal gravity and tonal type of the input
% chromagram
%
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

function tonal = tonality(chroma)

% C C# D D# E F F# G G# A  A# B
% 1 2  3 4  5 6 7  8 9  10 11 12
% The tonal is calculated according to major and minor scale
tonalMajor = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMajor(1) = chroma(1)+chroma(5)+chroma(8);
tonalMajor(2) = chroma(2)+chroma(6)+chroma(9);
tonalMajor(3) = chroma(3)+chroma(7)+chroma(10);
tonalMajor(4) = chroma(4)+chroma(8)+chroma(11);
tonalMajor(5) = chroma(5)+chroma(9)+chroma(12);
tonalMajor(6) = chroma(6)+chroma(10)+chroma(1);
tonalMajor(7) = chroma(7)+chroma(11)+chroma(2);
tonalMajor(8) = chroma(8)+chroma(12)+chroma(3);
tonalMajor(9) = chroma(9)+chroma(1)+chroma(4);
tonalMajor(10) = chroma(10)+chroma(2)+chroma(5);
tonalMajor(11) = chroma(11)+chroma(3)+chroma(6);
tonalMajor(12) = chroma(12)+chroma(4)+chroma(7);

tonalMajor7 = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMajor7(1) = chroma(1)+chroma(5)+chroma(8) + chroma(12);
tonalMajor7(2) = chroma(2)+chroma(6)+chroma(9) + chroma(1);
tonalMajor7(3) = chroma(3)+chroma(7)+chroma(10) + chroma(2);
tonalMajor7(4) = chroma(4)+chroma(8)+chroma(11) + chroma(3);
tonalMajor7(5) = chroma(5)+chroma(9)+chroma(12) + chroma(4);
tonalMajor7(6) = chroma(6)+chroma(10)+chroma(1) + chroma(5);
tonalMajor7(7) = chroma(7)+chroma(11)+chroma(2) + chroma(6);
tonalMajor7(8) = chroma(8)+chroma(12)+chroma(3) + chroma(7);
tonalMajor7(9) = chroma(9)+chroma(1)+chroma(4) + chroma(8);
tonalMajor7(10) = chroma(10)+chroma(2)+chroma(5) + chroma(9);
tonalMajor7(11) = chroma(11)+chroma(3)+chroma(6) + chroma(10);
tonalMajor7(12) = chroma(12)+chroma(4)+chroma(7) + chroma(11);

tonalMinor = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMinor(1) = chroma(1)+chroma(4)+chroma(8);
tonalMinor(2) = chroma(2)+chroma(5)+chroma(9);
tonalMinor(3) = chroma(3)+chroma(6)+chroma(10);
tonalMinor(4) = chroma(4)+chroma(7)+chroma(11);
tonalMinor(5) = chroma(5)+chroma(8)+chroma(12);
tonalMinor(6) = chroma(6)+chroma(9)+chroma(1);
tonalMinor(7) = chroma(7)+chroma(10)+chroma(2);
tonalMinor(8) = chroma(8)+chroma(11)+chroma(3);
tonalMinor(9) = chroma(9)+chroma(12)+chroma(4);
tonalMinor(10) = chroma(10)+chroma(1)+chroma(5);
tonalMinor(11) = chroma(11)+chroma(2)+chroma(6);
tonalMinor(12) = chroma(12)+chroma(3)+chroma(7);

tonalMinor7 = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMinor7(1) = chroma(1)+chroma(4)+chroma(8) + chroma(11);
tonalMinor7(2) = chroma(2)+chroma(5)+chroma(9) + chroma(12);
tonalMinor7(3) = chroma(3)+chroma(6)+chroma(10) + chroma(1);
tonalMinor7(4) = chroma(4)+chroma(7)+chroma(11) + chroma(2);
tonalMinor7(5) = chroma(5)+chroma(8)+chroma(12) + chroma(3);
tonalMinor7(6) = chroma(6)+chroma(9)+chroma(1) + chroma(4);
tonalMinor7(7) = chroma(7)+chroma(10)+chroma(2) + chroma(5);
tonalMinor7(8) = chroma(8)+chroma(11)+chroma(3) + chroma(6);
tonalMinor7(9) = chroma(9)+chroma(12)+chroma(4) + chroma(7);
tonalMinor7(10) = chroma(10)+chroma(1)+chroma(5) + chroma(8);
tonalMinor7(11) = chroma(11)+chroma(2)+chroma(6) + chroma(9);
tonalMinor7(12) = chroma(12)+chroma(3)+chroma(7) + chroma(10);

% C C# D D# E F F# G G# A  A# B
% 1 2  3 4  5 6 7  8 9  10 11 12
% The tonal is calculated according to major and minor scale

tonalMajorScale = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMajorScale(1) = chroma(1)+chroma(3)+chroma(5)+chroma(6)+chroma(8)+chroma(10)+chroma(12);
tonalMajorScale(2) = chroma(2)+chroma(4)+chroma(6)+chroma(7)+chroma(9)+chroma(11)+chroma(1);
tonalMajorScale(3) = chroma(3)+chroma(5)+chroma(7)+chroma(8)+chroma(10)+chroma(12)+chroma(2);
tonalMajorScale(4) = chroma(4)+chroma(6)+chroma(8)+chroma(9)+chroma(11)+chroma(1)+chroma(3);
tonalMajorScale(5) = chroma(5)+chroma(7)+chroma(9)+chroma(10)+chroma(12)+chroma(2)+chroma(4);
tonalMajorScale(6) = chroma(6)+chroma(8)+chroma(10)+chroma(11)+chroma(1)+chroma(3)+chroma(5);
tonalMajorScale(7) = chroma(7)+chroma(9)+chroma(11)+chroma(12)+chroma(2)+chroma(4)+chroma(6);
tonalMajorScale(8) = chroma(8)+chroma(10)+chroma(12)+chroma(1)+chroma(3)+chroma(5)+chroma(7);
tonalMajorScale(9) = chroma(9)+chroma(11)+chroma(1)+chroma(2)+chroma(4)+chroma(6)+chroma(8);
tonalMajorScale(10) = chroma(10)+chroma(12)+chroma(2)+chroma(3)+chroma(5)+chroma(7)+chroma(9);
tonalMajorScale(11) = chroma(11)+chroma(1)+chroma(3)+chroma(4)+chroma(6)+chroma(8)+chroma(10);
tonalMajorScale(12) = chroma(12)+chroma(2)+chroma(4)+chroma(5)+chroma(7)+chroma(9)+chroma(11);

tonalMinorScale = [0,0,0,0,0,0,0,0,0,0,0,0];
tonalMinorScale(1) = chroma(1)+chroma(3)+chroma(4)+chroma(6)+chroma(8)+chroma(9)+chroma(11);
tonalMinorScale(2) = chroma(2)+chroma(4)+chroma(5)+chroma(7)+chroma(9)+chroma(10)+chroma(12);
tonalMinorScale(3) = chroma(3)+chroma(5)+chroma(6)+chroma(8)+chroma(10)+chroma(11)+chroma(1);
tonalMinorScale(4) = chroma(4)+chroma(6)+chroma(7)+chroma(9)+chroma(11)+chroma(12)+chroma(2);
tonalMinorScale(5) = chroma(5)+chroma(7)+chroma(8)+chroma(10)+chroma(12)+chroma(1)+chroma(3);
tonalMinorScale(6) = chroma(6)+chroma(8)+chroma(9)+chroma(11)+chroma(1)+chroma(2)+chroma(4);
tonalMinorScale(7) = chroma(7)+chroma(9)+chroma(10)+chroma(12)+chroma(2)+chroma(3)+chroma(5);
tonalMinorScale(8) = chroma(8)+chroma(10)+chroma(11)+chroma(1)+chroma(3)+chroma(4)+chroma(6);
tonalMinorScale(9) = chroma(9)+chroma(11)+chroma(12)+chroma(2)+chroma(4)+chroma(5)+chroma(7);
tonalMinorScale(10) = chroma(10)+chroma(12)+chroma(1)+chroma(3)+chroma(5)+chroma(6)+chroma(8);
tonalMinorScale(11) = chroma(11)+chroma(1)+chroma(2)+chroma(4)+chroma(6)+chroma(7)+chroma(9);
tonalMinorScale(12) = chroma(12)+chroma(2)+chroma(3)+chroma(5)+chroma(7)+chroma(8)+chroma(10);

% tonalMajorSum = (tonalMajor + tonalMajor7)/2 + tonalMajorScale;
% tonalMinorSum = (tonalMinor + tonalMinor7)/2 + tonalMinorScale;
tonalMajorSum = tonalMajorScale;
tonalMinorSum = tonalMinorScale;
[maxMajor, majorIdx] = max(tonalMajorSum);
[maxMinor, minorIdx] = max(tonalMinorSum);
tonal = [0,0];
% if maxMajor == maxMinor
    if chroma(majorIdx) == chroma(minorIdx)
        tonal = [0,0]; % none key
    else
        if chroma(majorIdx) > chroma(minorIdx)
            tonal = [1, majorIdx]; % major key
        else
            tonal = [-1, minorIdx]; % minor key
        end
    end
