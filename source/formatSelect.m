function formatSpec = formatSelect(i)

if ispc
    if i < length(files)
        formatSpec = '%d Bass of %s is %s\r\n';
    else
        formatSpec = '%d Bass of %s is %s';
    end
else
    if ismac
       if i < length(files)
        formatSpec = '%d Bass of %s is %s\n';
       else
        formatSpec = '%d Bass of %s is %s';
       end 
    end
end