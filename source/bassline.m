 % Filename: bassline.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Aug. 16th 2014
% Organization: The University of Hong Kong

function [correctRate, lengthSong, misses, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, MINPROM, ROOT)

close all;

%%%% read files %%%%
[foldername, subfoldername] = readfolder(ROOT);

% sort files into an ascending section number order
[files, filenames] = sortfiles(ISORDER, ROOT);

% ground truth path and output path
groundtruthpath = ['../groundtruth/' subfoldername foldername '.txt'];
outputpath = ['../output/' foldername '.txt'];

if DEBUG == 0
    %%%% detect multiple basses %%%%
    fid = fopen(outputpath, 'w');
    for i = 1:1:length(files)  
        formatSpec = formatSelect(i, files);
        [bass, player] = singlebass([ROOT files(i).name], DEBUG, MINHEIGHT, MINWIDTH, MINPROM);
        fprintf(fid, formatSpec, i, files(i).name(1:end-4), bass);
    end
    fclose(fid);
    lengthSong = length(files);
    [correctRate, misses] = diffGroundTruth(outputpath, groundtruthpath);
end

if DEBUG == 1
    %%%% detect a single bass %%%%
    [bass, player] = singlebass([ROOT files(SINGLE).name], DEBUG, MINHEIGHT, MINWIDTH, MINPROM);
    
    trueBass = readGroundTruth(groundtruthpath, SINGLE);
    display(trueBass);
    display(bass);
    if isequal(trueBass, bass)
        correctRate = 1;
        misses = 0;
    else
        correctRate = 0;
        misses = SINGLE;
    end
end
    
% end of file
