% Filename: test.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Oct. 5th 2014
% Organization: The University of Hong Kong

TEST = 0;

DEBUG = 0;
SINGLE = 118;
ISORDER = 1;
MINPROM = 0.33;
MINHEIGHT = 0.89;
MINWIDTH = 40;
ROOT = '../testcase/realchords/';
NAME = 'anjing';
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
        [correctRate, lengthSong, misses, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, MINPROM, foldername);
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
    display(DEBUG);
    display(avgCorrectRate);
end

%%%%%% test one %%%%%%
if TEST == 1
    testRoot = [ROOT NAME '/'];
    [correctRate, lengthSong, misses, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, MINPROM, testRoot);
    display(DEBUG);
    display(NAME);
    display(lengthSong);
    display(misses);
    display(correctRate);
    if DEBUG == 1
        play(player);
    end
end

