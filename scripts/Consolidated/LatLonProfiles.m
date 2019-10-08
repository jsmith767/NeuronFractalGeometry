% % Import original straightening method master
% load('\\cas-fs1.uoregon.edu\Material-Science-Institute\Aleman-Lab\Keck\Programs\masterN\masterNDOM19-24-2018.mat');
% masterNB = masterNOM1;
% clear('masterNOM1')

% NumNeurs = size(masterNB,2);
% NumCurvs = size(masterNB(1).data.original,2);

% LatLonProfs = cell(NumCurvs,NumNeurs);
NumLatLines = 131;
LatLonAngles = zeros(NumLatLines+2,NumLatLines+2);
lat = -pi/2:pi/(NumLatLines+1):pi/2;
lon = 0:2*pi/(NumLatLines+1):2*pi;
LatLonAveInd = cell(NumLatLines+2,NumLatLines+2);

% [p,plist,latlonlist] = ProfileArea_LatLon(masterNB(41).data.original(5),NumLatLines,1);

theta_min = 0;
theta_max = 2*pi;
phi_min = -pi/2;
phi_max = pi/2;
% Rho = zeros(NumCurvs,NumNeurs);
% Rho = (max(max(plist))+min(min(plist)))/2;
Rho = min(min(plist));
meshscale = 1;
plotspec = 'surf';
interpspec = 'linear';
Zscale = 0.001;

S = sphere3d(plist,theta_min,theta_max,phi_min,phi_max,Rho,meshscale,plotspec,interpspec,Zscale);
colormap jet

% for n = 1:NumNeurs
%     if isempty(masterNB(n).data)
%         continue
%     end
%     for c = 1:NumCurvs
%         LatLonProfs{c,n} = 
%         Rho(c,n) = []
%     end
% end

