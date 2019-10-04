function s = getConvHullSA(s,method)
    for i=1:length(s)
        for j=1:9
            F = convhull(vertcat(s(i).data.(genvarname(method))(j).VAll{:}));
            s(i).data.(genvarname(method))(j).convHullSAVAll = getTriangleAreas(vertcat(s(i).data.(genvarname(method))(j).VAll{:}),F);
        end
    end
end