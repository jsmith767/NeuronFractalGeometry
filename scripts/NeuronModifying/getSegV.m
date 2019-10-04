% gets the vertices of the segment of interest

function segV = getSegV(V,SLA,segN)
    if segN ==1
        segV = V(1:SLA(segN,2),:);
    else 
        segV = V(SLA(segN-1,2)+1:SLA(segN,2),:);
    end
end