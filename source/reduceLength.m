function [outa,outb] = reduceLength(ina, inb, n)
outa = ina(1:ceil(end/n));
outb = inb(1:ceil(end/n));
