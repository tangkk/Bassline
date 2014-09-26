function [loudness] = SPL2loudness(fftSPLSpec, f)

% calculate the A-weighting curve
RaNom = ((12200.^2).*(f.^4));
RaDeNom = ((f.^2+20.6.^2).*sqrt((f.^2+107.7.^2).*(f.^2+737.9.^2)).*(f.^2+12200.^2));
Ra = RaNom ./ RaDeNom;
aWeighting = 2.0 + 20.*log10(Ra);

loudness = fftSPLSpec + transpose(aWeighting);

% figure;
% plot(f,aWeighting);
% title('A-weigthing');
% xlabel('Frequency (Hz)');
% ylabel('Gain(dB)');