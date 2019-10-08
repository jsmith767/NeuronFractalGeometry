clr = [[1 0 0];[1 0.55 0];[1 0.9 0];[0 1 0];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];

N = 6;
viewpoints = 200;
p = 10;
SpineClr = [0.13 0.51 0.93];

% gra = (1.0+sqrt(5.0))/2.0;
% i = (-(viewpoints - 1):2:(viewpoints - 1))';
% phi = 2*pi*i/gra;
% theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
% latlonlist(:,:) = [(pi/2)+theta';phi'];
NumLatLines = 20;
lon = 0:2*pi/(NumLatLines+1):2*pi;
lat = fliplr(0:pi/(NumLatLines+1):pi)-pi/2;
latlonlist = [lat;lon];

figure('Name','Neuron - All Alphas','units','normalized','outerposition',[1.02 0.12 0.6 0.85]);
for c = 1:9
    % Model = plottingN(N).data.P(c).VintR1;
    Model = masterN(N).data.P(c).VintR1;
    subplot(3,3,c);
    scatter3(Model(:,1),Model(:,2),Model(:,3),'k.');
    xlim([min(Model(:,1))-4 max(Model(:,1))+4]);
    ylim([min(Model(:,2))-4 max(Model(:,2))+4]);
    zlim([min(Model(:,3))-4 max(Model(:,3))+4]);
    axis equal;
    axis off;
    grid off;
    set(gca,'CameraViewAngleMode','Manual','color','none');
    view(latlonlist(2,p)*180/pi,(pi/2-latlonlist(1,p))*180/pi);
end
% figure('Name','Scatter - All Alphas','units','normalized','outerposition',[1.02 0.12 0.6 0.85]);
% plotrangex = [1.25 1.68];
% for c = 1:9
%     subplot(3,3,c);
%     scatter(BDbyM(c,:),BVbyM(c,:),'k.');
%     xlim(plotrangex);
% end
% 
% figure;histogram(VM);figure;histogram(V,'BinLimits',[min(V) max(V)]);