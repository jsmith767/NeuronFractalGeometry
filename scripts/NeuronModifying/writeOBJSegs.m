% Example: "writeOBJSegs(V,SLA,'a28_0001');"
function y = writeOBJSegs(V,SLA,fileName)
        segStart = 1;
    for i=1:length(SLA);
        writeOBJ(V(segStart:SLA(i,2),:),i,fileName);
        segStart = SLA(i,2)+1;
    end
end