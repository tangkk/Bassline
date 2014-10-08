% Filename: test.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Oct. 5th 2014
% Organization: The University of Hong Kong

TEST = 0;

DEBUG = 0;
SINGLE = 118;
ISORDER = 1;
MINWIDTH = 30;
MINHEIGHT = 0.90;
ROOT = '../testcase/realchords/';
NAME = '1984';
subRoots = dir(ROOT);
subRoots = subRoots(3:end); %exclude . and .. folder
numSongs = length(subRoots);
sumCorrectRate = 0;
correctRates = [];
misses = [];

%%%%%% test all %%%%%%
if TEST == 0 && ~isempty(subRoots) && DEBUG == 0
    for i = 1:1:length(subRoots)
        name = subRoots(i).name;
        foldername = [ROOT name '/'];
        [correctRate, misses, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, foldername);
        sumCorrectRate = sumCorrectRate + correctRate;
        display(name);
        display(correctRate);
        correctRates = [correctRates correctRate];
    end

    avgCorrectRate = sumCorrectRate / numSongs;
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
    [correctRate, misses, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, testRoot);
    display(DEBUG);
    display(NAME);
    display(misses);
    display(correctRate);
    if DEBUG == 1
        play(player);
    end
end

