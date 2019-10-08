function [p,plist,latlonlist] = ProfileArea_LatLon(structure,NumLatLines,D)
%Calculates the profile area of a given structure with x, y, z coordinates.
%{
%This function takes in a structure that has columns named x, y, and z
%which correspond to points that define the object of interest and asks
%for a number of viewpoints to look at this object from (recommended to use
%100 or more) as well as a width (D) to expand the structure by. The output
%of this function is an averaged area coverage of the object from all
%viewpoints called the profile (p), the area coverage corresponding to each
%viewpoint (plist), and the list of theta and phi values in spherical
%coordinates that correspond to each viewpoint (latlonlist).
%}
N = structure.ptCloud;
if mod(D,2) == 0
    D = D + 1;
end
if D > 1
    N = makePtsLarger(N,D);
end
M = [N,ones(length(N),1)];

xcen = mean(N(:,1));
ycen = mean(N(:,2));
zcen = mean(N(:,3));

plist = zeros(NumLatLines+2,NumLatLines+2);
latlonlist = zeros(NumLatLines+2,NumLatLines+2,2);
lon = 0:2*pi/(NumLatLines+1):2*pi;
lat = fliplr(0:pi/(NumLatLines+1):pi)-pi/2;

for i = 1:NumLatLines+2
    for j = 1:NumLatLines+2
        latlonlist(i,j,:) = [lat(1,i) lon(1,j)];
        Mview = (makehgtform('zrotate',-latlonlist(i,j,2),'xrotate',-latlonlist(i,j,1),'translate',[-xcen -ycen -zcen])*M')';
        Mprof = unique(round(Mview(:,1:2)),'rows');
        plist(i,j) = length(Mprof);
    end
end

p = mean(mean(plist));
end