function OBJFiles = getOBJS(path)

subdirs = dir(path);
        
%This filters out all the items in the main folder that are not directories
subdirs([subdirs.isdir]) = [];
objs = strfind({subdirs.name},'.obj');
indices = cellfun(@isempty,objs);
subdirs(indices) = [];
sansoma = strfind({subdirs.name},'sansoma');
indices = ~cellfun(@isempty,sansoma);
subdirs(indices) = [];

%And this filters out the parent and current directory '.' and '..'
tf = ismember( {subdirs.name}, {'.', '..'});
subdirs(tf) = [];
OBJFiles = subdirs;
end