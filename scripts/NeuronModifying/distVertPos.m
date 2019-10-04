%takes a vector and tells you which vertices have the same value and put's
%them into a nice array for analyzing.
%Example "VRM = distVertPos(V);"
function distVP = distVertPos(V)
    distances = squareform(pdist(V));
    distVP = zeros(6,length(distances));
    for i=1:length(distances)
%         distVPTemp = find(0==distances(:,i));
          distVPTemp = find(distances(:,i) < 0.005); %0.005
        for j=1:length(distVPTemp)
            distVP(j,i) = distVPTemp(j);
        end
    end
end