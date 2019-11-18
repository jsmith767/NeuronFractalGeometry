function masterN = profileAreaWrapper(masterN, varargin)
p= inputParser;
addParameter(p,'method','F',@ischar);
addParameter(p,'viewpoints',201,@isnumeric);
addParameter(p,'diameter',5,@isnumeric);
parse(p,varargin{:});
method = p.Results.method;
    for i=1:length(masterN)
        for j=1:length(masterN(i).data.(genvarname(method)))
            [avep,plist,~] = ProfileArea(masterN(i).data.(genvarname(method))(j).VintR1,p.Results.viewpoints,p.Results.diameter);
            masterN(i).data.(genvarname(method))(j).AveP = avep;
            masterN(i).data.(genvarname(method))(j).AllP = plist;
        end
    end
end