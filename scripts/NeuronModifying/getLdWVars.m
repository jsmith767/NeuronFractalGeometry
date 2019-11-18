function [D,LdW,w,L] = getLdWVars(masterN,varargin)
p = inputParser;
addParameter(p,'method','S',@ischar);
addParameter(p,'curvature',1,@isnumeric);
parse(p,varargin{:});
m = matlab.lang.makeValidName(p.Results.method);
c = p.Results.curvature;
w = zeros(size(masterN,1));
L = zeros(size(masterN,1));
for i=1:length(masterN)
    wtemp = vertcat(masterN(i).data.(m).W{:});
    w(i)=median(wtemp);
end

for i=1:length(masterN)
    L(i) = masterN(i).TL;
end
D = AvgAngleVsD(masterN,'curvature',c,'method',p.Results.method);
D = D{1};
LdW = L./w;
end
