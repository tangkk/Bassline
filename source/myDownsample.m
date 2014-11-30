% low pass and then downsampled (will not affect low freq)
function [out, fs] = myDownsample(in, n, fs)

in = myLPF(in);

out = downsample(in,n);

fs = fs/n;