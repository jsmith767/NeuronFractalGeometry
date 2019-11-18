function plotMaxUpHeat(masterN,varargin)
p = inputParser;
addParameter(p, 'curvature',1, @isnumeric); % which of 9 curvatures do we have
addParameter(p, 'method', 'W',@ischar); % method
addParameter(p, 'ItMethod','SL',@ischar); 
addParameter(p, 'forPaper',false,@islogical); 
parse(p,varargin{:})
if p.Results.forPaper
    clr = flip([[255 0 0];[253 122 0];[255 255 0];[0 255 0]]/255);%[0 0 255];[127 0 128];[237 130 237]]/255);
    latlonview = [1.8;122.9];
else
    tempUpLength = vertcat(masterN.Ldata.mSP{:});
    tempUpLength = vertcat(tempUpLength{:});
    maxUpLength = max(tempUpLength);
%     numColors = max(vertcat(masterN.(genvarname(p.Results.ItMethod)){:}));
%     clr=hsv(numColors);
end
    for i = 1:length(masterN.Ldata.mSP)%for the groups
        for j=1:length(masterN.Ldata.mSP{i})%for the branches
            for k=1:length(masterN.Ldata.mSP{i}{j}) %for the segments
            patchSpecial(masterN,1,'method',p.Results.method,'edgeC',[masterN.Ldata.mSP{i}{j}(k)/maxUpLength,0,0],'faceC',[masterN.Ldata.mSP{i}{j}(k)/maxUpLength,0,0],'singleSeg',true,'segNum',k,'groupNum',i,'branchNum',j,'curvature',p.Results.curvature)
            end
        end
    end
    
%     'edgeC',[masterN.Ldata.mSP{i}{j}(k)/maxUpLength,0,0],'faceC',[masterN.Ldata.mSP{i}{j}(k)/maxUpLength,0,0],:)
%     view(latlonview(2),latlonview(1));
end
