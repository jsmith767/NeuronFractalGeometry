function text = OBJtoTXTA(scaling,file,path)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [Vertices, ~, Faces, ~] = ReadOBJtest(fullfile(path,file));
    [~,Neuron.name,~] = fileparts(file);
    Neuron.path = path;
    Neuron.vertices = vertcat(Vertices{:,:});
    Neuron.faces = vertcat(Faces{:,:});
    xrange = ceil(max(Neuron.vertices(:,1)) - min(Neuron.vertices(:,1)));
    yrange = ceil(max(Neuron.vertices(:,2)) - min(Neuron.vertices(:,2)));
    zrange = ceil(max(Neuron.vertices(:,3)) - min(Neuron.vertices(:,3)));
    TempVox = VOXELISE(ceil(xrange*scaling), ceil(yrange*scaling), ceil(zrange*scaling), Neuron);
    TempInd = find(TempVox);
    [TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
%     fileID = fopen(strcat(Neuron.path,['\'  num2str(ceil(yrange*scaling)) '_'],Neuron.name,'.txt'),'w');
%     fprintf(fileID,'{%d,%d,%d}\r\n', [TempX, TempY, TempZ]');
%     fclose(fileID);
    text = [TempX,TempY,TempZ];
end

% Bpath = strcat(path,'\Basal');
% [BP, BF] = openNeuronOBJS(Bpath);
% NumFams = length(BF);
% NumNeurs = length(BF{1});
% 
% for i = 1:NumFams
%     for j = 1:NumNeurs
%         [Vertices, ~, Faces, ~] = ReadOBJtest(strcat(BP{i},'\',BF{i}{j}));
%         Neuron.name = BF{i}{j}(1:end-4);
%         Neuron.path = BP{i};
%         Neuron.vertices = vertcat(Vertices{:,:});
%         Neuron.faces = vertcat(Faces{:,:});
%         xrange = ceil(max(Neuron.vertices(:,1)) - min(Neuron.vertices(:,1)));
%         yrange = ceil(max(Neuron.vertices(:,2)) - min(Neuron.vertices(:,2)));
%         zrange = ceil(max(Neuron.vertices(:,3)) - min(Neuron.vertices(:,3)));
%         TempVox = VOXELISE(xrange*scaling, yrange*scaling, zrange*scaling, Neuron);
%         TempInd = find(TempVox);
%         [TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
%         fileID = fopen(strcat(Neuron.path,'\',Neuron.name,'.txt'),'w');
%         fprintf(fileID,'{%d,%d,%d}\r\n', [TempX, TempY, TempZ]');
%         fclose(fileID);
%     end
% end
% 
% end
