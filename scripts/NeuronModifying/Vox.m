function points = Vox(VAll,F,varargin)
p = inputParser;
% addParameter(p,'method','F',@ischar);
addParameter(p,'resolution',0.1,@isnumeric);
addParameter(p,'round',1,@isnumeric); %set the division you want to round to e.g. 2 -> 0.5 4 -> 0.25
parse(p,varargin{:});
    % method = 'allangles';
%     method = 'W';
Vinttemp =makeSurface(VAll,F,p.Results.resolution);
points = unique(round(Vinttemp * (p.Results.round)) / (p.Results.round),'rows');

end