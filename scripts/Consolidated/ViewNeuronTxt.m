% Model = ImportTxt_HTree('D:\Conor\Research\Mathematica\HTree-Models\3D-12It\Mathematica-Txts\It12Branch2D2.00Length85000Width2.5Theta0.049Phi3.1BranchAngle90.001.txt');
% Neuron = load('D:\Conor\Research\Mathematica\HTree-Models\MATLAB-BoxCount\3D-12It-Straight\binaries\npymats\It12Branch2D2.00Length100000Width2.5Theta0Phi0BranchAngle90.001.mat');

clr = [[1 0 0];[1 0.55 0];[1 0.9 0];[0 1 0];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];

N = 78; % 88(with Group Column) or 90(without Group Column)
viewpoints = 200;
% p = 81;
latiC = 32; % For Neur88 (in plottingN_SH) use 34(Cold) and 52(Hot) for NumLonLines = 60
loniC = 39; % For Neur88 (in plottingN_SH) use 69(Cold) and 85(Hot) for NumLonLines = 60
latiH = 52;
loniH = 78;

SpineClr = [0.13 0.51 0.93];

% gra = (1.0+sqrt(5.0))/2.0;
% i = (-(viewpoints - 1):2:(viewpoints - 1))';
% phi = 2*pi*i/gra;
% theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
% latlonlist(:,:) = [(pi/2)+theta';phi'];
NumLonLines = 60;
lon = 0:2*pi/(2*NumLonLines-1):2*pi;
lat = 0:2*pi/(2*(NumLonLines-1)):pi;
latlonlist = zeros(length(lat),length(lon),2);
for i = 1:length(lat)
    for j = 1:length(lon)
        latlonlist(i,j,:) = [lat(1,i) lon(1,j)];
    end
end

Model = plottingN(N).data.P(5).VintR1;
% Model = masterN(N-2).data.P(5).VintR1;
EModel = makePtsLarger(Model,5);
neurLims = [[min(EModel(:,1)) max(EModel(:,1))];[min(EModel(:,2)) max(EModel(:,2))];[min(EModel(:,3)) max(EModel(:,3))]];

Mod = figure();
scatter3(Model(:,1),Model(:,2),Model(:,3),'k.');
xlim(neurLims(1,:))
ylim(neurLims(2,:))
zlim(neurLims(3,:))
% xlim([min(Model(:,1))-4 max(Model(:,1))+4]);
% ylim([min(Model(:,2))-4 max(Model(:,2))+4]);
% zlim([min(Model(:,3))-4 max(Model(:,3))+4]);
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
% view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
view(latlonlist(latiH,loniH,2)*180/pi,(pi/2-latlonlist(latiH,loniH,1))*180/pi);
% frame = getframe(Mod);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im,256);
% imwrite(imind,cm,['D:\Conor\Research\Figures\Neuron Analysis\FinalFigures\NeuronsWithDendriticSpineZone\Neur' num2str(N) '.png'],'png');

EMod = figure();
scatter3(EModel(:,1),EModel(:,2),EModel(:,3),'.','MarkerFaceColor', SpineClr, 'MarkerEdgeColor', SpineClr);%,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1);
xlim(neurLims(1,:))
ylim(neurLims(2,:))
zlim(neurLims(3,:))
% xlim([min(Model(:,1))-4 max(Model(:,1))+4]);
% ylim([min(Model(:,2))-4 max(Model(:,2))+4]);
% zlim([min(Model(:,3))-4 max(Model(:,3))+4]);
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual','color','none');
% view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
view(latlonlist(latiH,loniH,2)*180/pi,(pi/2-latlonlist(latiH,loniH,1))*180/pi);
% frame = getframe(EMod);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im,256);
% imwrite(imind,cm,['D:\Conor\Research\Figures\Neuron Analysis\FinalFigures\NeuronsWithDendriticSpineZone\Neur' num2str(N) 'Spines.png'],'png');

% % % Model2 = plottingN(N).data.W(2).VintR1;
% % % figure
% % % scatter3(Model2(:,1),Model2(:,2),Model2(:,3),'k.')
% % % xlim([57 323]);
% % % ylim([18 320]);
% % % zlim([-62 200]);
% % % axis equal;
% % % axis off;
% % % grid off;
% % % set(gca,'CameraViewAngleMode','Manual');
% % % view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
% % % 
% % % Model3 = plottingN(N).data.W(8).VintR1;
% % % figure
% % % scatter3(Model3(:,1),Model3(:,2),Model3(:,3),'k.')
% % % xlim([57 323]);
% % % ylim([18 320]);
% % % zlim([-62 200]);
% % % axis equal;
% % % axis off;
% % % grid off;
% % % set(gca,'CameraViewAngleMode','Manual');
% % % view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
% % 
% % 
% % % load('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_56_W_Prof.mat')
% % figure
% % axis equal;
% % axis off;
% % grid off;
% % hold;
% % for i = 1:size(mNVox(N).data.A(5).ItData,2)
% %     scatter3(mNVox(N).data.A(5).ItData(i).voxUAll(:,1),mNVox(N).data.A(5).ItData(i).voxUAll(:,2),mNVox(N).data.A(5).ItData(i).voxUAll(:,3),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% % end
% % set(gca,'CameraViewAngleMode','Manual');
% % view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);