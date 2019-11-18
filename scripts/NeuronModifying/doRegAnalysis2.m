function masterN = doRegAnalysis2(masterN,BCstruct,FSCO,LSCO,minPts,method)
    for i = 1:length(BCstruct)
        if mod(i,25) == 0
            disp(['Neuron = ' num2str(i)]);
        end
        masterInd = structfind(masterN,'name',BCstruct(i).name);
        masterCurveInd = structfind(masterN(masterInd).data.(genvarname(method)),'Curvature',BCstruct(i).Curvature);
        masterN(masterInd).data.(genvarname(method))(masterCurveInd).Ddata.reg = fitwrapperBounds(masterN(masterInd).data.(genvarname(method))(masterCurveInd).Ddata.L,masterN(masterInd).data.(genvarname(method))(masterCurveInd).Ddata.N,masterN(masterInd).data.(genvarname(method))(masterCurveInd).Ddata.res,LSCO,FSCO,minPts);
    end
    
end