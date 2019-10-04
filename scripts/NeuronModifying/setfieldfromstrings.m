%this function writes the valueList associated with a stringlist to the
%given struct that has a 'name' field with the same strings
%with corrseponding names.
%the 'stringList' and 'valueList' should have the same indexing
function s = setfieldfromstrings(s,field,stringList,valueList)
    for i=1:length(s)
        for j=1:length(s(i).name)
        Index = strcmp(stringList,s(i).name{j});
        s(i).tempField{j}=valueList(Index);
        end
    end
    if isfield(s,field)
        disp(['Field already exists! Replacing field with the new one just created']);
        s = rmfield(s,field);
    end
    s = renamefield(s,'tempField',field);
end