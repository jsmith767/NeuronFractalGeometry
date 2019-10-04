function newV = setNewV(V, newSeg, SLA, segN) 
    if segN == 1
        V(1:SLA(segN,2),:) = newSeg;
    else 
        V(SLA(segN-1,2)+1:SLA(segN,2),:) = newSeg;
    end
    newV = V;
end
        