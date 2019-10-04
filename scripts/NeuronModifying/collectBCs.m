%should be in Apical or Basal folder of a particular curvature method
bp = 'binaries';
folders = dir(fullfile(bp,'bc*'));
if ~exist('boxCounts','dir')
    mkdir('boxCounts');
end
for i=1:length(folders)
    files = dir(fullfile(bp,folders(i).name,'*.mat'));
    for j=1:length(files)
        load(fullfile(bp,folders(i).name,files(j).name));
        bc.Curvature = bc.Curvature/100;
        BC(j)=bc;
    end
    save(fullfile('boxCounts',['B' num2str(BC(i).Curvature*100,'%03d') '_boxCounts.mat']),'BC'); 
end