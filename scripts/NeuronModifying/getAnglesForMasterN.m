function masterN = getAnglesForMasterN(masterN,method)
    for i=1:length(masterN)
%         if i~=structfind(masterN,'data',[])
            for j=1:length(masterN(i).data.(genvarname(method)))
                   masterN(i).data.(genvarname(method))(j).Angles = getNeuronAngles(masterN(i).data.(genvarname(method))(j).V,masterN(i).data.(genvarname(method))(j).VAll,masterN(i).SLA,masterN(i).PL); 
            end
%         end
    end
end