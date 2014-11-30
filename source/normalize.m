function out = normalize(in)

scale = max(abs(in));
out = in./scale;