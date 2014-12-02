function select = peakFilter(initiallocs, currentlocs, N, ison)

% this function scans the currentlocs input one by one until find out a loc
% that a certain neighbourhood of N centered at 2*loc and 3*loc contains
% peak as well, and select that loc as bass

% input: currentlocs
% output: select
% algorithm:
% - select = 1
% - len = length of currentlocs
% - for i-th loc in currentlocs:
%   - lbound = max(1, loc-N);
%   - rbound = min(len, loc+N);
%   - if there is a loc in initiallocs within 2*(lbound,rbound) and there is a loc in initiallocs within 3*(lbound,rbound)
%       - select = i
%

select = 1;
if ison
    len = length(currentlocs);
    lenInit = length(initiallocs);
    for i = 1:1:len
        loc = currentlocs(i);
        lbound = max(1, loc-N);
        rbound = loc+N;
        check = 0;
        j = 1;
        for j = 1:1:lenInit
            initialloc = initiallocs(j);
            if initialloc >= 2*lbound && initialloc <= 2*rbound
                check = check + 1;
                break;
            end
        end
        for k = j:1:lenInit
            initialloc = initiallocs(k);
            if initialloc >= 3*lbound && initialloc <= 3*rbound
                check = check + 1;
                break;
            end
        end
        if check == 2
            select = i;
            break;
        end
    end
end