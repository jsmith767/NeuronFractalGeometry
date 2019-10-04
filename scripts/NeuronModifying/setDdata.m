%sets the D data to masterN for a particular curvature of the box count
%struct (BCstruct)

function masterN = setDdata(masterN,BCstruct,method)
    for i = 1:length(BCstruct)
        masterInd = structfind(masterN,'name',BCstruct(i).name);
        masterCurveInd = structfind(masterN(masterInd).data.(genvarname(method)),'Curvature',BCstruct(i).Curvature);
        masterN(masterInd).data.(genvarname(method))(masterCurveInd).Ddata = BCstruct(i);
    end
end