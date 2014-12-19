function bass = singlebass(path, isdebug, isplot, minheight, mindist, minprom)

    %%%% detect a single bass %%%%
    bass = [];
    [song,fs] = audioread(path);
    
    % playback the audio for debugging
    if isdebug
        player = audioplayer(song, fs);
        playblocking(player);
    end
    
    % normalize the song (songMono or songDif)
    songMono = toMono(song);
    
    % calculate various music features
%     up = unitpower(songMono);
%     zcr = zeroCrossingRate(songMono);
    
    % downsampling
    [songMono, fs] = myDownsample(songMono, 10, fs);

    % get the spectrogram and SPL of the piece (FFT) (Dif)
    [f, fftAmpSpec, fftSPLSpec] = myFFT(songMono, fs);
    fftSPLSpec = normalize(fftSPLSpec);
    fftSPLSpec = noisegate(fftSPLSpec, 0);
    fftAmpSpec = normalize(fftAmpSpec);
    fftAmpSpec = noisegate(fftAmpSpec, 0);
%     plot(f,fftSPLSpec);
    
    % gather some musical information to be further utilized
%     [basschroma, bassmax] = basschromagram(fftAmpSpec, f);
%     bassmax = pitch2name(bassmax);
%     [chroma, chromamax] = chromagram(fftAmpSpec, f);
%     chromamax = pitch2name(chromamax);
%     tonal = tonality(chroma);
%     tonalgravity = pitch2name(tonal(2));
%     tonaltype = pitch2name(tonal(1));
    
    % compress the spectrum by loudness measure
    % fftSPLSpec = spl2loudness(fftSPLSpec, f);
    
    % adaptively choosing a starting point of a working range
    [initiallocs, lstart, lend] = adaptiveRangeSelect(fftSPLSpec, 0.85, 300);
    
    % reduce the range of the spectrum for focusing of process
    [rf, rfftSPLSpec] = reduceLength(f, fftSPLSpec, lstart, lend);
    
    % pre-process the spectrum
%     rfftSPLSpec = sgolayfilt(rfftSPLSpec, 5, 9);
%     rfftSPLSpec = variousFilter(rfftSPLSpec, 10, 0);
    rfftSPLSpec = localmaxInterp(rfftSPLSpec);
    
    % normalize the features
    rfftSPLSpec = normalize(rfftSPLSpec);
    rfftSPLSpec = noisegate(rfftSPLSpec, 0);

    % peak detection
    [pks, locs] = myPeakPicking(rfftSPLSpec, minheight, mindist, minprom, isdebug, 0);
    
    % post-process the selected peaks and select final bass
    fpeaks = rf(locs);
    if ~isempty(fpeaks)
        pitchPeaks = freq2pitchclass(fpeaks);
        select = 1;
%         select = overtoneFilter(fftSPLSpec, lstart, lend, locs, 3, isdebug, 1);
%         select = peakFilter(initiallocs, lstart + locs - 1, 100, 1);
        bass = pitch2name(pitchPeaks(select));
    end
    
    % plotting
    if isdebug == 1
        for i = 1:1:length(pitchPeaks)
            display(pitch2name(pitchPeaks(i)));
        end
        if isplot == 1
            myPlot(rf, rfftSPLSpec);
        end
    end