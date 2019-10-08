% load('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_P_Basal_Clean_4-18-19.mat')
% clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[220 38 127]]/255;
clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128]]/255;

NN = 90; % 90 for mNVox
viewpoints = 200;
p = 115;
gra = (1.0+sqrt(5.0))/2.0;
i = (-(viewpoints - 1):2:(viewpoints - 1))';
phi = 2*pi*i/gra;
theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
latlonlist(:,:) = [(pi/2)+theta';phi'];

NModel = cell(1,size(mNVox(NN).data.A(5).ItData,2));
% NMview = cell(1,size(mNVox(NN).data.A(5).ItData,2));
for i = 1:size(mNVox(NN).data.A(5).ItData,2)
    NModel{1,i} = mNVox(NN).data.A(5).ItData(i).voxUAll;
%     NMview{1,i} = NModel{1,i};
%     for d = 1:size(NMview{1,i},1)
%         NMview{1,i}(d,1:3) = rotationmat3D(-latlonlist(1,p),[cos(pi/2+latlonlist(2,p)) sin(pi/2+latlonlist(2,p)) 0])*NMview{1,i}(d,1:3)';
%     end
end

figure
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
hold;
for i = 1:length(clr)
%     scatter3(NMview{1,i}(:,1),NMview{1,i}(:,2),NMview{1,i}(:,3),15,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    scatter3(NModel{1,i}(:,1),NModel{1,i}(:,2),NModel{1,i}(:,3),10,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end