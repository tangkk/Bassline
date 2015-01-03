function select = doubleFilter(pitchPeaks)

select = 1;
while select < length(pitchPeaks)
    done = 0;
    selectname = pitch2name(pitchPeaks(select));
    
    % locate another pitch peak that is with the same pitch name
    % as the selected peak
    for i = 1:1:length(pitchPeaks)
        if i == select
            continue;
        end
        name = pitch2name(pitchPeaks(i));
        if selectname == name
            done = 1;
            break;
        end
    end
    if done == 1
        break;
    else
        select = select + 1;
    end
end

if select == length(pitchPeaks)
    select = 1;
end