function newV = setNewVAll(V, newSeg, SLA, segN) 
    if segN == 1
        V(1:16*SLA(segN,2),:) = newSeg;
    else 
        V(16*SLA(segN-1,2)+1:16*SLA(segN,2),:) = newSeg;
    end
    newV = V;
end