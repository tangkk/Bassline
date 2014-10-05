TEST = 0;

DEBUG = 0;
SINGLE = 73;
ISORDER = 1;
MINWIDTH = 30;
MINHEIGHT = 0.90;
ROOT = '../testcase/realchords/';
subRoots = dir(ROOT);
subRoots = subRoots(3:end); %exclude . and .. folder
numSongs = length(subRoots);
sumCorrectRate = 0;
correctRates = [];

if TEST == 0
    if ~isempty(subRoots)
        for i = 1:1:length(subRoots)
            name = subRoots(i).name;
            foldername = [ROOT name '/'];
            correctRate = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, foldername);
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
    display(avgCorrectRate);
end

if TEST == 1
    ROOT = '../testcase/realchords/1984/';
    correctRate = bassline(DEBUG, SINGLE, ISORDER, MINWIDTH, MINHEIGHT, ROOT);
    display(correctRate);
end

