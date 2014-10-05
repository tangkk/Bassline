% Filename: bassline.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

function [correctRate, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, ROOT)

%%%% input parameters %%%%
% DEBUG = 1;
% SINGLE = 73;
% ISORDER = 1;
% MINWIDTH = 30;
% MINHEIGHT = 0.92;
% ROOT = '../testcase/realchords/shijiemori/';

%%%% read files %%%%
[foldername, subfoldername] = readfolder(ROOT);

% sort files into an ascending section number order
[files, filenames] = sortfiles(ISORDER, ROOT);

% DEBUG = 1 single section, DEBUG = 0, whole song
if DEBUG == 0
    %%%% detect multiple basses %%%%
    outputpath = ['../output/' foldername '.txt'];

    fid = fopen(outputpath, 'w');
    
    player = 0;
    
    for i = 1:1:length(files)
        
        formatSpec = formatSelect(i, files);

        [song,fs] = audioread([ROOT files(i).name]);

        % normalize the song (songMono or songDif)
        [songDif, songMono] = toMono(song);

        % get the spectrogram and SPL of the piece (FFT) (Dif)
        [f, fftAmpSpec, fftSPLSpec] = myFFT(songMono, fs);

        % modify the result by A-weighting
        fftLoudness = SPL2loudness(fftSPLSpec, f);
        
        % reduce the range of vectors
        [f, fftAmpSpec, fftSPLSpec, fftLoudness] = reduceLength(f, fftAmpSpec, fftSPLSpec, fftLoudness);
    
        % normalize the features
        maxVal = max(fftSPLSpec);
        fftSPLSpec = fftSPLSpec ./ maxVal;

        % findpeaks of fft spectrum with small min distance
        [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftSPLSpec, MINHEIGHT, MINWIDTH);
        
        close all;

        fprintf(fid, formatSpec, i, files(i).name(1:end-4), bass);

    end

    fclose(fid);

    groundtruthpath = ['../groundtruth/' subfoldername foldername '.txt'];
    
    correctRate = diffGroundTruth(outputpath, groundtruthpath);

end

if DEBUG == 1
    
    %%%% detect a single bass %%%%
    [song,fs] = audioread([ROOT files(SINGLE).name]);

    % normalize the song (songMono or songDif)
    [songDif, songMono] = toMono(song);
    
    % play the song
    player = audioplayer(songMono, fs);

    % get the spectrogram and SPL of the piece (FFT) (Dif)
    [f, fftAmpSpec, fftSPLSpec] = myFFT(songMono, fs);

    % modify the result by A-weighting
    fftLoudness = SPL2loudness(fftSPLSpec, f);
    
    % reduce the range of vectors
    [f, fftAmpSpec, fftSPLSpec, fftLoudness] = reduceLength(f, fftAmpSpec, fftSPLSpec, fftLoudness);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;
    
    myPlot(f, fftAmpSpec, fftSPLSpec, fftLoudness);

    % findpeaks of fft spectrum with small min distance
    [pitchPeaks, pksavg, bass, bassfreq] = peakPicking(f,fftSPLSpec, MINHEIGHT, MINWIDTH);
    
    groundtruthpath = ['../groundtruth/' subfoldername foldername '.txt'];

    trueBass = readGroundTruth(groundtruthpath, SINGLE);
    
    overtones = overtonegen(bassfreq);
    display(trueBass);
    display(bass);
    if (trueBass == bass)
        display('Yes');
        correctRate = 1;
    else
        display('No');
        correctRate = 0;
    end
    
end
    
% end of file
