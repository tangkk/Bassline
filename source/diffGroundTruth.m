function diffGroundTruth(outputpath, groundtruthpath)

%%%% compare the correct rate %%%%
if exist(groundtruthpath, 'file') == 2
    fid1 = fopen(groundtruthpath);
    fid2 = fopen(outputpath);
    lines = 0;
    misses = 0;
    missesvector = [];
    count = 0;

    tline1 = fgets(fid1);
    tline2 = fgets(fid2);
    while (ischar(tline1) && ischar(tline2))
        count = count+1;
        lines = lines + 1;
        if ~isequal(tline1, tline2)
            misses = misses + 1;
            missesvector = [missesvector count];
        end
        tline1 = fgets(fid1);
        tline2 = fgets(fid2);
    end

    correctRate = (lines - misses)./lines;

    fclose(fid1);
    fclose(fid2);

    disp(correctRate);
    disp(missesvector);
end