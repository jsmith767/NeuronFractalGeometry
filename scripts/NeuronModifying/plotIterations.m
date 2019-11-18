function plotIterations(masterN,varargin)
p = inputParser;
addParameter(p, 'curvature',1, @isnumeric); % which of 9 curvatures do we have
addParameter(p, 'method', 'W',@ischar); % method
addParameter(p, 'ItMethod','SL',@ischar); 
addParameter(p, 'forPaper',true,@islogical); 
parse(p,varargin{:})
if p.Results.forPaper
    clr = flip([[255 0 0];[253 122 0];[255 255 0];[0 255 0]]/255);%[0 0 255];[127 0 128];[237 130 237]]/255);
    latlonview = [1.8;122.9];
else
    numColors = max(vertcat(masterN.(genvarname(p.Results.ItMethod)){:}));
    clr=hsv(numColors);
end
    for i = 1:length(masterN.(genvarname(p.Results.ItMethod)))
        for j=1:length(masterN.(genvarname(p.Results.ItMethod)){i})
            patchSpecial(masterN,1,'method',p.Results.method,'edgeC',clr(masterN.(genvarname(p.Results.ItMethod)){i}(j),:),'faceC',clr(masterN.(genvarname(p.Results.ItMethod)){i}(j),:),'single',true,'groupNum',i,'branchNum',j,'curvature',p.Results.curvature)
        end
    end
%     view(latlonview(2),latlonview(1));
end
