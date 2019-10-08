% load('MATs\plottingN_4-17-19.mat')
load('MATS\HeatMapNeur88.mat');
% load('MATS\HeatMapNeur121.mat');


SpineClr = [0.13 0.51 0.93];
labelFont = 26;
NColdI = 'a';
NColdiloc = [0.2 0.835 0.1 0.1];
NHotI = 'b';
NHotiloc = [0.5 0.835 0.1 0.1];
MColdI = 'c';
MColdiloc = [0.2 0.51 0.1 0.1];
MHotI = 'd';
MHotiloc = [0.5 0.51 0.1 0.1];

neurNum = 88;
n = 7;
% latiC = 34; % For Neur71 use 34(Cold) and 52(Hot) for NumLonLines = 60
% loniC = 69; % For Neur71 use 69(Cold) and 85(Hot) for NumLonLines = 60
% latiH = 52;
% loniH = 85;
latiC = 32; % For Neur88 (in plottingN_SH) use 34(Cold) and 52(Hot) for NumLonLines = 60
loniC = 39; % For Neur88 (in plottingN_SH) use 69(Cold) and 85(Hot) for NumLonLines = 60
latiH = 52;
loniH = 78;
FSiC = 4897;
FSiH = 349;
dotsize = 23; % For old Fib Spiral 25->10000; 35->7500; 60->5000; 70->4000; 115->2500; 300->1000; 640->500
ngall = [500 1000 2500 4000 5000 7500 10000];
% pall = cell(1,length(ngall));
% plistall = cell(1,length(ngall));
% aball = cell(1,length(ngall));
% ablistall = cell(1,length(ngall));
% latlonlistall = cell(1,length(ngall));
% X = cell(1,length(ngall));
% Y = cell(1,length(ngall));
% Z = cell(1,length(ngall));
% for n = 1:length(ngall)
%     ng = ngall(1,n);
%     gra = ( 1.0 + sqrt ( 5.0 ) ) / 2.0;
%     i = ( - ( ng - 1 ) : 2 : ( ng - 1 ) )';
%     phi = 2 * pi * i / gra;
%     theta = atan(i ./ sqrt ( ( ng + i ) .* ( ng - i ) ));
%     [X{1,n}, Y{1,n}, Z{1,n}] = sph2cart(phi,theta,1);
%     [pall{1,n},plistall{1,n},aball{1,n},ablistall{1,n},latlonlistall{1,n}] = ProfileArea_New(plottingN(neurNum).data.W(5).VintR1,ng,5);
% end
% save(['MATs\HeatMapNeur' num2str(neurNum) '_New.mat'],'pall','plistall','aball','ablistall','latlonlistall','X','Y','Z')

% NumLonLines = 60;
% lon = 0:2*pi/(2*NumLonLines-1):2*pi;
% lat = 0:2*pi/(2*(NumLonLines-1)):pi;
% latlonlist = zeros(length(lat),length(lon),2);
% for i = 1:length(lat)
%     for j = 1:length(lon)
%         latlonlist(i,j,:) = [lat(1,i) lon(1,j)];
%     end
% end
ng = 10000;
gra = ( 1.0 + sqrt ( 5.0 ) ) / 2.0;
i = ( - ( ng - 1 ) : 2 : ( ng - 1 ) )';
phi = 2 * pi * i / gra;
theta = atan(i ./ sqrt ( ( ng + i ) .* ( ng - i ) ));
latlonlist = zeros(2,ng);
latlonlist(:,:) = [(pi/2)+theta';phi'];
p = pall{1,n};
plist = plistall{1,n};
% latlonlist = latlonlistall{1,n};
% x = X{1,n};
% y = Y{1,n};
% z = Z{1,n};
x = (sin(latlonlist(1,:)).*cos(latlonlist(2,:)))';
y = (sin(latlonlist(1,:)).*sin(latlonlist(2,:)))';
z = (cos(latlonlist(1,:)))';
MaxP = max(plist);
MinP = min(plist);
% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
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
ColorInts = MinP:(MaxP-MinP)/NumColorInts:MaxP;
PointsInInt = cell(1,NumColorInts);
for i = 1:NumColorInts
    PointsInInt{1,i} = plist >= ColorInts(1,i) & plist <= ColorInts(1,i+1);
end

Model = plottingN(neurNum).data.W(5).VintR1;
EModel = makePtsLarger(Model,5);
M = [Model,ones(size(Model,1),1)];
neurLims = [[min(EModel(:,1)) max(EModel(:,1))];[min(EModel(:,2)) max(EModel(:,2))];[min(EModel(:,3)) max(EModel(:,3))]];
neurCenter = [mean(EModel(:,1)); mean(EModel(:,2)); mean(EModel(:,3))];
neurScale = max(neurLims(:,2)-neurLims(:,1))/1.5;


