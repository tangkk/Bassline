function rename(files, root)

for i = 1:1:length(files)
    s = files(i).name;
    [a,b] = strtok(s,'.');
    filehead = a;
    [a,b] = strtok(b,'.');
    num = str2num(a);
    newnum = (num+1)/2;
    newstr = num2str(newnum);
    newfilename = [filehead '.' newstr '.mp3'];
    movefile([root files(i).name], [root newfilename]);
end