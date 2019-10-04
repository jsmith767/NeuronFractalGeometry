%Scaling loop for OBJtoTXTA
% oldpath = path;
% path(oldpath,'/gpfs/projects/taylorlab/shared/MATLABfxns');

scaling = 2;
files = dir('*.obj');
for j = 1:length(files)
    for i=1:length(scaling)
        OBJtoTXTA(scaling(i),files(j).name,files(j).folder);
    end
end
