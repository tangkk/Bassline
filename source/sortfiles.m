function [files, filenames] = sortfiles(ISORDER, Root)

if ISORDER == 1
    files = dir([Root '*.mp3']);
    filenames = zeros(1, length(files));
    for i = 1:1:length(files)
        name = files(i).name;
        [token, remain] = strtok(files(i).name, '.');
        [token, remain] = strtok(remain, '.');
        num = str2num(token);
        filenames(i) = num;
    end
    [filenames, idx] = sort(filenames);
    files = files(idx);
else
    files = dir([Root '*.mp3']);
end