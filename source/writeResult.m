function writeResult(output)

fid = fopen('output.txt', 'w');
formatSpec = 'Bass %s \n';
fprintf(fid, formatSpec, output);
fclose(fid);