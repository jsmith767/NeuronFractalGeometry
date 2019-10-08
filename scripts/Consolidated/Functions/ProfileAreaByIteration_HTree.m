function [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New_HTree(HTree,viewpoints,D)
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

itcount = HTree(end,4);
% D = 1; % Force D equal to 1 because the program fails otherwise.
if mod(D,2) == 0
    D = D + 1;
end
if D == 1
    N = HTree(:,1:3);
elseif D > 1
    N = makePtsLarger(HTree(:,1:3),D);
end
M = [N,ones(size(N,1),1)];
% voxcount = length(N);
% for i = 1:itcount
% %     voxcount = voxcount + size(structure(i).voxUnique,1);
%     voxcount = voxcount + size(structure(i).voxUAll,1);
% end
iterations = HTree(:,4);
% for i = 1:itcount
%     for j = 1:size(structure(i).voxUAll,1)
%         voxcount = voxcount + 1;
%         iterations(voxcount,1) = i;
%     end
% end

xcen = (max(N(:,1)) + min(N(:,1)))/2;
ycen = (max(N(:,2)) + min(N(:,2)))/2;
zcen = (max(N(:,3)) + min(N(:,3)))/2;

plist = zeros(1,viewpoints);
pilist = zeros(itcount,viewpoints);
latlonlist = zeros(2,viewpoints);

gra = (1.0+sqrt(5.0))/2.0;
i = (-(viewpoints - 1):2:(viewpoints - 1))';
phi = 2*pi*i/gra;
theta = atan(i./sqrt((viewpoints+i).*(viewpoints-i)));
latlonlist(:,:) = [(pi/2)+theta';phi'];

for i = 1:viewpoints
%     Mview = (makehgtform('zrotate',-latlonlist(2,i),'xrotate',-latlonlist(1,i),'translate',[-xcen -ycen -zcen])*M')';
    Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
    for p = 1:size(Mview,1)
        Mview(p,1:3) = rotationmat3D(-latlonlist(1,i),[cos(pi/2+latlonlist(2,i)) sin(pi/2+latlonlist(2,i)) 0])*Mview(p,1:3)';
    end
    RM = round(Mview./2).*2;
    RM = horzcat(RM,iterations);
    RM = sortrows(RM,3,'Ascend');
%     RM = sortrows(Mview,3,'Ascend');
    [~,ia,~] = unique(RM(:,1:2),'rows');
    Mprof = RM(ia,:);
    plist(1,i) = length(Mprof);
    pcount = zeros(itcount,1);
    pcountM = accumarray(Mprof(:,5),1);
    for k = 1:size(pcountM,1)
        pcount(k,1) = pcountM(k,1);
    end
    for k = 1:itcount
        pilist(k,i) = pcount(k,1);
    end
end
p = mean(plist);
pit = zeros(itcount,1);
for k = 1:itcount
    pit(k,1) = mean(pilist(k,:));
end
end