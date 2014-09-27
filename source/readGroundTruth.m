function trueBass = readGroundTruth(groundtruthpath, SINGLE)

if exist(groundtruthpath, 'file') == 2
    % Read txt into cell A
    fidgroundtruth = fopen(groundtruthpath,'r');
    i = 1;
    tline = fgetl(fidgroundtruth);
    A{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fidgroundtruth);
        A{i} = tline;
    end
    fclose(fidgroundtruth);

    Line = A{SINGLE};
    Line = fliplr(Line);
    [trueBass, remain] = strtok(Line,' ');
    trueBass = fliplr(trueBass);
end