%e.g. masterN = segLengthWrapper(masterN,'method','S')
%gets all the segment lengths for all neurons in a masterN struct
function masterN = segLengthWrapper(masterN,varargin)
p = inputParser;
addParameter(p,'method','S',@ischar);
addParameter(p,'curvature',1,@isnumeric);
parse(p,varargin{:});
m = matlab.lang.makeValidName(p.Results.method);
c = p.Results.curvature;
for i=1:length(masterN)
    for j=1:length(masterN(i).data.(m)(c).V)
        [~,masterN(i).segL{j,1}] = CalcNeuronBranchLengthsSegs(masterN(i).data.(m)(c).V{j});
    end
end
end