% gets the vertices of the segment of interest

function segV = getRingSegV(V,SLA,segN)
    if segN ==1
        segV = V(1:16*SLA(segN,2),:);
    else 
        segV = V(16*SLA(segN-1,2)+1:16*SLA(segN,2),:);
    end
end