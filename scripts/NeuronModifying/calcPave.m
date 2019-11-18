%only for 2d rotation
function [pave,pdif] = calcPave(plist,L,D,latlonlist,i)
theta = latlonlist(2,i)+pi/2;
phi = latlonlist(1,i);
% pave = (2*D*L)/pi+(D^2)/2;
pave = L*D*sqrt((cos(theta)*sin(phi))^2+cos(phi)^2);
% pave = L*D*sqrt((cos(theta)*sin(phi))^2+cos(phi)^2)+((pi*D/2)^2)*sqrt((cos(theta+pi/2)*sin(phi+pi/2))^2+cos(phi+pi/2)^2);
pdif = (plist(i)-pave)/plist(i);
end