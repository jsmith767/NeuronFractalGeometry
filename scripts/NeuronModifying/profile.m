%This function takes in a structure that has columns named x, y, and z
%which correspond to points that define the object of interest and asks
%for a number of viewpoints to look at this object from (recommended to use
%100 or more). The output of this function is an averaged area coverage of
%the object from all viewpoints called the profile (p), the area coverage
%corresponding to each viewpoint (plist), and the list of theta and phi
%values in spherical coordinates that correspond to each viewpoint
%(latlonlist).

function [p,plist,latlonlist] = profile(structure,viewpoints)
if isstruct(structure)
    M = [structure.x,structure.y,structure.z,ones(length(structure.x),1)];
else
    M=[structure(:,1),structure(:,2),structure(:,3),ones(size(structure,1),1)];
end
plist = zeros(viewpoints,1);
latlonlist = zeros(viewpoints,2);

phi = (sqrt(5)+1)/2-1;%golden ratio
ga = phi*2*pi;%golden angle
for i = 1:viewpoints
    lon = ga*(i+1)/(2*pi);
    lon = lon-floor(lon);
    lon = lon*2*pi;
    if (lon > pi)  
        lon = lon-2*pi;
    end
    lat = real(asin(-1 + 2*(i+1)/(viewpoints)));
    latlonlist(i,:) = [lat+(pi/2),lon];
    
    Mview = (makehgtform('zrotate',-latlonlist(i,2),'xrotate',-latlonlist(i,1),'translate',[-600 -500 0])*M')';
    Mprof = unique(round(Mview(:,1:2)),'rows');
    plist(i) = size(Mprof,1);
end

p = mean(plist);
end