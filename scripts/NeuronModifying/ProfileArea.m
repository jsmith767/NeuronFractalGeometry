function [p,plist,latlonlist] = ProfileArea(structure,viewpoints,D)

N = structure;
if mod(D,2) == 0
    D = D + 1;
end
if D > 1
    N = makePtsLarger(N,D);
end
M = [N,ones(size(N,1),1)];

xcen = mean(N(:,1));
ycen = mean(N(:,2));
zcen = mean(N(:,3));

plist = zeros(1,viewpoints);
latlonlist = zeros(2,viewpoints);

gra = (1.0+sqrt(5.0))/2.0;
i = -(viewpoints-1)/2:1:(viewpoints-1)/2;
phi = -2*pi*i/(gra)^2;
theta = asin(2*i/viewpoints);
latlonlist(:,:) = [(pi/2)+theta;phi];

for i = 1:viewpoints
    Mview = (makehgtform('translate',[-xcen -ycen -zcen])*M')';
    for p = 1:size(Mview,1)
        Mview(p,1:3) = rotationmat3D(-latlonlist(1,i),[cos(pi/2+latlonlist(2,i)) sin(pi/2+latlonlist(2,i)) 0])*Mview(p,1:3)';
    end
    RM = round(Mview);
    RM = sortrows(RM,3,'Ascend');
    [~,ia,~] = unique(RM(:,1:2),'rows');
    Mprof = RM(ia,:);
    plist(1,i) = length(Mprof);
end
p = mean(plist);
end