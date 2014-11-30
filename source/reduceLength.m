% reduce the length of input to a necessary range.
% When it comes to normalization, only the necessary part is normalized.

function [outa,outb] = reduceLength(ina, inb, n)
outa = ina(1:ceil(end/n));
outb = inb(1:ceil(end/n));