figure
hold on;
for i = 1:NumColorInts
    scatter3(x(PointsInInt{1,i},1),y(PointsInInt{1,i},1),z(PointsInInt{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:),'MarkerFaceAlpha',0.3,'MarkerEdgeAlpha',0.3);
end
scatter3(x(FSiH,1),y(FSiH,1),z(FSiH,1),dotsize,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0],'MarkerFaceAlpha',1,'MarkerEdgeAlpha',1);
scatter3(x(FSiC,1),y(FSiC,1),z(FSiC,1),dotsize,'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',[0 1 0],'MarkerFaceAlpha',1,'MarkerEdgeAlpha',1);
scatter3((plottingN(neurNum).data.W(5).VintR1(:,1)-neurCenter(1,:))./neurScale,(plottingN(neurNum).data.W(5).VintR1(:,2)-neurCenter(2,:))./neurScale,(plottingN(neurNum).data.W(5).VintR1(:,3)-neurCenter(3,:))./neurScale,'k.');
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');


figure('Name','ConnHeatMap','units','normalized','outerposition',[1.02 0.12 0.5 0.7]);

NColdi = annotation('textbox',NColdiloc,'String',NColdI,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
NHoti = annotation('textbox',NHotiloc,'String',NHotI,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
MColdi = annotation('textbox',MColdiloc,'String',MColdI,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
MHoti = annotation('textbox',MHotiloc,'String',MHotI,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');

NCold = axes('Position',[0.1 0.52 0.5 0.5],'Box','on','Color','none');
CMview = (makehgtform('translate',[-neurCenter(1,1) -neurCenter(2,1) -neurCenter(3,1)])*M')';
for p = 1:size(CMview,1)
    CMview(p,1:3) = round(rotationmat3D(-latlonlist(1,FSiC),[cos(pi/2+latlonlist(2,FSiC)) sin(pi/2+latlonlist(2,FSiC)) 0])*CMview(p,1:3)');
end
CMEview = makePtsLarger(CMview,5);
scatter(CMEview(:,1),CMEview(:,2),'.','MarkerFaceColor',SpineClr); hold on;
scatter(CMview(:,1),CMview(:,2),'k.'); hold off;
xlim(neurLims(1,:)-neurCenter(1,1))
ylim(neurLims(2,:)-neurCenter(2,1))
axis equal;
axis off;
grid off;

NHot = axes('Position',[0.42 0.52 0.5 0.5],'Box','on','Color','none');
HMview = (makehgtform('translate',[-neurCenter(1,1) -neurCenter(2,1) -neurCenter(3,1)])*M')';
for p = 1:size(HMview,1)
    HMview(p,1:3) = round(rotationmat3D(-latlonlist(1,FSiH),[cos(pi/2+latlonlist(2,FSiH)) sin(pi/2+latlonlist(2,FSiH)) 0])*HMview(p,1:3)');
end
HMEview = makePtsLarger(HMview,5);
scatter(HMEview(:,1),HMEview(:,2),'.','MarkerFaceColor',SpineClr); hold on;
scatter(HMview(:,1),HMview(:,2),'k.'); hold off;
xlim(neurLims(1,:)-neurCenter(1,1))
ylim(neurLims(2,:)-neurCenter(2,1))
axis equal;
axis off;
grid off;

MCold = axes('Position',[0.12 0.15 0.45 0.40],'Box','on','Color','none');
Cxview = zeros(size(x,1),1);
Cyview = zeros(size(y,1),1);
Czview = zeros(size(z,1),1);
for p = 1:size(x,1)
    tempp = rotationmat3D(-latlonlist(1,FSiC),[cos(pi/2+latlonlist(2,FSiC)) sin(pi/2+latlonlist(2,FSiC)) 0])*[x(p,1);y(p,1);z(p,1)];
    Cxview(p,1) = tempp(1,1);
    Cyview(p,1) = tempp(2,1);
    Czview(p,1) = tempp(3,1);
end
hold on;
for i = 1:NumColorInts
    scatter3(Cxview(PointsInInt{1,i},1),Cyview(PointsInInt{1,i},1),Czview(PointsInInt{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:));
end
scatter3(Cxview(FSiC,1),Cyview(FSiC,1),Czview(FSiC,1),dotsize,'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',[0 1 0]);
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');
view([0,0,1])% This is for fibonacci spiral

MHot = axes('Position',[0.45 0.15 0.45 0.40],'Box','on','Color','none');
Hxview = zeros(size(x,1),1);
Hyview = zeros(size(y,1),1);
Hzview = zeros(size(z,1),1);
for p = 1:size(x,1)
    tempp = rotationmat3D(-latlonlist(1,FSiH),[cos(pi/2+latlonlist(2,FSiH)) sin(pi/2+latlonlist(2,FSiH)) 0])*[x(p,1);y(p,1);z(p,1)];
    Hxview(p,1) = tempp(1,1);
    Hyview(p,1) = tempp(2,1);
    Hzview(p,1) = tempp(3,1);
end
hold on;
for i = 1:NumColorInts
    scatter3(Hxview(PointsInInt{1,i},1),Hyview(PointsInInt{1,i},1),Hzview(PointsInInt{1,i},1),dotsize,'MarkerEdgeColor',interpclr(i,:),'MarkerFaceColor',interpclr(i,:));
end
scatter3(Hxview(FSiH,1),Hyview(FSiH,1),Hzview(FSiH,1),dotsize,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0]);
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');
view([0,0,1])% This is for fibonacci spiral


clearvars -except latlonlistall plistall pall plottingN X Y Z plottingH