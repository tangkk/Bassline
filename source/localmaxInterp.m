function out = localmaxInterp(in)

    [y0,x0] = findpeaks(in);
    x1 = 1:1:length(in);
    y1 = interp1(x0,y0,x1);
    out = y1;
    
%   [y2,x2] = findpeaks(fftSPLSpec);
%   x3 = 1:1:length(fftSPLSpec);
%   y3 = interp1(x2,y2,x3);