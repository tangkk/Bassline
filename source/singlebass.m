function [bass, player] = singlebass(path, isdebug, isplot, minheight, mindist, minprom, threshold)

    %%%% detect a single bass %%%%
    [song,fs] = audioread(path);

    % normalize the song (songMono or songDif)
    songMono = toMono(song);
    
    % downsampling
    downSampleRate = 10;
    [songMono, fs] = myDownsample(songMono, downSampleRate, fs);

    % get the spectrogram and SPL of the piece (FFT) (Dif)
    [f, fftSPLSpec] = myFFT(songMono, fs);
    
    % compress the spectrum by loudness measure
    % fftSPLSpec = SPL2loudness(fftSPLSpec, f);
    
    % reduce the range of vectors
    % the reduced frequency range is about 350 Hz
    [f, fftSPLSpec] = reduceLength(f, fftSPLSpec, 64/downSampleRate);
    
    % preprocess the spectrum
    % fftSPLSpec = meanfilter(fftSPLSpec,3);
    % fftSPLSpec = sgolayfilt(fftSPLSpec, 5, 9);
    rawfftSPLSpet = fftSPLSpec;
    [y0,x0] = findpeaks(fftSPLSpec);
    x1 = 1:1:length(fftSPLSpec);
    y1 = interp1(x0,y0,x1);
    fftSPLSpec = y1;
%     [y2,x2] = findpeaks(fftSPLSpec);
%     x3 = 1:1:length(fftSPLSpec);
%     y3 = interp1(x2,y2,x3);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;
    fftSPLSpec(fftSPLSpec < 0) = 0;
    
    maxVal = max(rawfftSPLSpet);
    rawfftSPLSpet = rawfftSPLSpet ./ maxVal;
    rawfftSPLSpet(rawfftSPLSpet < 0) = 0;

    % findpeaks of fft spectrum with small min distance
    bass = myPeakPicking(f,rawfftSPLSpet, fftSPLSpec, minheight, mindist, minprom, threshold, isdebug);
    
    if isdebug == 1
        % plot the spectrum
        if isplot == 1
            myPlot(f, fftSPLSpec);
%             plot(x1, y00);
%             hold;
%             plot(x1, y1);
%             plot(x2, y2);
        end

        % play the song
        player = audioplayer(songMono, fs);
    else
        player = 0;
    end