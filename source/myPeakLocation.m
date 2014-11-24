function testd = myPeakLocation(input, f, minHeight, minDist, minProm)

% we define a peak hierarchy (vague):
%   - P0 stands for raw peaks(all local maximas)
%   - P1 stands for peaks in P0 with long increasing slope (in both
%   horizontal and vertical sense) (or equivalently with a large deviation
%   pre-neighbourhood)
%   - P2 stands for peaks in P1 that differentiate from neighbour peaks
%   with a certain amount

% another possible peak hierarchy definition (clear):
% - P0: all raw peaks (all local maximas)
% - P1: all local maximas of P0
% - P2: all local maximas of P1
% ...

% scan the input and return the peak values and locations according to the
% parameters and the peak hierarchy definition
%
% algorithm:
% define a buffer, and window length N, and threshold T
% initialize input scan index i = N
% initialize a deviation recorder dr = []
% initialize (peak,location) recorder pklcr = []
% while i < end - N, do:
%	- fill the buffer with input value at [i-N:1:i+N]
%   - D = std(buffer)
%   - if record on
%       record [D,i] in dr
%   - if std(buffer) > T, it indicates a potential peak in P1 is around
%       record on
%   - if # of D < T greater than a threshold TT
%       record off
%       p* = the global maximum value of all 'i's in dr
%       i* = the i of peak
%       clear dr
%       record [p*,i*] into pklcr if p* > minHeight
%
% return pklcr
%
%
N = 10;
T = 0.8;
TT = 5;
buffer = zeros(1,N);
LB = length(buffer);
LI = length(input);
dr = [];
idr = [];
pks = [];
locs = [];
record = 0;

testd = zeros(1,N)+0.3;

for i = N+1:1:LI
    % refresh buffer everytime
    for j = i-N:1:i
        buffer(j - i + N + 1) = input(j);
    end
    
%     D = std(buffer);
%     D = median(buffer);
    D = max(buffer);
    testd = [testd D];
    if record == 1
        dr = [dr D];
        idr = [idr i];
    end
    
    if D > T
        record = 1;
    end
    
    nDT = 0;
    for idt = 1:1:length(dr)
        if dr(idt) < T
            nDT = nDT + 1;
        end
        
        % if # of D < T greater than a threshold TT
        if nDT >= TT
            record = 0;
            [pd, id] = max(dr);
            
            % below is the p* and i* we'd like to locate
            ii = idr(id);
            pp = input(ii);
            
            idr = [];
            dr = [];
            if pp > 0
                pks = [pks pp];
                locs = [locs ii];
            end
            break;
        end
    end 
end

% figure;
% plot(input)
% hold;
% plot(testd);

% display(pks);
% display(locs);
% fpeaks = f(locs);
% display(fpeaks);














