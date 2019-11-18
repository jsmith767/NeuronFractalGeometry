%e.g. masterN = segLWrapper(masterN,'method','S');
%For use with calcNeuronSegLengths
% preferred method for getting segment lengths

function masterN = segLWrapper(masterN,varargin)
p = inputParser;
addParameter(p,'method','S',@ischar);
addParameter(p,'curvature',1,@isnumeric);
parse(p,varargin{:});
m = matlab.lang.makeValidName(p.Results.method);
c = p.Results.curvature;
for i=1:length(masterN)
    for j=1:length(masterN(i).data.(m)(c).V)
        masterN(i).segL{j,1} = calcNeuronSegLengths(masterN(i).data.(m)(c).V{j},masterN(i).SLA{j});
    end
end
end