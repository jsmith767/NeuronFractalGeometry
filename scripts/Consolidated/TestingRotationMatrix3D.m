Model = plottingN(88).data.W(5).VintR1;
M = [Model,ones(size(Model,1),1)];
EModel = makePtsLarger(plottingN(88).data.W(5).VintR1,5);
ME = [EModel,ones(size(EModel,1),1)];

xcen = mean(EModel(:,1));
ycen = mean(EModel(:,2));
zcen = mean(EModel(:,3));

% 349 max 4897 min

latloni = 349;
Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
MEview = (makehgtform('translate',[-xcen -ycen -zcen])*ME')';
for p = 1:size(Mview,1)
    Mview(p,1:3) = rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*Mview(p,1:3)';
    MEview(p,1:3) = rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*MEview(p,1:3)';
end
RM = round(MEview);
RM = sortrows(RM,3,'Ascend');
[~,ia,~] = unique(RM(:,1:2),'rows');
PlatlonH = length(RM(ia,:));
% figure; scatter(Mview(:,1),Mview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');
% figure; scatter(MEview(:,1),MEview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');
figure; scatter3(Mview(:,1),Mview(:,2),Mview(:,3),'k.'); axis equal; axis off; grid off; set(gca,'CameraViewAngleMode','Manual','color','none');
figure; scatter3(MEview(:,1),MEview(:,2),MEview(:,3),'k.'); axis equal; axis off; grid off; set(gca,'CameraViewAngleMode','Manual','color','none');

% % % % latloni = 4897;
% % % % Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
% % % % MEview = (makehgtform('translate',[-xcen -ycen -zcen])*ME')';
% % % % for p = 1:size(Mview,1)
% % % %     Mview(p,1:3) = rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*Mview(p,1:3)';
% % % %     MEview(p,1:3) = rotationmat3D(-latlonlistall{1,7}(1,latloni),[cos(pi/2+latlonlistall{1,7}(2,latloni)) sin(pi/2+latlonlistall{1,7}(2,latloni)) 0])*MEview(p,1:3)';
% % % % end
% % % % RM = round(MEview);
% % % % RM = sortrows(RM,3,'Ascend');
% % % % [~,ia,~] = unique(RM(:,1:2),'rows');
% % % % PlatlonC = length(RM(ia,:));
% % % % figure; scatter(Mview(:,1),Mview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');
% % % % figure; scatter(MEview(:,1),MEview(:,2),'k.'); axis equal; axis off; grid off;% set(gca,'CameraViewAngleMode','Manual','color','none');

% Model = zeros(13143,3);
% MClr = [[0 0 0];[1 0 0];[0 0 1]];
% 
% latlonlist = [[0 0];[pi/2 0];[0 pi/4];[pi/4 pi/4];[pi 0];[3*pi/4 pi/4];[pi pi/4]];
% viewpoints = size(latlonlist,1);
% 
% count = 0;
% for i = -50:50
%     for j = -50:50
%         count = count + 1;
%         Model(count,:) = [i j 0];
%     end
% end
% sqcount = count;
% for i = -30:30
%     for j = -30:30
%         if sqrt(i^2+j^2)<=30
%             count = count + 1;
%             Model(count,:) = [i j 50];
%         end
%     end
% end
% cicount = count - sqcount;
% for i = -30:30
%     count = count + 1;
%     Model(count,:) = [i i -50];
% end
% for i = -30:30
%     count = count + 1;
%     Model(count,:) = [i -i -50];
% end
% crcount = count - cicount - sqcount -1; %-1 for extra (0,0,-50) point at center of cross
% % Model = unique(Model,'rows');
% 
% % figure;
% % hold on;
% % scatter3(Model(1:sqcount,1),Model(1:sqcount,2),Model(1:sqcount,3),'.','MarkerFaceColor', MClr(1,:), 'MarkerEdgeColor', MClr(1,:));
% % scatter3(Model(sqcount+1:sqcount+cicount,1),Model(sqcount+1:sqcount+cicount,2),Model(sqcount+1:sqcount+cicount,3),'.','MarkerFaceColor', MClr(2,:), 'MarkerEdgeColor', MClr(2,:));
% % scatter3(Model(sqcount+cicount+1:crcount+sqcount+cicount,1),Model(sqcount+cicount+1:crcount+sqcount+cicount,2),Model(sqcount+cicount+1:crcount+sqcount+cicount,3),'.','MarkerFaceColor', MClr(3,:), 'MarkerEdgeColor', MClr(3,:));
% % axis equal;
% % axis off;
% % grid off;
% % set(gca,'CameraViewAngleMode','Manual');
% % view([0 0 1]);
% 
% M = [Model,ones(size(Model,1),1)];
% G = [[55 0 0 1];[0 55 0 1]];
% xcen = 0;
% ycen = 0;
% zcen = 0;
% for i = 1:viewpoints
%     Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
%     Gview = (makehgtform('translate',[-xcen -ycen -zcen])*G')';
%     for p = 1:size(Mview,1)
%         Mview(p,1:3) = rotationmat3D(-latlonlist(i,1),[cos(pi/2+latlonlist(i,2)) sin(pi/2+latlonlist(i,2)) 0])*Mview(p,1:3)';
%     end
%     for p = 1:size(Gview,1)
%         Gview(p,1:3) = rotationmat3D(-latlonlist(i,1),[cos(pi/2+latlonlist(i,2)) sin(pi/2+latlonlist(i,2)) 0])*Gview(p,1:3)';
%     end
%     figure;
%     hold on;
%     scatter3(Mview(1:sqcount,1),Mview(1:sqcount,2),Mview(1:sqcount,3),'.','MarkerFaceColor', MClr(1,:), 'MarkerEdgeColor', MClr(1,:));
%     scatter3(Mview(sqcount+1:sqcount+cicount,1),Mview(sqcount+1:sqcount+cicount,2),Mview(sqcount+1:sqcount+cicount,3),'.','MarkerFaceColor', MClr(2,:), 'MarkerEdgeColor', MClr(2,:));
%     scatter3(Mview(sqcount+cicount+1:crcount+sqcount+cicount,1),Mview(sqcount+cicount+1:crcount+sqcount+cicount,2),Mview(sqcount+cicount+1:crcount+sqcount+cicount,3),'.','MarkerFaceColor', MClr(3,:), 'MarkerEdgeColor', MClr(3,:));
%     scatter3(Gview(:,1),Gview(:,2),Gview(:,3),50,'o','MarkerFaceColor', [0 1 0], 'MarkerEdgeColor', [0 1 0]);
%     axis equal;
%     axis off;
%     grid off;
%     set(gca,'CameraViewAngleMode','Manual');
%     view([0 0 1]);
% end