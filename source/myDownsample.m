function [out, fs] = myDownsample(in, n, fs)

in = myLPF(in);

out = downsample(in,n);

fs = fs/n;