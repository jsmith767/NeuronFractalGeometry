%Loads csv files created from box counting python program and puts it into
%the master neurons struct & does regression analysis

%FSCO = fine scale cutoff
%LSCO = large scale cutoff
% minpts = 56 1 order f magnitude 37 is 2/3 order of magnitude
%doesn't know how to skip over curvatures that don't have a csv file
% masterN = batchRegAnalysis(masterN,3.5,1,56,pwd);
% masterN = batchRegAnalysis(masterN,3.5,0.25,37,pwd);


function masterN = batchRegAnalysis(masterN,FSCO,LSCO,minPts,path)
F = dir(fullfile(path,'*.csv'));
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
% method = 'I';
% method = 'W';
method = 'P';
    for i = 1:length(F)
        i
        BCcell = importBCfile(F(i).name);
        BC = getBCstruct(BCcell);
        masterN = setDdata(masterN,BC,method);
        masterN = doRegAnalysis(masterN,BC,FSCO,LSCO,minPts,method); 
    end
    save('masterNOM1_2-oneFifth_56.mat','masterN','-v7.3');
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