function [Folders,numberOfFolders] = getSubDirs(path)

subdirs = dir(path);
        
%This filters out all the items in the main folder that are not directories
subdirs(~[subdirs.isdir]) = [];
%And this filters out the parent and current directory '.' and '..'
tf = ismember( {subdirs.name}, {'.', '..'});
subdirs(tf) = [];
numberOfFolders = length(subdirs);
Folders = subdirs;
end