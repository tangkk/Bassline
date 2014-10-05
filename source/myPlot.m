function myPlot(f, fftSPLSpec)

close all;

% figure;
% plot(f,fftAmpSpec);
% title('Single-Sided Amplitude Spectrum of song');
% xlabel('Frequency (Hz)');
% ylabel('|song(f)|');

figure('Position', [500 0 1000 700]);
plot(f, fftSPLSpec);
title('Single-Sided Sound Pressure Level Spectrum of song');
xlabel('Frequency (Hz)');
ylabel('Sound Pressure Level (dB)');

% figure;
% plot(f,loudness);
% title('Single-Sided Loudness Spectrum of song');
% xlabel('Frequency (Hz)');
% ylabel('loudness (dB)');
    
% figure;
% bar(chroma);
% set(gca, 'XTickLabel', {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#','B'});
% xlabel('chroma');

% figure;
% bar(basschroma);
% set(gca, 'XTickLabel', {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#','B'});
% xlabel('basschroma');