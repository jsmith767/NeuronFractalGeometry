% load(['D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both-New\MATs\masterH-' num2str(1) '.mat']);



% For Neurons
n = 1;
% Points = plottingN2(1).data.W(1).VintR1;
NSkel = plottingN2(1).data.W(5).V;
SLA = plottingN2(1).SLA;
Points = [];
for g = 1:size(NSkel,2)
    Points = [Points; NSkel{1,g}];
end
Center = mean(Points(:,1:3));
ArbR = ArborRadius_Neuron(NSkel,SLA);
[Hull, CHV] = convhull(Points(:,1:3));
CHSA = getTriangleAreas(Points,Hull);
[Sx, Sy, Sz] = sphere;


figure();
scatter3(Points(:,1),Points(:,2),Points(:,3),'k.')
hold on;
trisurf(Hull,Points(:,1),Points(:,2),Points(:,3),'FaceAlpha',0.2,'FaceColor','red')
surf(Sx.*ArbR+Center(1,1),Sy.*ArbR+Center(1,2),Sz.*ArbR+Center(1,3),'FaceAlpha',0.2,'FaceColor','blue');
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');

% % For HTrees
% n = 41;
% Points = masterH(n).ptCloud;
% Center = mean(Points(:,1:3));
% 
% ArbR = ArborRadius_HTree(Points);
% [Hull, CHV] = convhull(Points(:,1:3));
% [Sx, Sy, Sz] = sphere;
% 
% figure();
% scatter3(Points(:,1),Points(:,2),Points(:,3),'k.')
% hold on;
% trisurf(Hull,Points(:,1),Points(:,2),Points(:,3),'FaceAlpha',0.2,'FaceColor','red')
% surf(Sx.*ArbR+Center(1,1),Sy.*ArbR+Center(1,2),Sz.*ArbR+Center(1,3),'FaceAlpha',0.2,'FaceColor','blue');
% axis equal;
% axis off;
% grid off;
% set(gca,'CameraViewAngleMode','Manual');