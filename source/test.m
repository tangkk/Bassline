TEST = 1;

DEBUG = 0;
SINGLE = 2;
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

%%%%%% test all %%%%%%
if TEST == 0
    if ~isempty(subRoots) && DEBUG == 0
        for i = 1:1:length(subRoots)
            name = subRoots(i).name;
            foldername = [ROOT name '/'];
            [correctRate, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, foldername);
            sumCorrectRate = sumCorrectRate + correctRate;
            display(name);
            display(correctRate);
            correctRates = [correctRates correctRate];
        end
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
    [correctRate, player] = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, testRoot);
    display(DEBUG);
    display(NAME);
    display(correctRate);
    if DEBUG == 1
        play(player);
    end
end

