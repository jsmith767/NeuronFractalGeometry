% load('K:\Keck\Programs\Consolidated\MATs\HeatMapNeur121.mat');
load('K:\Keck\Programs\Consolidated\MATs\HeatMapNeur44.mat');
neurNum = 44;

n = 7;
frametime = 0.05; % 0.015 is Just under 60 frames per second
dotsize = 25;
NumLonLines = 60;
lon = 0:2*pi/(2*NumLonLines-1):2*pi;
lat = 0:2*pi/(2*(NumLonLines-1)):pi;
filename = 'D:\Conor\Research\Figures\Neuron Analysis\FinalFigures\ConnMapGIFs\Neur88ConnMap';

clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr = flipud(clr);
interpdiv = 3;
interpclr = zeros(size(clr,1)+((interpdiv-1)*(size(clr,1)-1)),3);
for i = 1:size(clr,1)-1
    for j = 1:interpdiv
        interpclr((i-1)*interpdiv+j,:) = clr(i,:) + ((clr(i+1,:)-clr(i,:))./interpdiv)*(j-1);
    end
end
interpclr(end,:) = clr(end,:);
NumColorInts = size(interpclr,1);
MaxP = max(plistall{1,n});
MinP = min(plistall{1,n});
ColorInts = MinP:(MaxP-MinP)/NumColorInts:MaxP;
dotclr = zeros(size(X{1,n},1),3);
for p = 1:size(X{1,n},1)
    for k = 1:size(ColorInts,2)-1
        if plistall{1,n}(1,p) >= ColorInts(1,k) && plistall{1,n}(1,p) <= ColorInts(1,k+1)
            dotclr(p,:) = interpclr(k,:);
            break
        end
    end
end

latlonlist = zeros(length(lat),length(lon),2);

gif = figure('visible','off');%,'Position',[0.02 0.12 3*960/2 3*540/2]);
HeatMap = subplot(1,2,1);
scatter3(X{1,n},Y{1,n},Z{1,n},dotsize,dotclr,'filled')
xlim([min(X{1,n})-0.1 max(X{1,n})+0.1]);
ylim([min(Y{1,n})-0.1 max(Y{1,n})+0.1]);
zlim([min(Z{1,n})-0.1 max(Z{1,n})+0.1]);
axis equal;
axis off;
grid off;
hold on;
NeuronModel = subplot(1,2,2);
scatter3(plottingN(88).data.W(5).VintR1(:,1),plottingN(88).data.W(5).VintR1(:,2),plottingN(88).data.W(5).VintR1(:,3),'k.');
xlim([min(plottingN(88).data.W(5).VintR1(:,1))-0.1 max(plottingN(88).data.W(5).VintR1(:,1))+0.1]);
ylim([min(plottingN(88).data.W(5).VintR1(:,2))-0.1 max(plottingN(88).data.W(5).VintR1(:,2))+0.1]);
zlim([min(plottingN(88).data.W(5).VintR1(:,3))-0.1 max(plottingN(88).data.W(5).VintR1(:,3))+0.1]);
axis equal;
axis off;
grid off;
hold on;
for i = 1:5:length(lat)
    for j = 1:length(lon)
        latlonlist(i,j,:) = [lat(1,i) lon(1,j)];
        delete(findall(gif,'type','annotation'));
        annotation(gif,'textbox',[0.1 0.45 0.14 0.105],'String',{['\theta = ' num2str(round(latlonlist(i,j,1),4))], ['\phi = ' num2str(round(mod(latlonlist(i,j,2),2*pi),4))]},'FitBoxToText','off')
        hold off;
        set(HeatMap,'CameraViewAngleMode','Manual');
        view(HeatMap,latlonlist(i,j,2)*180/pi,(pi/2-latlonlist(i,j,1))*180/pi);
        set(NeuronModel,'CameraViewAngleMode','Manual');
        view(NeuronModel,latlonlist(i,j,2)*180/pi,(pi/2-latlonlist(i,j,1))*180/pi);
        
        frame = getframe(gif);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im,256);
        if j == 1 && i == 1
            imwrite(imind,cm,[filename '.gif'],'gif','Loopcount',Inf,'DelayTime',frametime);
        else
            imwrite(imind,cm,[filename '.gif'],'gif','WriteMode','append','DelayTime',frametime);
        end
    end
end

clearvars -except plottingN plottingH masterN masterH latlonlistall pall plistall X Y Z