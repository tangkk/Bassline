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
    rawfftSPLSpec = fftSPLSpec;
    
    % compress the spectrum by loudness measure
    % fftSPLSpec = SPL2loudness(fftSPLSpec, f);
    
    % reduce the range of vectors
    % the reduced frequency range is about 350 Hz
    [f, fftSPLSpec] = reduceLength(f, fftSPLSpec, 64/downSampleRate);
    reducedfftSPLSpec = fftSPLSpec;
    
    % pre-process the spectrum
    % fftSPLSpec = meanfilter(fftSPLSpec,3);
    % fftSPLSpec = sgolayfilt(fftSPLSpec, 5, 9);
    fftSPLSpec = localmaxInterp(fftSPLSpec);
    
    % normalize the features
    maxVal = max(fftSPLSpec);
    fftSPLSpec = fftSPLSpec ./ maxVal;
    fftSPLSpec(fftSPLSpec < 0) = 0;
    
    maxVal = max(reducedfftSPLSpec);
    reducedfftSPLSpec = reducedfftSPLSpec ./ maxVal;
    reducedfftSPLSpec(reducedfftSPLSpec < 0) = 0;

    % peak detection
    [pks, locs] = myPeakPicking(fftSPLSpec, minheight, mindist, minprom, isdebug);
    
    % post-process the selected peaks and select final bass
    fpeaks = f(locs);
    if isdebug    
        display(fpeaks);
    end
    bass = [];

    if ~isempty(fpeaks)
        pitchPeaks = freq2pitchclass(fpeaks);
        select = overtoneFilter(reducedfftSPLSpec, pks, locs, 0, isdebug);
        bass = pitch2name(pitchPeaks(select));
%         bass = pitch2name(pitchPeaks(1));
    end
    
    % plotting
    if isdebug == 1
        if isplot == 1
            myPlot(f, fftSPLSpec);
        end
        player = audioplayer(songMono, fs);
    else
        player = 0;
    end