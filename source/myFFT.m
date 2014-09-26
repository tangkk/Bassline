function [f, fftAmpSpec, fftSPLSpec] = myFFT(song, fs)

songLength = length(song);
NFFT = 2^nextpow2(songLength);
fftSong = fft(song,NFFT);
f = fs/2*linspace(0,1,NFFT/2+1);

% "The signal is real-valued and has even length.
% Because the signal is real-valued, you only need power estimates for the
% positive or negative frequencies. In order to conserve the total power,
% multiply all frequencies that occur in both sets ? the positive and
% negative frequencies ? by a factor of 2. Zero frequency (DC) and
% the Nyquist frequency do not occur twice."

fftAmpSpec = abs(fftSong(1:NFFT/2+1))/songLength;
fftAmpSpec(2:end-1) = 2*fftAmpSpec(2:end-1);
fftSPLSpec = (1/songLength).*abs(fftSong(1:NFFT/2+1)).^2;
fftSPLSpec(2:end-1) = 2*fftSPLSpec(2:end-1);
pref = 20.*10.^(-6);
fftSPLSpec = 10*log10(fftSPLSpec./(pref.^2));
% do not normalize
% maxfftAmpSpec = max(fftAmpSpec);
% fftAmpSpec = fftAmpSpec ./ maxfftAmpSpec;

