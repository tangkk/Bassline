function [pks,locs] = myPeakPicking(input, minHeight, minDist, minProm, isdebug, isN)

% Peak hierarchy in general (clear):
%   - P0: all raw peaks (all local maximas)
%   - P1: all local maximas of P0
%   - P2: all local maximas of P1
%   ...

% Peak hierarchy in bass signal(vague):
%   - P0 stands for raw peaks(all local maximas)
%   - P1 stands for peaks in P0 with long increasing slope (in both
%   horizontal and vertical sense) (or equivalently with a large deviation
%   pre-neighbourhood)
%   - P2 stands for peaks in P1 that differentiate from neighbour peaks
%   with a certain amount
%   - P3 stands for peak in P2 that has an overtone sum larger than a
%   certain amount


% scan the input and return the peak values and locations according to the
% parameters and the peak hierarchy definition
% input: an array of data
% output: pks and their locs satisfying minHeight, minDist and minProm 
% algorithm:
% - initialize pks = [], locs = [], lastloc = 0, len = length of input
% - scan input points one by one
% - if input(i) > input(i-1) and input(i) > input(i+1)
%   - if input(i) > minHeight and dist(i, lastloc) > minDist
%       ?? - Lneighbourhood = [max(1,i-N):i]
%       ?? - Rneighbourhood = [i:min(len,i+N)]
%       - Lneighbourhood = [x:i], where input(x) >= input(i) and anything x' between x and i input(x') < input(i) or x = 1
%       - Rneighbourhood = [i:y], where input(y) >= input(i) and anything y' between i and y input(y') < input(i) or y = len
%       - prom = min(input(i) - min(LNBH), input(i) - min(RNBH))
%       - if prom > minProm
%           - add input(i) to pks, add i to locs
%           - lastloc = i
%
%
% try to replicate:
% [pks, locs] = findpeaks(input, 'MinPeakHeight', minheight, 'MinPeakDistance', mindist, 'MinPeakProminence', minprom);


pks = [];
locs = [];
lastloc = 1;
N = 300; % neighhood length
len = length(input);
for i = 2:1:len - 1
    if input(i) > input(i-1) && input(i) >= input(i+1)
        if input(i) >= minHeight && i - lastloc >= minDist
            this = input(i);
            x = 1;
            y = len;
            if isN
                lnbh = max(1,i-N):1:i;
                rnbh = i:1:min(len,i+N);
            else
                for j = i-1:-1:1
                    if input(j) >= this
                        x = j;
                        break;
                    end
                end
                for j = i+1:1:len
                    if input(j) >= this
                        y = j;
                        break;
                    end
                end
                lnbh = x:1:i;
                rnbh = i:1:y;
            end
            lprom = this - min(input(lnbh));
            rprom = this - min(input(rnbh));
            prom = min(lprom, rprom);
            if prom > minProm
                pks(end+1) = this;
                locs(end+1) = i;
                lastloc = i;
            end
        end
    end
end


