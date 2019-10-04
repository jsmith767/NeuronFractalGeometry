method = 'allangles';

for k=1:length(noWonk6it)
mID = noWonk6it(k);
% gID = 1;

% F = vertcat(masterN(mID).F{gID});
% V = vertcat(masterN(mID).data.(genvarname(method))(5).VAll{gID});
% IL = vertcat(masterN(mID).IL{gID});
% SLA = vertcat(masterN(mID).SLA{gID});
% SLA = SLA(:,2);

F = vertcat(masterN(mID).F{:});
V = vertcat(masterN(mID).data.(genvarname(method))(5).VAll{:});
IL = vertcat(masterN(mID).IL{:});
% get the SLA matrix in one list with appropriate referencing
SLA = [];
for i=1:length(masterN(mID).SLA)
    if i ==1
    SLA = vertcat(masterN(mID).SLA{i}(:,2));
    else
        SLA = [SLA ; vertcat(masterN(mID).SLA{i}(:,2))+ SLA(end)];
    end
end

VIL = zeros(length(V),1);
cmap = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[237 130 237];[237 130 237];[237 130 237]]/255;
% cmap = colormap(hsv(max(IL)));
%get the iteration list referenced by the vertices
VIL(1:SLA(1)*16,:) = IL(1) ;
for i=1:length(IL)-1
    VIL(SLA(i)*16+1:SLA(i+1)*16) = IL(i+1);
end
%get the faces reference by the faces
FIL = zeros(length(F),1);
for i =1:size(F,1)
    for j = 1:size(F,2)
        FIL(i,j) = VIL(F(i,j));
    end
end
figure
hold
for i=1:max(IL)
%     if i==8
%         disp(i);
%     end
    [Find,~] = find(FIL(:,3)==i);
    patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'EdgeColor',cmap(i,:))
%     patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'FaceAlpha',0.3,'EdgeColor',cmap(i,:),'EdgeAlpha',0.3)
%     patch('vertices',V,'faces',F(Find,:),'FaceColor',cmap(i,:),'LineWidth',0.1)
end
set(gca,'ytick',[],'yticklabel',[],'ycolor','white','xtick',[],'xticklabel',[],'xcolor','white');
axis equal
set(gcf, 'Color', 'w');
% view(45,45)
end