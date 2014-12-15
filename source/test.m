% Filename: test.m
% Function: detect bass line of a song
% Author: tangkk
% Date: Oct. 5th 2014
% Organization: The University of Hong Kong

% set SINGLE = -1 to test all songs, SINGLE  = 0 to test one song
% SINGLE = section number to test a specific section
function test(NAME, SINGLE, EXCLUDE)

ISORDER = 1;
ISPLOT = 1;
MINPROM = 0.2;
MINHEIGHT = 0.80;
MINDIST = 20;
ROOT = '../testcase/realchords/';

switch SINGLE
    case '+'
        f = fopen('single.txt', 'r');
        SINGLE = fscanf(f, '%d');
        SINGLE = SINGLE + 1;
        fclose(f);
        TEST = 1;
        DEBUG = 1;
    case '-'
        f = fopen('single.txt', 'r');
        SINGLE = fscanf(f, '%d');
        SINGLE = SINGLE - 1;
        fclose(f);
        TEST = 1;
        DEBUG = 1;
    case '.'
        f = fopen('single.txt', 'r');
        SINGLE = fscanf(f, '%d');
        fclose(f);
        TEST = 1;
        DEBUG = 1;
    case '0'
        TEST = 1;
        DEBUG = 0;
    case '-1'
        TEST = 0;
        DEBUG = 0;
    otherwise
        SINGLE = str2num(SINGLE);
        TEST = 1;
        DEBUG = 1;
end
        
subRoots = dir(ROOT);
subRoots = subRoots(3:end); %exclude . and .. folder
numSongs = length(subRoots);
sumCorrectRate = 0;
sumLength = 0;
display(EXCLUDE);
%%%%%% test all %%%%%%
if TEST == 0 && ~isempty(subRoots)
    DEBUG = 0;
    correctRates = zeros(0, numSongs);
    for i = 1:1:numSongs
        name = subRoots(i).name;
        if ~isempty(strfind(EXCLUDE, name))
            continue;
        end
        foldername = [ROOT name '/'];
        [correctRate, lengthSong, misses] = bassline(DEBUG, SINGLE, ISORDER, ISPLOT, MINDIST, MINHEIGHT, MINPROM, foldername);
        sumCorrectRate = sumCorrectRate + correctRate*lengthSong;
        sumLength = sumLength + lengthSong;
        display(name);
        display(correctRate);
        correctRates(i) = correctRate;
    end

    avgCorrectRate = sumCorrectRate / sumLength;
    for j = 1:1:numSongs
        name = subRoots(j).name;
        if ~isempty(strfind(EXCLUDE, name))
            display(name);
            display('skip');
            continue;
        end
        s = [name ' correct rate is ' num2str(correctRates(j))];
        display(s);
    end
    display(avgCorrectRate);
end

%%%%%% test one %%%%%%
if TEST == 1
    testRoot = [ROOT NAME '/'];
    [correctRate, lengthSong, misses] = bassline(DEBUG, SINGLE, ISORDER, ISPLOT,MINDIST, MINHEIGHT, MINPROM, testRoot);
    display(NAME);
    display(lengthSong);
    display(misses);
    display(correctRate);
    display(SINGLE);
    f = fopen('single.txt', 'w');
    fprintf(f, '%d', SINGLE);
    fclose(f);
end

