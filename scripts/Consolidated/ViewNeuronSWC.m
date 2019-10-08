%%% SWC File format info
%%% Line 1 - an integer number as compartment identifier
%%% Line 2 - type of neuronal compartment
%%%             0 - undefined
%%%             1 - soma
%%%             2 - axon
%%%             3 - basal dendrite
%%%             4 - apical dendrite
%%%             5 - custom (user-defined preferences)
%%%             6 - unspecified neurites
%%%             7 - glia processes
%%% Line 3 - x coordinate of the compartment
%%% Line 4 - y coordinate of the compartment
%%% Line 5 - z coordinate of the compartment
%%% Line 6 - radius of the compartment
%%% Line 7 - parent compartment

% filename = 'C:\Users\William\Downloads\Hippocampus_CA1_SWC\arnold_johnston\CNG version\012117B_ECA.CNG.swc';
% filename = 'C:\Users\William\Downloads\RGC_SWC\kantor_szarka\CNG version\160107_B6_1.CNG.swc';
% filename = 'C:\Users\William\Downloads\neuron_nmo_human_RGC\votruba\CNG version\F2274-No6.CNG.swc';
% filename = 'C:\Users\William\Downloads\neuron_nmo_cerebellum\jacobs\CNG version\189-1-10dw.CNG.swc';
filename = 'C:\Users\William\Downloads\neuron_nmo_Purkinje\martone\CNG version\alxP.CNG.swc';

neurdata = ReadSWC(filename);
Model = neurdata(3:5,:)';
EModel = makePtsLarger(Model,5);
neurLims = [[min(EModel(:,1)) max(EModel(:,1))];[min(EModel(:,2)) max(EModel(:,2))];[min(EModel(:,3)) max(EModel(:,3))]];

clr = [[1 0 0];[1 0.55 0];[1 0.9 0];[0 1 0];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
SpineClr = [0.13 0.51 0.93];

NumLonLines = 60;
lon = 0:2*pi/(2*NumLonLines-1):2*pi;
lat = 0:2*pi/(2*(NumLonLines-1)):pi;
latlonlist = zeros(length(lat),length(lon),2);
latiC = 32; % For Neur88 (in plottingN_SH) use 34(Cold) and 52(Hot) for NumLonLines = 60
loniC = 39; % For Neur88 (in plottingN_SH) use 69(Cold) and 85(Hot) for NumLonLines = 60
latiH = 52;
loniH = 78;

% viewpoints = 200;
% gra = (1.0+sqrt(5.0))/2.0;
% i = (-(viewpoints - 1):2:(viewpoints - 1))';
% phi = 2*pi*i/gra;
% theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
% latlonlist(:,:) = [(pi/2)+theta';phi'];

for i = 1:length(lat)
    for j = 1:length(lon)
        latlonlist(i,j,:) = [lat(1,i) lon(1,j)];
    end
end

Mod = figure();
scatter3(Model(:,1),Model(:,2),Model(:,3),'k.');
xlim(neurLims(1,:))
ylim(neurLims(2,:))
zlim(neurLims(3,:))
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

% % EMod = figure();
% % scatter3(EModel(:,1),EModel(:,2),EModel(:,3),'.','MarkerFaceColor', SpineClr, 'MarkerEdgeColor', SpineClr);%,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1);
% % xlim(neurLims(1,:))
% % ylim(neurLims(2,:))
% % zlim(neurLims(3,:))
% % axis equal;
% % axis off;
% % grid off;
% % set(gca,'CameraViewAngleMode','Manual','color','none');
% % % view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
% % view(latlonlist(latiH,loniH,2)*180/pi,(pi/2-latlonlist(latiH,loniH,1))*180/pi);
% % % frame = getframe(EMod);
% % % im = frame2im(frame);
% % % [imind, cm] = rgb2ind(im,256);
% % % imwrite(imind,cm,['D:\Conor\Research\Figures\Neuron Analysis\FinalFigures\NeuronsWithDendriticSpineZone\Neur' num2str(N) 'Spines.png'],'png');