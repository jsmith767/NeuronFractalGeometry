%rename files
[P,F] = subdir(pwd);
for i=1:length(P)
    [path,gliaAnalysisFolder,ext] = fileparts(P{i});
    if strcmp(gliaAnalysisFolder,'gliaAnalysis')
        [~,Type,~] = fileparts(path);
        if strcmp(Type(end),'T')
            newFolderName = 'CNTGliaAnalysis';
        else
            newFolderName = 'SiGliaAnalysis';
        end
    end
    movefile(P{i},fullfile(path,newFolderName));     
end