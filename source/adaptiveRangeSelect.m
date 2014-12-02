function [locs, lstart, lend] = adaptiveRangeSelect(input, initminHeigth)

% This function adaptively calculate a starting point, and a a ending point the
% working range that is to be further processed by bass detection algortihm
% This is one of the pre-process stages
%
% input: fft sound pressure level spectrum
% output: a starting point and a ending point of the reduced spectrum
% algorithm:
% - find the peaks of input with a minimum height 0.85, store results in pks and
% locs
% - lstart = max(0,locs(1) - 300)
% - lend = min(len, locs(end) + 300)

len = length(input);
lstart = 1;
lend = len;
[pks, locs] = findpeaks(input, 'MinPeakHeight', initminHeigth);

if ~isempty(locs)
    lstart = max(1, locs(1) - 300);
    lend = min(len, locs(end) + 300);
end