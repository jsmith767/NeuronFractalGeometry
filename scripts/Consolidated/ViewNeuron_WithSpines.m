Model = plottingN(88).data.W(5).VintR1;
M = [Model,ones(size(Model,1),1)];
SpineClr = [0.13 0.51 0.93];

xcen = mean(Model(:,1));
ycen = mean(Model(:,2));
zcen = mean(Model(:,3));

% 349 max 4897 min

latloni = 349;
Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
for p = 1:size(Mview,1)
    Mview(p,1:3) = round(rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*Mview(p,1:3)');
end
MEview = makePtsLarger(Mview,5);
RM = round(MEview);
RM = sortrows(RM,3,'Ascend');
[~,ia,~] = unique(RM(:,1:2),'rows');
PlatlonH = length(RM(ia,:));
figure; scatter(MEview(:,1),MEview(:,2),'.','MarkerFaceColor',SpineClr); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');
hold on;
scatter(Mview(:,1),Mview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');

latloni = 4897;
Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
for p = 1:size(Mview,1)
    Mview(p,1:3) = round(rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*Mview(p,1:3)');
end
MEview = makePtsLarger(Mview,5);
RM = round(MEview);
RM = sortrows(RM,3,'Ascend');
[~,ia,~] = unique(RM(:,1:2),'rows');
PlatlonC = length(RM(ia,:));
figure; scatter(MEview(:,1),MEview(:,2),'.','MarkerFaceColor',SpineClr); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');
hold on;
scatter(Mview(:,1),Mview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');