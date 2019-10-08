clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[220 38 127]]/255;
% load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\masterH-14.mat')

HN = 139;
NN = 71;
viewpoints = 200;
p = 115;
gra = (1.0+sqrt(5.0))/2.0;
i = (-(viewpoints - 1):2:(viewpoints - 1))';
phi = 2*pi*i/gra;
theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
latlonlist(:,:) = [(pi/2)+theta';phi'];

HModel = cell(1,size(masterN(NN).data.W(5).ItData,2));
HMview = cell(1,size(masterN(NN).data.W(5).ItData,2));
NModel = cell(1,size(masterN(NN).data.W(5).ItData,2));
NMview = cell(1,size(masterN(NN).data.W(5).ItData,2));
for i = 1:size(masterN(NN).data.W(5).ItData,2)
    HModel{1,i} = masterH(HN).ptCloud(masterH(HN).ptCloud(:,4)==i,1:3);
    HMview{1,i} = HModel{1,i};
    for d = 1:size(HMview{1,i},1)
        HMview{1,i}(d,1:3) = rotationmat3D(-latlonlist(1,p),[cos(pi/2+latlonlist(2,p)) sin(pi/2+latlonlist(2,p)) 0])*HMview{1,i}(d,1:3)';
    end
    NModel{1,i} = masterN(NN).data.W(5).ItData(i).voxUAll;
    NMview{1,i} = NModel{1,i};
    for d = 1:size(NMview{1,i},1)
        NMview{1,i}(d,1:3) = rotationmat3D(-latlonlist(1,p),[cos(pi/2+latlonlist(2,p)) sin(pi/2+latlonlist(2,p)) 0])*NMview{1,i}(d,1:3)';
    end
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
figure
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
hold;
for i = 1:length(clr)
%     scatter3(HMview{1,i}(:,1),HMview{1,i}(:,2),HMview{1,i}(:,3),15,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    scatter3(HModel{1,i}(:,1),HModel{1,i}(:,2),HModel{1,i}(:,3),10,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end

% HTP4.XRuler.Axle.LineWidth = XaxWidth;
% set(NP1,'xtick',[],'xticklabel',[]);
% set(NP1,'ytick',Ny1Ticks,'yticklabel',Ny1TickLabels);
% xlim(NDlims);