path = 'D:\Conor\Research\Mathematica\HTree-Models';
scaling = 3;

[Paths, Files] = subdir(path);
NumModTypes = size(Paths,2);
NumMods = zeros(1,NumModTypes);
for i = 1:NumModTypes
    NumMods(1,i) = size(Files{1,i},2);
end
for i = 2:NumModTypes
    for j = 1:1
        [Vertices, ~, Faces, ~] = ReadOBJtest(strcat(Paths{1,i},'\',Files{1,i}{1,j}));
        Model.name = Files{1,i}{1,j}(1:end-4);
        Model.path = Paths{1,i};
        Model.vertices = vertcat(Vertices{:,:});
        Model.faces = vertcat(Faces{:,:});
        xrange = max(Model.vertices(:,1)) - min(Model.vertices(:,1));
        yrange = max(Model.vertices(:,2)) - min(Model.vertices(:,2));
        zrange = max(Model.vertices(:,3)) - min(Model.vertices(:,3));
        TempVox = VOXELISE(round(xrange*scaling), round(yrange*scaling), round(zrange*scaling), Model);
        TempInd = find(TempVox);
        [TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
        fileID = fopen(strcat(Model.path,'\',Model.name,'.txt'),'w');
        fprintf(fileID,'{%d,%d,%d}\r\n', [TempX, TempY, TempZ]');
        fclose(fileID);
    end
end