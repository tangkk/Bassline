function [bass, player] = singlebass(path, isdebug, minheight, minwidth)

    %%%% detect a single bass %%%%
    [song,fs] = audioread(path);

    % normalize the song (songMono or songDif)
    songMono = toMono(song);

    % get the spectrogram and SPL of the piece (FFT) (Dif)
    [f, fftSPLSpec] = myFFT(songMono, fs);
    
    % reduce the range of vectors
    [f, fftSPLSpec] = reduceLength(f, fftSPLSpec);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;

    % findpeaks of fft spectrum with small min distance
    bass = peakPicking(f,fftSPLSpec, minheight, minwidth);
    
    if isdebug == 1
        % plot the spectrum
        myPlot(f, fftSPLSpec);

        % play the song
        player = audioplayer(songMono, fs);
    else
        player = 0;
    end