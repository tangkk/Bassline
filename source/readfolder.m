function [foldername, subfoldername] = readfolder(Root)

[a, b] = strtok(Root, '/');
[a, b] = strtok(b, '/');
[a, b] = strtok(b, '/');
[a, b] = strtok(b, '/');
foldername = a;
subfoldername = 'realchords/';