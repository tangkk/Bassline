function [bass, player] = singlebass(path, isdebug, isplot, minheight, mindist, minprom)

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
    
    % smooth the spectrum
    % fftSPLSpec = meanfilter(fftSPLSpec,3);
    % fftSPLSpec = sgolayfilt(fftSPLSpec, 5, 9);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;
    fftSPLSpec(fftSPLSpec < 0) = 0;

    % findpeaks of fft spectrum with small min distance
    bass = myPeakPicking(f,fftSPLSpec, minheight, mindist, minprom, isdebug);
    
    if isdebug == 1
        % plot the spectrum
        if isplot == 1
            myPlot(f, fftSPLSpec);
        end

        % play the song
        player = audioplayer(songMono, fs);
    else
        player = 0;
    end