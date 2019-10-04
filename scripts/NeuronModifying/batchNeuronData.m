%Function that grabs data from neuronOBjs.
%still needs some work

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


VRM = cell(1,length(F));
DM = cell(1,length(F));
WL = cell(1,length(F));
PL = cell(1,length(F));
V = cell(1,length(F));
VAll = cell(1,length(F));
SLA = cell(1,length(sort([F{:}])));
slope = cell(length(sort([F{:}])),2);
k=1;
for i=1:length(F)
    for j=1:length(F{i})
%         fileName = F{i}(j);
        [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
        filePath = P{i};
        %checks to see if the output file we will write already exists.
        %Have to look at 'writeOBJFulltest.m' to find the path.  clunky...
%         if ~(exist(fullfile('C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\',[fileName 'Full0.obj']),'file') == 2)
            try
                [V,VAll,~,SLA{k},~,~,~] = getNeuronData(fileName,filePath);
                slope{k,2} = processNeuronData(SLA{k});
                slope{k,1} = fileName;
                k=k+1;
            catch
                disp(['Something went wrong when getting data' fileName]);
            end
%         end
    end
end
name = 'slopeDataApical.dat';
path = 'C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Apical\';
T = cell2table(slope,'VariableNames',{'fileName','slope'});
writetable(T,name);
% fileID = fopen(name,'wt');
% formatspec = '%s %f\n';
% for i=1:length(slope)
%    fprintf(fileID, formatspec,slope{i,:});
% end
% fclose(fileID);

movefile(name,path,'f');
