% clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[220 38 127]]/255;
clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128]]/255;
% load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\masterH-13.mat')

HN = 25;
viewpoints = 200;
p = 115;
gra = (1.0+sqrt(5.0))/2.0;
i = (-(viewpoints - 1):2:(viewpoints - 1))';
phi = 2*pi*i/gra;
theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
latlonlist(:,:) = [(pi/2)+theta';phi'];

HModel = cell(1,length(clr));
HMview = cell(1,length(clr));

% Model = ImportTxt_HTree('D:\Conor\Research\Mathematica\HTree-Models\2D\Mathematica-Txts\It10Branch2D1.90Length219184.Theta0Phi0BranchAngle90.001.txt');
% ExpModel = makePtsLarger_WithIB(Model,2);
% ExpModel = makePtsLarger_WithIB(masterH(HN).ptCloud,2);
% ExpModel = [ExpModel(:,3) ExpModel(:,2) ExpModel(:,1) ExpModel(:,4) ExpModel(:,5)];
for i = 1:length(clr)
    HModel{1,i} = Model(Model(:,3)==i,1:2);
%     HModel{1,i} = ExpModel(ExpModel(:,4)==i,1:3);
%     HMview{1,i} = HModel{1,i};
%     for d = 1:size(HMview{1,i},1)
%         HMview{1,i}(d,1:3) = rotationmat3D(-latlonlist(1,p),[cos(pi/2+latlonlist(2,p)) sin(pi/2+latlonlist(2,p)) 0])*HMview{1,i}(d,1:3)';
%     end
end

figure
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
hold;
for i = 1:length(clr)
%     scatter3(HMview{1,i}(:,1),HMview{1,i}(:,2),HMview{1,i}(:,3),15,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
%     scatter3(HModel{1,i}(:,1),HModel{1,i}(:,2),HModel{1,i}(:,3),40,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    scatter(HModel{1,i}(:,1),HModel{1,i}(:,2),20,'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end

% HTP4.XRuler.Axle.LineWidth = XaxWidth;
% set(NP1,'xtick',[],'xticklabel',[]);
% set(NP1,'ytick',Ny1Ticks,'yticklabel',Ny1TickLabels);
% xlim(NDlims);