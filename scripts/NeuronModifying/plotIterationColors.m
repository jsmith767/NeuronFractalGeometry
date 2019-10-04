%V is for vertices
%F is for faces
%FIL is for faces iteration list.  Should be the same length as F

%[V,VN, F,G] = ReadOBJtest('It6Branch2D1.41Length3413Width1.5Theta0Phi0BranchAngle90.N001.obj');
% V = vertcat(V{:});
% F = vertcat(F{:});
%FIL is the numerical matrix of the imported list from
%'It6Branch2D1.41Length3413Width1.5Theta0Phi0BranchAngle90.N001_FaceIts.txt'

function plotIterationColors(V,F,FIL)
cmap = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[237 130 237];[237 130 237];[237 130 237]]/255;
figure
hold
for i=1:max(FIL)
    [Find,~] = find(FIL==i);
    patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'EdgeColor',cmap(i,:))
%     patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'FaceAlpha',0.3,'EdgeColor',cmap(i,:),'EdgeAlpha',0.3)
%     patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'LineWidth',0.1)
end
set(gca,'ytick',[],'yticklabel',[],'ycolor','white','xtick',[],'xticklabel',[],'xcolor','white','ztick',[],'zticklabel',[],'zcolor','white');
axis equal
% view(45,45)
end