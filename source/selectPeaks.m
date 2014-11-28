function select = selectPeaks(input, locs, pks, threshold, wlength)

% select which peak to be the true bass, analysis first peak first
% algorithm:
% 1. pick a neighbourhood of N points around the peak location
% 2. compute the values of this neighbourhood
% 3. compute the local maximas of this neighbourhood
% 4. take the mean of the result of 3
% 5. compute the difference of the original peak value and the mean
% 6. if the difference larger than threshold, accept, otherwise, reject
% 7. Repeat 1-6 using the next peak location until accept, if there is no acceptance, use the first peak location

select = 1; % initialize select as 1 (default is the first peak location)
for i = 1:1:length(locs)
%     display(locs);
    if (locs(i) > wlength)
        N = (locs(i)-wlength:1:locs(i)+wlength);
    else
        break;
    end
%     display(N);
    V = input(N);
%     display(V);
    localMaximas = findpeaks(V);
%     display(localMaximas);
    if length(localMaximas) > 1
        localMaximas = sort(localMaximas);
        % delete the largest one
        localMaximas = localMaximas(1:end-1);
    end
    medlocalMaximas = median(localMaximas);
    meanlocalMaximas = mean(localMaximas);
%     display(medlocalMaximas);
%     display(meanlocalMaximas);
    stdlocalMaximas = std(localMaximas);
%     display(stdlocalMaximas);

    D = pks(i) - meanlocalMaximas;
%     display(D);

    if D < threshold
        continue;
    else
        select = i;
        break;
    end
end
% display(select);
