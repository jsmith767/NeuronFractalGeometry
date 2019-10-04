%the goal of this notebook is to provide a primer for how we might do the
%profile area calculations for H-Trees in matlab.
%this program is meant to be stepped through one line at a time
%Let's start by an example. Consider a line
%% 
N = zeros(100,3); 
for i=1:length(N) %makes a line that lies along the x axis and is 100 pixels long
N(i,1) = i;
end
figure %make a new figure
scatter3(N(:,1),N(:,2),N(:,3));%make the plot
title('original line')
xlim([-100 100])%set plot limits
ylim([-100 100])
zlim([-100 100])
xlabel('X')
ylabel('Y')
zlabel('Z')
%% 
%let's use a basic function I wrote to rotate the line about the z axis
Rz = rotz(pi/2); %set rotation to 90 degrees
Nrotz90 = (Rz*N')';%apply rotation to matrix. " ' " works as a transpose operator to make matlab happy
figure
scatter3(Nrotz90(:,1),Nrotz90(:,2),Nrotz90(:,3));%make the plot
title('rotated 190 degrees about the z axis')
xlim([-100 100])%set plot limits
ylim([-100 100])
zlim([-100 100])
xlabel('X')
ylabel('Y')
zlabel('Z')
%% 
Nrotz180 = (Rz*Nrotz90')';
figure
scatter3(Nrotz180(:,1),Nrotz180(:,2),Nrotz180(:,3));%make the plot
title('rotated 180 degrees about the z axis')
xlim([-100 100])%set plot limits
ylim([-100 100])
zlim([-100 100])
xlabel('X')
ylabel('Y')
zlabel('Z')
%% 
%We can also see what the projections look like.  This is done by smashing
%all the z values together. We can simply do this by excluding the z values
NProfile{1} = N(:,1:2);
NProfile{2}= Nrotz90(:,1:2);
NProfile{3} = Nrotz180(:,1:2);
for i=1:3
    subplot(2,2,i)
    scatter(NProfile{i}(:,1),NProfile{i}(:,2));
    xlim([-100 100])%set plot limits
    ylim([-100 100])
    xlabel('X')
    ylabel('Y')
end
%% 
%We see that we did in fact rotate the file about the z axis
%lets do a 45 degree rotation about the y axis
Ry = roty(pi/4); %set rotation to 90 degrees
Nroty45 = (Ry*N')';
figure
subplot(2,1,1) 
scatter3(Nroty45(:,1),Nroty45(:,2),Nroty45(:,3));
xlim([-100 100])%set plot limits
ylim([-100 100])
zlim([-100 100])
xlabel('X')
ylabel('Y')
zlabel('Z')
subplot(2,1,2) 
scatter(Nroty45(:,1),Nroty45(:,2));%just doing the profile taking inline
xlim([-100 100])%set plot limits
ylim([-100 100])
xlabel('X')
ylabel('Y')
%% 
%lets go about actually extracting data from this!
Nroty45Profile = Nroty45(:,1:2);
%When we roated it we're now in between pixels in a way.  We can round our
%answers and that way pixels that overlap with eachother arent counted
%twice.
Nroty45Prounded = round(Nroty45Profile);
Nunique = unique(Nroty45Prounded,'rows');
Profileroty45 = length(Nunique);




%load in the matlab struct that contains H-trees at different D values and
%properties about them.
load('HtreesStruct.mat');
%Convert the x,y,z coordinates to a matrix
M = [htc(1).x,htc(1).y,htc(1).z];
%% 
phi = (sqrt(5)+1)/2-1;%golden ratio
ga = phi*2*pi;%golden angle
systemSize = 100;
for i =1:systemSize
    lon = ga*(i+1)/(2*pi);
    lon = lon-floor(lon);
    lon = lon*2*pi;
    if (lon > pi)  
        lon = lon-2*pi;
    end
    lat = asin(-1 + 2*(i+1)/systemSize);
    longigtue(i) = lon;
    latitude(i) = lat;
end
%% 

