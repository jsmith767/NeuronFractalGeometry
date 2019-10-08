N025 = load('MATS\HeatMapNeur28_025.mat');
N100 = load('MATS\HeatMapNeur28.mat');
N175 = load('MATS\HeatMapNeur28_175.mat');

neurNum = 28;
SpineClr = [253 122 0]/255;
Model025 = plottingN(neurNum).data.W(2).VintR1;
Model100 = plottingN(neurNum).data.W(5).VintR1;
Model175 = plottingN(neurNum).data.W(8).VintR1;

n = 28;
FSiC = 5647; % Neur28_025MinI = 10000; Neur28_100MinI = 5647; Neur28_175MinI = 10001
FSiH = 1057; % Neur28_025MaxI = 3863; Neur28_100MaxI = 1057; Neur28_175MaxI = 3662
Viewi = 325; % For NumLonLines = 15 -> 11 42 60 90 110 159 271 325 392
dotsize = 20; % For new Fib Spiral 20->10001; 35->; 60->; 70->; 115->; 300->; 640->
ngall = [11 21 31 41 51 61 71 81 91 101 201 301 401 501 601 701 801 901 1001 2001 3001 4001 5001 6001 7001 8001 9001 10001];

% MaxP025 = max(N025.plistall{1,n});
% MinP025 = min(N025.plistall{1,n});
% MaxP100 = max(N100.plistall{1,n});
% MinP100 = min(N100.plistall{1,n});
% MaxP175 = max(N175.plistall{1,n});
% MinP175 = min(N175.plistall{1,n});
MaxP025 = max(N025.plistall{1,n}/plottingN(neurNum).data.W(2).SA);
MinP025 = min(N025.plistall{1,n}/plottingN(neurNum).data.W(2).SA);
MaxP100 = max(N100.plistall{1,n}/plottingN(neurNum).data.W(5).SA);
MinP100 = min(N100.plistall{1,n}/plottingN(neurNum).data.W(5).SA);
MaxP175 = max(N175.plistall{1,n}/plottingN(neurNum).data.W(8).SA);
MinP175 = min(N175.plistall{1,n}/plottingN(neurNum).data.W(8).SA);
MaxP = max([MaxP025 MaxP100 MaxP175]);
MinP = min([MinP025 MinP100 MinP175]);

ng = ngall(1,n);
gra = ( 1.0 + sqrt ( 5.0 ) ) / 2.0;
i = (-(ng-1)/2:1:(ng-1)/2)';
phi = -2*pi*i/(gra)^2;
theta = asin(2*i/ng);
latlonlist = zeros(2,ng);
latlonlist(:,:) = [(pi/2)+theta';phi'];
x = (sin(latlonlist(1,:)).*cos(latlonlist(2,:)))';
y = (sin(latlonlist(1,:)).*sin(latlonlist(2,:)))';
z = (cos(latlonlist(1,:)))';

% NumLonLines = 15;
% lon = 0:2*pi/(2*NumLonLines-1):2*pi-2*pi/(2*NumLonLines-1);
% lat = 0:2*pi/(2*(NumLonLines-1)):pi;
% latlonlist = zeros(2,length(lat)*length(lon));
% for i = 1:length(lat)
%     for j = 1:length(lon)
%         latlonlist(:,((i-1)*length(lon))+j) = [lat(1,i);lon(1,j)];
%     end
% end
% x = (sin(latlonlist(1,:)).*cos(latlonlist(2,:)))';
% y = (sin(latlonlist(1,:)).*sin(latlonlist(2,:)))';
% z = (cos(latlonlist(1,:)))';
% x = x(length(lon):length(lon)*(length(lat)-1)+1,1);
% y = y(length(lon):length(lon)*(length(lat)-1)+1,1);
% z = z(length(lon):length(lon)*(length(lat)-1)+1,1);

% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr = [[103 19 21];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr = flipud(clr);
interpdiv = 5;
interpclr = zeros(size(clr,1)+((interpdiv-1)*(size(clr,1)-1)),3);
for i = 1:size(clr,1)-1
    for j = 1:interpdiv
        interpclr((i-1)*interpdiv+j,:) = clr(i,:) + ((clr(i+1,:)-clr(i,:))./interpdiv)*(j-1);
    end
end
interpclr(end,:) = clr(end,:);
NumColorInts = size(interpclr,1);
ColorInts = MinP:(MaxP-MinP)/NumColorInts:MaxP;
ColorInts025 = MinP025:(MaxP025-MinP025)/NumColorInts:MaxP025;
ColorInts100 = MinP100:(MaxP100-MinP100)/NumColorInts:MaxP100;
ColorInts175 = MinP175:(MaxP175-MinP175)/NumColorInts:MaxP175;

PointsInInt025 = cell(1,NumColorInts);
for i = 1:NumColorInts
%     PointsInInt025{1,i} = N025.plistall{1,n} >= ColorInts(1,i) & N025.plistall{1,n} <= ColorInts(1,i+1);
    PointsInInt025{1,i} = N025.plistall{1,n}/plottingN(neurNum).data.W(2).SA >= ColorInts(1,i) & N025.plistall{1,n}/plottingN(neurNum).data.W(2).SA <= ColorInts(1,i+1);

%     PointsInInt025{1,i} = N025.plistall{1,n} >= ColorInts025(1,i) & N025.plistall{1,n} <= ColorInts025(1,i+1);
end
PointsInInt100 = cell(1,NumColorInts);
for i = 1:NumColorInts
%     PointsInInt100{1,i} = N100.plistall{1,n} >= ColorInts(1,i) & N100.plistall{1,n} <= ColorInts(1,i+1);
    PointsInInt100{1,i} = N100.plistall{1,n}/plottingN(neurNum).data.W(5).SA >= ColorInts(1,i) & N100.plistall{1,n}/plottingN(neurNum).data.W(5).SA <= ColorInts(1,i+1);

%     PointsInInt100{1,i} = N100.plistall{1,n} >= ColorInts100(1,i) & N100.plistall{1,n} <= ColorInts100(1,i+1);
end
PointsInInt175 = cell(1,NumColorInts);
for i = 1:NumColorInts
%     PointsInInt175{1,i} = N175.plistall{1,n} >= ColorInts(1,i) & N175.plistall{1,n} <= ColorInts(1,i+1);
    PointsInInt175{1,i} = N175.plistall{1,n}/plottingN(neurNum).data.W(8).SA >= ColorInts(1,i) & N175.plistall{1,n}/plottingN(neurNum).data.W(8).SA <= ColorInts(1,i+1);

%     PointsInInt175{1,i} = N175.plistall{1,n} >= ColorInts175(1,i) & N175.plistall{1,n} <= ColorInts175(1,i+1);
end

% EModel025 = makePtsLarger(Model025,5);
M025 = [Model025,ones(size(Model025,1),1)];
neurLims025 = [[min(Model025(:,1)) max(Model025(:,1))];[min(Model025(:,2)) max(Model025(:,2))];[min(Model025(:,3)) max(Model025(:,3))]];
neurCenter025 = [mean(Model025(:,1)); mean(Model025(:,2)); mean(Model025(:,3))];
% EModel100 = makePtsLarger(Model100,5);
M100 = [Model100,ones(size(Model100,1),1)];
neurLims100 = [[min(Model100(:,1)) max(Model100(:,1))];[min(Model100(:,2)) max(Model100(:,2))];[min(Model100(:,3)) max(Model100(:,3))]];
neurCenter100 = [mean(Model100(:,1)); mean(Model100(:,2)); mean(Model100(:,3))];
% EModel175 = makePtsLarger(Model175,5);
M175 = [Model175,ones(size(Model175,1),1)];
neurLims175 = [[min(Model175(:,1)) max(Model175(:,1))];[min(Model175(:,2)) max(Model175(:,2))];[min(Model175(:,3)) max(Model175(:,3))]];
neurCenter175 = [mean(Model175(:,1)); mean(Model175(:,2)); mean(Model175(:,3))];
neurLims = [[min([neurLims025(1,1) neurLims100(1,1) neurLims175(1,1)]) max([neurLims025(1,2) neurLims100(1,2) neurLims175(1,2)])];[min([neurLims025(2,1) neurLims100(2,1) neurLims175(2,1)]) max([neurLims025(2,2) neurLims100(2,2) neurLims175(2,2)])];[min([neurLims025(3,1) neurLims100(3,1) neurLims175(3,1)]) max([neurLims025(3,2) neurLims100(3,2) neurLims175(3,2)])]];
neurLims = neurLims + [[-10 10];[-10 10];[-10 10]];

figure('Name','ConnHeatMap','units','normalized','outerposition',[1.02 0.12 0.5 0.7]);

NM025 = axes('Position',[0.03 0.57 0.3 0.4],'Box','on','Color','none');
NM025view = (makehgtform('translate',[-neurCenter025(1,1) -neurCenter025(2,1) -neurCenter025(3,1)])*M025')';
for p = 1:size(NM025view,1)
    NM025view(p,1:3) = round(rotationmat3D(-latlonlist(1,Viewi),[cos(pi/2+latlonlist(2,Viewi)) sin(pi/2+latlonlist(2,Viewi)) 0])*NM025view(p,1:3)');
end
NME025view = makePtsLarger(NM025view,5);
scatter(NME025view(:,1),NME025view(:,2),'.','MarkerEdgeColor',SpineClr); hold on;
scatter(NM025view(:,1),NM025view(:,2),'k.'); hold off;
xlim(neurLims(1,:)-neurCenter025(1,1) + [-10 10])
ylim(neurLims(2,:)-neurCenter025(2,1) + [-10 10])
axis equal;
axis off;
grid off;

NM100 = axes('Position',[0.37 0.57 0.3 0.4],'Box','on','Color','none');
NM100view = (makehgtform('translate',[-neurCenter100(1,1) -neurCenter100(2,1) -neurCenter100(3,1)])*M100')';
for p = 1:size(NM100view,1)
    NM100view(p,1:3) = round(rotationmat3D(-latlonlist(1,Viewi),[cos(pi/2+latlonlist(2,Viewi)) sin(pi/2+latlonlist(2,Viewi)) 0])*NM100view(p,1:3)');
end
NME100view = makePtsLarger(NM100view,5);
scatter(NME100view(:,1),NME100view(:,2),'.','MarkerEdgeColor',SpineClr); hold on;
scatter(NM100view(:,1),NM100view(:,2),'k.'); hold off;
xlim(neurLims(1,:)-neurCenter100(1,1) + [-10 10])
ylim(neurLims(2,:)-neurCenter100(2,1) + [-10 10])
axis equal;
axis off;
grid off;

NM175 = axes('Position',[0.62 0.57 0.3 0.4],'Box','on','Color','none');
NM175view = (makehgtform('translate',[-neurCenter175(1,1) -neurCenter175(2,1) -neurCenter175(3,1)])*M175')';
for p = 1:size(NM175view,1)
    NM175view(p,1:3) = round(rotationmat3D(-latlonlist(1,Viewi),[cos(pi/2+latlonlist(2,Viewi)) sin(pi/2+latlonlist(2,Viewi)) 0])*NM175view(p,1:3)');
end
NME175view = makePtsLarger(NM175view,5);
scatter(NME175view(:,1),NME175view(:,2),'.','MarkerEdgeColor',SpineClr); hold on;
scatter(NM175view(:,1),NM175view(:,2),'k.'); hold off;
xlim(neurLims(1,:)-neurCenter175(1,1) + [-10 10])
ylim(neurLims(2,:)-neurCenter175(2,1) + [-10 10])
axis equal;
axis off;
grid off;

HM025 = axes('Position',[0.05 0.2 0.3 0.4],'Box','on','Color','none');
HMxview = zeros(size(x,1),1);
HMyview = zeros(size(y,1),1);
HMzview = zeros(size(z,1),1);
for p = 1:size(x,1)
    tempp = rotationmat3D(-latlonlist(1,Viewi),[cos(pi/2+latlonlist(2,Viewi)) sin(pi/2+latlonlist(2,Viewi)) 0])*[x(p,1);y(p,1);z(p,1)];
    HMxview(p,1) = tempp(1,1);
    HMyview(p,1) = tempp(2,1);
    HMzview(p,1) = tempp(3,1);
end
hold on;
for i = 1:NumColorInts
    scatter3(HMxview(PointsInInt025{1,i},1),HMyview(PointsInInt025{1,i},1),HMzview(PointsInInt025{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:));
end
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');
view([0,0,1])% This is for fibonacci spiral

HM100 = axes('Position',[0.35 0.2 0.3 0.4],'Box','on','Color','none');
hold on;
for i = 1:NumColorInts
    scatter3(HMxview(PointsInInt100{1,i},1),HMyview(PointsInInt100{1,i},1),HMzview(PointsInInt100{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:));
end
scatter3(HMxview(FSiH,1),HMyview(FSiH,1),HMzview(FSiH,1),dotsize+10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');
view([0,0,1])% This is for fibonacci spiral

HM175 = axes('Position',[0.65 0.2 0.3 0.4],'Box','on','Color','none');
hold on;
for i = 1:NumColorInts
    scatter3(HMxview(PointsInInt175{1,i},1),HMyview(PointsInInt175{1,i},1),HMzview(PointsInInt175{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:));
end
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');
view([0,0,1])% This is for fibonacci spiral

AddColorBar = axes('Position',[0.2 0.13 0.6 0.03],'Box','on','Color','none');
AddColoBarMax = annotation('textbox',[0.06 0.13 0.15 0.05],'String','High $\frac{P}{A_S}$','Interpreter','latex','LineStyle','none','Color',[0 0 0]/255,'FontSize',26);
AddColoBarMin = annotation('textbox',[0.8 0.13 0.15 0.05],'String','Low $\frac{P}{A_S}$','Interpreter','latex','LineStyle','none','Color',[0 0 0]/255,'FontSize',26);
interpdiv = 25;
interpclr = zeros(size(clr,1)+((interpdiv-1)*(size(clr,1)-1)),3);
for i = 1:size(clr,1)-1
    for j = 1:interpdiv
        interpclr((i-1)*interpdiv+j,:) = clr(i,:) + ((clr(i+1,:)-clr(i,:))./interpdiv)*(j-1);
    end
end
interpclr(end,:) = clr(end,:);
PlotColorBar(MinP,MaxP,interpclr,0,1);

clearvars -except latlonlistall plistall pall ablistall aball plottingN X Y Z plottingH masterH N025 N100 N175