%{
viewpoints = 200;

latlonlist = zeros(2,viewpoints);

phi = (sqrt(5)+1)/2-1;%golden ratio
ga = phi*2*pi;%golden angle
for i = 1:viewpoints
    lon = ga*(i)/(2*pi);
    lon = lon-floor(lon);
    lon = lon*2*pi;
    if (lon > pi)  
        lon = lon-2*pi;
    end
    lat = real(asin(-1 + 2*(i)/(viewpoints)));
    latlonlist(:,i) = [lat+(pi/2),lon];
    disp(strcat('Phi=',num2str(lat/pi),',Theta=',num2str(lon/pi)));
end

[x y z] = sph2cart(latlonlist(2,:),(-latlonlist(1,:) + 90),1);
%}
N = 500;
ng = 2*N + 1;
gra = ( 1.0 + sqrt ( 5.0 ) ) / 2.0;
% i = ( - ( ng - 1 ) : 2 : ( ng - 1 ) )';
% phi = 2 * pi * i / gra;
% theta = atan(i ./ sqrt ( ( ng + i ) .* ( ng - i ) ));
i = -N:1:N;
% phi = 2*pi*i/gra;
phi = -2*pi*i/(gra)^2; % This creates the same point cloud as phi above
theta = asin(2*i/ng);

[x, y, z] = sph2cart(phi,theta,1);

figure
scatter3(x,y,z,'r.');%,'filled');
axis equal;
axis off;
grid off;
set(gca,'CameraViewAngleMode','Manual');