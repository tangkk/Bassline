function select = overtoneFilter(input, lstart, lend, locs, halfwindow, isdebug, ison)

% input: spectrum and location of peaks
% output: selection of the location of true bass
% algorithm:
% initialize select = loc with the highest pks
% for each loc in locs:
%   if 3*(loc+halfwindow) > length of input
%       stop
%   take a neighbourhood of 'window' size around this loc
%   for overtone  = 1 to 3:
%       shift neigbourhood overtone times (if overtone = 1, no shift)
%       calculate the sum value of this neighbourhood
%       store the accumulative sum with the original loc as the key
%
% select the loc with maximum sum
%

if ison
    select = 1;
    len = length(input);
    % guard the searching range based on the working range
    locmax = min(lend,len);
    locs = locs + lstart - 1;

    overtonesum = zeros(1, length(locs));
    for i = 1:1:length(locs)
        loc = locs(i);
        if 3*(loc+halfwindow) > locmax
            break;
        end

        if loc <= halfwindow
            continue;
        end
        neighbourhood = (loc - halfwindow):1:(loc+halfwindow);
        for overtone = 1:1:3
            overtonesum(i) = overtonesum(i) + sum(input(overtone*neighbourhood)./overtone);
        end
    end

    if ~isempty(overtonesum)
        [m,oi] = max(overtonesum);
        if overtonesum(oi) - overtonesum(1) > 0.5
            select = oi;
        end
    end

    if isdebug
        display(overtonesum);
        display(select);
    end
    
else
    select = 1;
end