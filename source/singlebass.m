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
    fftSPLSpec = normalize(fftSPLSpec);
    fftSPLSpec = noisegate(fftSPLSpec, 0);
    
    % compress the spectrum by loudness measure
    % fftSPLSpec = SPL2loudness(fftSPLSpec, f);
    
    % adaptively choosing a starting point of a working range
    [lstart, lend] = adaptiveRangeSelect(fftSPLSpec);
    
    % reduce the range of the spectrum for focusing of process
    [rf, rfftSPLSpec] = reduceLength(f, fftSPLSpec, lstart, lend);
    
    % pre-process the spectrum
    % fftSPLSpec = meanfilter(rfftSPLSpec,3);
    % fftSPLSpec = sgolayfilt(rfftSPLSpec, 5, 9);
    rfftSPLSpec = localmaxInterp(rfftSPLSpec);
    
    % normalize the features
    rfftSPLSpec = normalize(rfftSPLSpec);
    rfftSPLSpec = noisegate(rfftSPLSpec, 0);

    % peak detection
    [pks, locs] = myPeakPicking(rfftSPLSpec, minheight, mindist, minprom, isdebug, 0);
    
    % post-process the selected peaks and select final bass
    fpeaks = rf(locs);
    if isdebug    
        display(fpeaks);
    end
    bass = [];

    if ~isempty(fpeaks)
        pitchPeaks = freq2pitchclass(fpeaks);
        select = overtoneFilter(fftSPLSpec, lstart, lend, locs, 1, isdebug, 0);
        bass = pitch2name(pitchPeaks(select));
    end
    
    % plotting
    if isdebug == 1
        if isplot == 1
            myPlot(rf, rfftSPLSpec);
        end
        player = audioplayer(songMono, fs);
    else
        player = 0;
    end