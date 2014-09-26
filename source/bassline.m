% Filename: bassline.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

% iterate through all songs

% if DEBUG = 1, test the beatwise section one by one, otherwise test the whole song
DEBUG = 1;
SINGLE = 74;

ISORDER = 1;

MINWIDTH = 30;
MINHEIGHT = 0.9;

%%%% read files %%%%
Root = '../testcase/realchords/anjing/';
[a, b] = strtok(Root, '/');
[a, b] = strtok(b, '/');
[a, b] = strtok(b, '/');
[a, b] = strtok(b, '/');
foldername = a;
subfoldername = 'realchords/';

% sort files into an ascending section number order
if ISORDER == 1
    files = dir([Root '*.mp3']);
    filenames = zeros(1, length(files));
    for i = 1:1:length(files)
        name = files(i).name;
        [token, remain] = strtok(files(i).name, '.');
        [token, remain] = strtok(remain, '.');
        num = str2num(token);
        filenames(i) = num;
    end
    [filenames, idx] = sort(filenames);
    files = files(idx);
else
    files = dir([Root '*.mp3']);
end


startTime = 0;
endTime = 0;

if DEBUG == 1
    
    %%%% detect a single bass %%%%
    
    [song,fs] = audioread([Root files(SINGLE).name]);

    % normalize the song (songMono or songDif)
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

    playerMono = audioplayer(songMono, fs);
    playerDif = audioplayer(songDif, fs);
    playerSong = audioplayer(song, fs);
    play(playerMono);
%     play(playerDif);
%     play(playerSong);

    startTime = endTime;
    endTime = endTime + length(songMono)./fs; % in unit of second

    % get the spectrogram and SPL of the piece (FFT) (Dif)
    % TODO: do constant-Q instead of FFT
%     [f, fftAmpSpec, fftSPLSpec] = myFFT(songDif, fs);
    [f, fftAmpSpec, fftSPLSpec] = myFFT(songMono, fs);

    % modify the result by A-weighting
    fftLoudness = SPL2loudness(fftSPLSpec, f);
    
    % reduce the range of vectors
    [f, fftAmpSpec, fftSPLSpec, fftLoudness] = reduceLength(f, fftAmpSpec, fftSPLSpec, fftLoudness);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;
    
%     % polyfit the spectrum and subtract the polyfit line
%     p = polyfit((1:numel(fftSPLSpec))', fftSPLSpec, 5);
%     pval = polyval(p,(1:numel(fftSPLSpec))');
%     fftSPLSpec = fftSPLSpec - pval;
%     fftSPLSpec = fftSPLSpec / max(fftSPLSpec);
    
    myPlot(f, fftAmpSpec, fftSPLSpec, fftLoudness);

    % findpeaks of fft spectrum with small min distance
    [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftSPLSpec, MINHEIGHT, MINWIDTH);
%     [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftAmpSpec, MINHEIGHT, MINWIDTH);
    
    groundtruthpath = ['../groundtruth/' subfoldername foldername '.txt'];

    if exist(groundtruthpath, 'file') == 2
        % Read txt into cell A
        fidgroundtruth = fopen(groundtruthpath,'r');
        i = 1;
        tline = fgetl(fidgroundtruth);
        A{i} = tline;
        while ischar(tline)
            i = i+1;
            tline = fgetl(fidgroundtruth);
            A{i} = tline;
        end
        fclose(fidgroundtruth);
        
        Line = A{SINGLE};
        Line = fliplr(Line);
        [trueBass, remain] = strtok(Line,' ');
        trueBass = fliplr(trueBass);
    end
    
    overtones = overtonegen(bassfreq);
    display(trueBass);
    display(bass);
    if (trueBass == bass)
        display('Yes');
    else
        display('No');
    end
%     display(SINGLE);
%     display(overtones);
    
else
    %%%% detect multiple basses %%%%
    
    outputpath = ['../output/' foldername '.txt'];

    if exist(outputpath, 'file') == 2
        delete(outputpath);
    end

    fid = fopen(outputpath, 'w');
    
    for i = 1:1:length(files)
        
        if ispc
            if i < length(files)
                formatSpec = '%d Bass of %s is %s\r\n';
            else
                formatSpec = '%d Bass of %s is %s';
            end
        else
            if ismac
               if i < length(files)
                formatSpec = '%d Bass of %s is %s\n';
               else
                formatSpec = '%d Bass of %s is %s';
               end 
            end
        end

        [song,fs] = audioread([Root files(i).name]);

        % normalize the song (songMono or songDif)
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

        startTime = endTime;
        endTime = endTime + length(songMono)./fs; % in unit of second

        % get the spectrogram and SPL of the piece (FFT) (Dif)
        % TODO: do constant-Q instead of FFT
%         [f, fftAmpSpec, fftSPLSpec] = myFFT(songDif, fs);
        [f, fftAmpSpec, fftSPLSpec] = myFFT(songMono, fs);

        % modify the result by A-weighting
        fftLoudness = SPL2loudness(fftSPLSpec, f);
        
        % reduce the range of vectors
        [f, fftAmpSpec, fftSPLSpec, fftLoudness] = reduceLength(f, fftAmpSpec, fftSPLSpec, fftLoudness);
    
        % normalize the features
        maxVal = max(fftSPLSpec);
        fftSPLSpec = fftSPLSpec ./ maxVal;
        
%         % polyfit the spectrum and subtract the polyfit line
%         p = polyfit((1:numel(fftSPLSpec))', fftSPLSpec, 5);
%         pval = polyval(p,(1:numel(fftSPLSpec))');
%         fftSPLSpec = fftSPLSpec - pval;
%         fftSPLSpec = fftSPLSpec / max(fftSPLSpec);

        % findpeaks of fft spectrum with small min distance
        [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftSPLSpec, MINHEIGHT, MINWIDTH);
%         [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftAmpSpec, MINHEIGHT, MINWIDTH);
% 
%         chroma = chromagram(fftAmpSpec, f);
%     
%         basschroma = basschromagram(fftAmpSpec, f);
%     
%         tonal  = tonality(chroma);
        
        close all;
%         myPlot(f, fftAmpSpec, fftSPLSpec, fftLoudness, chroma, basschroma)

        fprintf(fid, formatSpec, i, files(i).name(1:end-4), bass);

    end

    fclose(fid);

    groundtruthpath = ['../groundtruth/' subfoldername foldername '.txt'];
    
    %%%% compare the correct rate %%%%
    if exist(groundtruthpath, 'file') == 2
        fid1 = fopen(groundtruthpath);
        fid2 = fopen(outputpath);
        lines = 0;
        misses = 0;
        missesvector = [];
        count = 0;

        tline1 = fgets(fid1);
        tline2 = fgets(fid2);
        while (ischar(tline1) && ischar(tline2))
            count = count+1;
            lines = lines + 1;
            if ~isequal(tline1, tline2)
                misses = misses + 1;
                missesvector = [missesvector count];
            end
            tline1 = fgets(fid1);
            tline2 = fgets(fid2);
        end

        correctRate = (lines - misses)./lines;

        fclose(fid1);
        fclose(fid2);

        disp(correctRate);
        disp(missesvector);
    end

end

% end of file
