function out = variousFilter(in)

N = 10;
LI = length(in);
buffer = zeros(1,N);
out = zeros(1,LI)+0.3;

for i = N+1:1:LI
    % refresh buffer everytime
    for j = i-N:1:i
        buffer(j - i + N + 1) = in(j);
    end
    
%     D = std(buffer);
%     D = median(buffer);
    D = max(buffer);
    out(i) = D;
end
