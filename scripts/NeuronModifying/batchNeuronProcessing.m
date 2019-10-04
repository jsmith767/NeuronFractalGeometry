%Function that loads many files and writes them as processed obj files.

%get the files and corresponding paths
[P F] = subdir(pwd); 
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
%Process the neurons one at a time


for i=1:length(F)
    for j=1:length(F{i})
%         fileName = F{i}(j);
        [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
        filePath = P{i};
        %checks to see if the output file we will write already exists.
        %Have to look at 'writeOBJFulltest.m' to find the path.  clunky...
%         if ~(exist(fullfile('C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\',[fileName 'Full0.obj']),'file') == 2)
            try
                processNeuron(fileName,filePath);
            catch
                disp(['Something went wrong when processing' fileName]);
            end
%         end
    end
end

% workingFolder = pwd;
% 
% j = 1;
% numberOfFolders(j) = 1;
% paths = tree(pwd);
% finalFolder = false;
% while ~finalFolder
%     if any(size(dir([workingFolder '\*.obj' ]),1))
%         pathsToWrite = find(paths.Parent == j-2); 
%         if length(pathsToWrite) == 0
%             pathsToWrite = 1;
%         end
%         for i=1:length(pathsToWrite)
%             filePath = paths.get(pathsToWrite(i));
%             OBJFiles = getOBJS(filePath);
%             for k=1:length({OBJFiles.name})
%                 [~,fileName,~] = fileparts(OBJFiles(k).name);
%                 [filePath '\' fileName]
% %                 processNeuron(fileName,filePath);
%             end
%             
%         end
%         finalFolder = true;
%     else
%         for k=1:numberOfFolders(j)
%             workingFolder = paths.get(sum(numberOfFolders(1:j-1))+k);
%             [subdirs,numberOfFolders(j+1)] = getSubDirs(workingFolder);
%             for i=1:numberOfFolders(j+1)
%                 paths = paths.addnode(j,fullfile(paths.get(sum(numberOfFolders(1:j-1))+k),subdirs(i).name));
%             end
%         end
%         
% %         for K = 1:numberOfFolders
% %         thissubdir = subdirs(K).name;
% %         workingFolder = fullfile(mainfolder, thissubdir);
% %         end
% %         finalFolder = true;  %want this not to be here eventually.
%     end
%     j = j+1;
% end