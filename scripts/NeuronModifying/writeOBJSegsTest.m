% Example: "writeOBJSegs(V,SLA,'a28_0001');"
function y = writeOBJSegsTest(V,F,G,SLA,fileName)
        segStart = 1;
    for i=1:length(SLA{1});
        v{1} = V{1}(segStart:SLA{1}(i,2),:);
        writeOBJFulltest(v,F,G,i,fileName);
        segStart = SLA{1}(i,2)+1;
    end
end