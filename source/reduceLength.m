% reduce the length of input to a necessary range.
% When it comes to normalization, only the necessary part is normalized.

function [outa,outb] = reduceLength(ina, inb, lstart, lend)
outa = ina(lstart:lend);
outb = inb(lstart:lend);
