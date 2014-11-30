function out = noisegate(in, gate)

in(in < gate) = 0;
out = in;