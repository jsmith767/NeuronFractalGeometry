function [neurdata] = ReadSWC(FilePathAndName)

    fileID = fopen(FilePathAndName,'r');
    count = 0;
    tline = cell(1,1);
    while ~feof(fileID)
        count = count + 1;
        tline{1,count} = fgetl(fileID);
    end
    fclose(fileID);
    count = 0;
    for i = 1:size(tline,2)
        if isempty(tline{1,i})
            count = count + 1;
        elseif strcmp('#',tline{1,i}(1))
            count = count + 1;
        else
            break;
        end
    end
    neurdata = zeros(7,size(tline,2)-count);
    for i = count+1:size(tline,2)
        temp = textscan(tline{1,i},'%f');
        neurdata(:,i-count) = temp{1,1};
    end

end