function [P F] = getFiles(path)
    [P F] = subdir(path); 
    if isempty(F)
        Q = dir('*.obj');
        F{1} = {Q.name};
    %     clear Q;
        P{1} = pwd;
    end
    %clean all the files so we are only left with OBJS that are not sansoma
    indices = cell(1,length(F));
    for i=1:length(F)
        objs = strfind(F{i},'.obj');
        indices{i} = cellfun(@isempty,objs);
        F{i}(indices{i}) = [];
        objs = strfind(F{i},'sansoma');
        indices{i} = ~cellfun(@isempty,objs);
        F{i}(indices{i}) = [];
        objs = strfind(F{i},'._');
        indices{i} = ~cellfun(@isempty,objs);
        F{i}(indices{i}) = [];
    end
end