% modify the groundtruth file
function modify(groundtruthpath)

r = 'from [1234567890.]* to [1234567890.]* ';
postfix = '.aif';

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
        
        fidgroundtruth = fopen(groundtruthpath, 'w');
        for i = 1:numel(A)
            ss = A{i};
%             [startIndex, endIndex] = regexpi(ss,r);
%             sb = [ss(1:startIndex - 2) ss(endIndex:end)];
%             A{i} = sb;

            idx1 = strfind(ss, '.');
            idx2 = strfind(ss, ' is');
            sss = ss(idx1+1:idx2-1);
            num = str2num(sss);
            newnum = (num+1)/2;
            newstr = num2str(newnum);
            
            sb = [ss(1:idx1) newstr ss(idx2:end)];
            A{i} = sb;
            if A{i+1} == -1
                fprintf(fidgroundtruth,'%s', A{i});
                break
            else
                fprintf(fidgroundtruth,'%s\r\n', A{i});
            end
        end
        fclose(fidgroundtruth);
end