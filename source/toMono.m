function songMono = toMono(song)

sizeSong = size(song);
if sizeSong(2) > 1
    songMono = (song(:,1)+song(:,2))/2;
    songMonoMax = max(abs(songMono));
    songMono = songMono ./ songMonoMax;

    songDif = (song(:,1) - song(:,2));
    songDifMax = max(abs(songDif));
    songDif = songDif ./ songDifMax;
else
    songMono = song;
    songMonoMax = max(abs(songMono));
    songMono = songMono ./ songMonoMax;
    songDif = song;
    songDifMax = max(abs(songDif));
    songDif = songDif ./ songDifMax;
end