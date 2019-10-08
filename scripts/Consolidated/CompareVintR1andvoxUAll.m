clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[220 38 127]]/255;
neur = 1;
curv = 5;
NModel = cell(1,size(masterN(neur).data.P(curv).ItData,2));
NMview = cell(1,size(masterN(neur).data.P(curv).ItData,2));
for i = 1:size(masterN(neur).data.P(curv).ItData,2)
    NModel{1,i} = masterN(neur).data.P(curv).ItData(i).voxUAll;
%     NMview{1,i} = NModel{1,i};
%     for d = 1:size(NMview{1,i},1)
%         NMview{1,i}(d,1:3) = rotationmat3D(-latlonlist(1,p),[cos(pi/2+latlonlist(2,p)) sin(pi/2+latlonlist(2,p)) 0])*NMview{1,i}(d,1:3)';
%     end
end
figure
subplot(1,2,1)
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
hold;
for i = 1:size(masterN(neur).data.P(curv).ItData,2)
%     scatter3(NMview{1,i}(:,1),NMview{1,i}(:,2),NMview{1,i}(:,3),15,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    scatter3(NModel{1,i}(:,1),NModel{1,i}(:,2),NModel{1,i}(:,3),10,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
subplot(1,2,2)
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
hold;
scatter3(masterN(neur).data.P(curv).VintR1(:,1),masterN(neur).data.P(curv).VintR1(:,2),masterN(neur).data.P(curv).VintR1(:,3),10,'o','MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0])
