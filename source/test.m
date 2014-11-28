% Filename: test.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Oct. 5th 2014
% Organization: The University of Hong Kong

% set SINGLE = -1 to test all songs, SINGLE  = 0 to test one song
% SINGLE = section number to test a specific section

SINGLE = -1;
ISORDER = 1;
ISPLOT = 1;
MINPROM = 0.20;
MINHEIGHT = 0.6;
MINDIST = 15;
THRESHOLD = 0;
ROOT = '../testcase/realchords/';
NAME = '1984';

if SINGLE == 0
    TEST = 1;
    DEBUG = 0;
else
    if SINGLE == -1
        TEST = 0;
        DEBUG = 0;
    else
        TEST = 1;
        DEBUG = 1;
    end
end
subRoots = dir(ROOT);
subRoots = subRoots(3:end); %exclude . and .. folder
numSongs = length(subRoots);
sumCorrectRate = 0;
sumLength = 0;
correctRates = [];
misses = [];

%%%%%% test all %%%%%%
if TEST == 0 && ~isempty(subRoots)
    DEBUG = 0;
    for i = 1:1:length(subRoots)
        name = subRoots(i).name;
        foldername = [ROOT name '/'];
        [correctRate, lengthSong, misses, player] = bassline(DEBUG, SINGLE, ISORDER, ISPLOT, MINDIST, MINHEIGHT, MINPROM, THRESHOLD, foldername);
        sumCorrectRate = sumCorrectRate + correctRate*lengthSong;
        sumLength = sumLength + lengthSong;
        display(name);
        display(correctRate);
        correctRates = [correctRates correctRate];
    end

    avgCorrectRate = sumCorrectRate / sumLength;
    for j = 1:1:length(subRoots)
        s = [subRoots(j).name ' correct rate is ' num2str(correctRates(j))];
        display(s);
    end
    display(avgCorrectRate);
end

%%%%%% test one %%%%%%
if TEST == 1
    testRoot = [ROOT NAME '/'];
    [correctRate, lengthSong, misses, player] = bassline(DEBUG, SINGLE, ISORDER, ISPLOT,MINDIST, MINHEIGHT, MINPROM, THRESHOLD, testRoot);
    display(NAME);
    display(lengthSong);
    display(misses);
    display(correctRate);
    if DEBUG == 1
        play(player);
    end
end

