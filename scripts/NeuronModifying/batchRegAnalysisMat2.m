%Loads mat files created from box counting python program and puts it into
%the master neurons struct & does regression analysis

%FSCO = fine scale cutoff
%LSCO = large scale cutoff
% minpts = 56 1 order f magnitude 37 is 2/3 order of magnitude
%doesn't know how to skip over curvatures that don't have a csv file
% masterN = batchRegAnalysis(masterN,3.5,1,56,pwd);
% masterN = batchRegAnalysis(masterN,3.5,0.25,37,pwd);
% updated 2-13-2019 (at least) min pts -> order of magnitude
% masterN = batchRegAnalysisMat(masterN,2,1/5,1,pwd);
% updated 10-23-2019
% masterN = batchRegAnalysisMat2(masterN,2,1/5,1,method);

function masterN = batchRegAnalysisMat2(masterN,FSCO,LSCO,minPts,method)
for i=1:length(masterN)
    for j=1:length(masterN(i).data.(genvarname(method)))
        L = masterN(i).data.(genvarname(method))(j).Ddata.L;
        N = masterN(i).data.(genvarname(method))(j).Ddata.N;
        res = masterN(i).data.(genvarname(method))(j).Ddata.res;
        masterN(i).data.(genvarname(method))(j).Ddata.reg = fitwrapperBounds(L,N,res,LSCO,FSCO,minPts);
        masterN(i).data.(genvarname(method))(j).D = masterN(i).data.(genvarname(method))(j).Ddata.reg.D;
    end
end
end

% j=1;
% for i=1:length(masterN)
%     try 
%         D(j) = masterN(i).data.original(5).Ddata.reg.D;
%         LSCOInd(j) = masterN(i).data.original(5).Ddata.reg.LSCOInd;
%         FSCOInd(j) = masterN(i).data.original(5).Ddata.reg.FSCOInd;
%         j= j+1;
%     catch
%         
%     end
% end