%load in Full struct with Neuron info
% maybe just have this be a function that inputs the path(or OBJ data), 
% SLA (segment length array) and PL(parent List) 
nn = 55;
s = ADataOrig(5);
name = s.name{nn};
IL = getItList(s.PL{nn}{1});
SLA = s.SLA{nn}{1};
Neuron = struct('name','');
Neuron(max(IL)).iterations = max(IL);
path = pwd;
scaling = 3;
% name = '7_0002_MFull100.obj';
path = fullfile(path,[name '.obj']);
[Vertices, ~, Faces, ~] = ReadOBJtest(path); % Get vertex and face data

%Find the x,y,z extremas

[zmin,zminloc]=min(Vertices{1}(:,3)); %finds min Z value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(zminloc,:); % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)-10];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

[ymin,yminloc]=min(Vertices{1}(:,2));%fines min Y value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(yminloc,:); % makes a duplicate of the lowest y value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)-10,Vertices{1}(size(Vertices{1},1),3)];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

[xmin,xminloc]=min(Vertices{1}(:,1));%finds min X value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(xminloc,:); % makes a duplicate of the lowest x value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1)-10,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

[zmax,zmaxloc]=max(Vertices{1}(:,3)); %finds largest x value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(zmaxloc,:); % makes a duplicate of the largest z value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)+10];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

[ymax,ymaxloc]=max(Vertices{1}(:,2));%Finds largest Y value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(ymaxloc,:); % makes a duplicate of the largest y value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+10,Vertices{1}(size(Vertices{1},1),3)];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

[xmax,xmaxloc]=max(Vertices{1}(:,1));% finds largest X value
Vertices{1}(size(Vertices{1},1)+1,:)=Vertices{1}(xmaxloc,:); % makes a duplicate of the largest x value
Vertices{1}(size(Vertices{1},1),:)=[Vertices{1}(size(Vertices{1},1),1)+10,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)];
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2),Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1)+1,Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)]; % makes a duplicate of the lowest Z value
Vertices{1}(size(Vertices{1},1)+1,:)=[Vertices{1}(size(Vertices{1},1),1),Vertices{1}(size(Vertices{1},1),2)+1,Vertices{1}(size(Vertices{1},1),3)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-3,size(Vertices{1},1)-2,size(Vertices{1},1)-1];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-2,size(Vertices{1},1)-1,size(Vertices{1},1)];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1)-1,size(Vertices{1},1),size(Vertices{1},1)-3];
Faces{1}(size(Faces{1},1)+1,:)= [size(Vertices{1},1),size(Vertices{1},1)-3,size(Vertices{1},1)-2];

Neuron(max(IL)).name = name;
Neuron(max(IL)).path = path;
Neuron(max(IL)).vertices = vertcat(Vertices{:,:});
Neuron(max(IL)).faces = vertcat(Faces{:,:});
% xrange = max(Neuron(max(IL)).vertices(1:end-12,1)) - min(Neuron(max(IL)).vertices(1:end-12,1));
% yrange = max(Neuron(max(IL)).vertices(1:end-12,2)) - min(Neuron(max(IL)).vertices(1:end-12,2));
% zrange = max(Neuron(max(IL)).vertices(1:end-12,3)) - min(Neuron(max(IL)).vertices(1:end-12,3));

xrange = max(Neuron(max(IL)).vertices(:,1)) - min(Neuron(max(IL)).vertices(:,1));
yrange = max(Neuron(max(IL)).vertices(:,2)) - min(Neuron(max(IL)).vertices(:,2));
zrange = max(Neuron(max(IL)).vertices(:,3)) - min(Neuron(max(IL)).vertices(:,3));

