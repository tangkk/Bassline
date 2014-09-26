function [outa,outb,outc,outd] = reduceLength(ina, inb, inc, ind)
outa = ina(1:ceil(end/64));
outb = inb(1:ceil(end/64));
outc = inc(1:ceil(end/64));
outd = ind(1:ceil(end/64));