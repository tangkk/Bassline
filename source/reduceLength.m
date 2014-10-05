function [outa,outb] = reduceLength(ina, inb)
outa = ina(1:ceil(end/64));
outb = inb(1:ceil(end/64));
