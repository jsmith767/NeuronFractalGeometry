%Takes a set of vertices and faces and interpolates more points between
%them.  
% would love this function to make a finer mesh..

function Points = makeSurface2D(VAll,F,stepSize)
% [VAll,~,F,G] = ReadOBJtest(fullfile(pwd,['7_0002_MFull100' '.obj']));
id = 'MATLAB:scatteredInterpolant:InterpEmptyTri2DWarnId';
warning('off', id)
tic
Points = zeros(10000000,3);
% stepSize = 0.1;
numPoints = 0;
for i=1:length(F)
%     x = [VAll{1}(F{1}(i,1),1);VAll{1}(F{1}(i,2),1);VAll{1}(F{1}(i,3),1)];
%     y = [VAll{1}(F{1}(i,1),2);VAll{1}(F{1}(i,2),2);VAll{1}(F{1}(i,3),2)];
%     z = [VAll{1}(F{1}(i,1),3);VAll{1}(F{1}(i,2),3);VAll{1}(F{1}(i,3),3)];
%     a = VAll{1}(F{1}(i,3),:)-VAll{1}(F{1}(i,1),:);
%     b = VAll{1}(F{1}(i,2),:)-VAll{1}(F{1}(i,1),:);
    x = [VAll(F(i,1),1);VAll(F(i,2),1);VAll(F(i,3),1)];
    y = [VAll(F(i,1),2);VAll(F(i,2),2);VAll(F(i,3),2)];
    z = [VAll(F(i,1),3);VAll(F(i,2),3);VAll(F(i,3),3)];
%     a = VAll(F(i,3),:)-VAll(F(i,1),:);
%     b = VAll(F(i,2),:)-VAll(F(i,1),:);    
%     vnorm = cross(a,b)/norm(cross(a,b));
%     znorm = [0,0,1]; 
%     TF = createRotationVector3d(vnorm, znorm);
%     [X,Y,Z] = transformPoint3d(x,y,z, TF);
    [xq,yq] = meshgrid(min(x):stepSize:max(x), min(y):stepSize:max(y));
    zq = griddata(x,y,z,xq,yq);
    if ~isempty(zq)
        v = [xq(:), yq(:),zq(:)];
        v(any(isnan(v), 2), :) = [];
    %     newPoints = transformPoint3d(v, TF');
        newPoints = v;
        numPointsPrev = numPoints;
        numPoints = numPointsPrev + size(newPoints,1)+3;
        Points(numPointsPrev+1:numPoints,:) = [newPoints; [x,y,z]];
    end
end
Points = Points(1:numPoints,:);
toc
warning('on', id)
end


% points=[0 0 3; 0 1 2.6; 0 1.3 2.3; 0 2.2 1.8; 0 2.5 0.8; 0 2.8 0; 0 2.2 -0.8; 0 1.9 -1.1; 0 1.3 -1.8; 0 1 -2.5; 0 0 -3; 0 -0.5 -2.7; 0 -1.1 -2.3; 0 -1.8 -1.8; 0 -2.1 -1; 0 -2.5 0; 0 -2.2 0.5; 0 -1.8 1.8; 0 -1.5 2.3; 0 -0.8 2.8;0 0 3];
% points = [1,1,1;1,0,0];
% vec1=[1 0 0];
% vec2=[0 1 0];
% myPlane = [0 0 10 vec1 vec2];
% TF = createBasisTransform3d(myPlane,'global');
% newPoints = transformPoint3d(points, TF);
% 
% points = [1,0,0;1,1,1];
% vnorm = [1,0,0];
% znorm = [0,0,1];
% TF = createRotationVector3d(vnorm, znorm);
% newPoints = transformPoint3d(points, TF);
% 
% scatter3(points(:,1),points(:,2),points(:,3))
% hold
% scatter3(newPoints(:,1),newPoints(:,2),newPoints(:,3))
% axis equal
% 

%This is the shit!!! finds my area in a nice way. (won't account for the
%overlap though
% polygons = meshFacePolygons(v, f);
% areas = polygonArea3d(polygons);
% sum(areas)


% for i=1:length(masterN)
% [VAll,~,F,G] = ReadOBJtest([masterN(i).name 'Full100.obj']);
% for j=1:length(VAll)
% F{j} = F{j} -min(min(F{j}))+1;
% polygons = meshFacePolygons(VAll{j}, F{j});
% areas = polygonArea3d(polygons);
% A(j) = sum(areas);
% end
% masterN(i).data.allangles(5).SA = sum(A);
% end