% Get x,y,z data of 
TempVox = VOXELISE(round(xrange*scaling), round(yrange*scaling), round(zrange*scaling), Neuron(max(IL)));
TempInd = find(TempVox);
[TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
Neuron(max(IL)).voxCoords = [TempX,TempY,TempZ];
Neuron(max(IL)).SLA = SLA;
Neuron(max(IL)).IL = IL;


for i =max(IL)-1:-1:1
    Neuron(i).name = name;
    Neuron(i).path = path;
    Neuron(i).iterations = i;
    cutV = [];
    cutBN = find(IL==i+1); %cutBranchNumber, the number of the branch in the SLA matrix we will cut
    cutV(:,1) = SLA(cutBN-1,2)*16+1;
    cutV(:,2) = SLA(cutBN,2)*16;
    cutVInd=[];
    Neuron(i).vertices=Neuron(i+1).vertices;
    Neuron(i).faces=Neuron(i+1).faces;
    for j = size(cutV,1):-1:1
        cutVInd = (cutV(j,1):cutV(j,2))';
        Neuron(i).vertices(cutVInd,:)=[];
        for k = 1:length(cutVInd)
            Neuron(i).faces(any(Neuron(i).faces==cutVInd(k),2),:)=[];
        end
        Neuron(i).faces(Neuron(i).faces >= cutV(j,1)) = Neuron(i).faces(Neuron(i).faces >= cutV(j,1))-length(cutVInd);
        SLA(cutBN(j):end,2) = SLA(cutBN(j):end,2)-(SLA(cutBN(j),2)-SLA(cutBN(j)-1,2)); %Adjust the SLA matrix 
        SLA(cutBN(j),:) = [];
        IL(cutBN(j)) = [];
    end
%     xrange = max(Neuron(i).vertices(1:end-12,1)) - min(Neuron(i).vertices(1:end-12,1));
%     yrange = max(Neuron(i).vertices(1:end-12,2)) - min(Neuron(i).vertices(1:end-12,2));
%     zrange = max(Neuron(i).vertices(1:end-12,3)) - min(Neuron(i).vertices(1:end-12,3));
%     xrange = max(Neuron(i).vertices(:,1)) - min(Neuron(i).vertices(:,1));
%     yrange = max(Neuron(i).vertices(:,2)) - min(Neuron(i).vertices(:,2));
%     zrange = max(Neuron(i).vertices(:,3)) - min(Neuron(i).vertices(:,3));    
    TempVox = VOXELISE(round(xrange*scaling), round(yrange*scaling), round(zrange*scaling), Neuron(i));
    TempInd = find(TempVox);
    [TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
    Neuron(i).voxCoords = [TempX,TempY,TempZ];
    %translate the result
%     Neuron(i).voxCoords = Neuron(i).voxCoords - (Neuron(i).voxCoords(1,:)-Neuron(i+1).voxCoords(1,:));

    Neuron(i).SLA = SLA;
    Neuron(i).IL = IL;
    
end

%find the unique voxels for iterations 2:end 
for i=length(Neuron):-1:2
Neuron(i).voxUnique = Neuron(i).voxCoords(~ismember(Neuron(i).voxCoords,Neuron(i-1).voxCoords,'rows'),:);
end
%find the unique voxels for the first iteration
V{1} = Neuron(1).vertices(end-23:end,:);
F{1} = Neuron(1).faces(end-23:end,:);
F{1} = F{1}-min(F{1}(1,1))+1;
Neuron(length(Neuron)+1).vertices = vertcat(V{:,:});
Neuron(length(Neuron)).faces = vertcat(F{:,:});
TempVox = VOXELISE(round(xrange*scaling), round(yrange*scaling), round(zrange*scaling), Neuron(length(Neuron)));
TempInd = find(TempVox);
[TempX, TempY, TempZ] = ind2sub(size(TempVox),TempInd);
Neuron(length(Neuron)).voxCoords = [TempX,TempY,TempZ];
Neuron(1).voxUnique = Neuron(1).voxCoords(~ismember(Neuron(1).voxCoords,Neuron(23).voxCoords,'rows'),:);

% for i=1:length(Neuron)
% %Clean the reference points
% Neuron(i).voxCoords(1,:) = [];
% Neuron(i).vertices(end,:) = [];
% end