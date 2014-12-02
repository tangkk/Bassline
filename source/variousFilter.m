function out = variousFilter(in, N, buffertype)

LI = length(in);
buffer = zeros(1,N);
out = zeros(1,LI) + 0.3; % 0.3 is to raise the DC level

if buffertype == 1
    for i = N+1:1:LI
        % refresh buffer everytime
        for j = i-N:1:i
            buffer(j - i + N + 1) = in(j);
        end

%         D = std(buffer);
        D = median(buffer);
%         D = max(buffer);
%         D = mean(buffer);
%         D = min(buffer);
        out(i) = D;
    end
else
    for i = N/2+1:1:LI - N/2
        % refresh buffer everytime
        for j = i-N/2:1:i+N/2
            buffer(j - i + N + 1) = in(j);
        end

%         D = std(buffer);
        D = median(buffer);
%         D = max(buffer);
%         D = mean(buffer);
%         D = min(buffer);
        out(i) = D;
    end 
end