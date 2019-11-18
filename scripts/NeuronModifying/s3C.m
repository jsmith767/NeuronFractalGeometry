%Scatter plot with cubes of width 'w' at each points location.  Centered on
%a corner
function s3C(vector,w,varargin)
p = inputParser;
addParameter(p,'figure',false,@islogical);
addParameter(p,'alpha',1,@isnumeric);
parse(p,varargin{:});
if p.Results.figure
    figure
end
for i=1:size(vector,1)
    plotcube([w w w],[vector(i,1)-w/2,vector(i,2)-w/2,vector(i,3)-w/2],p.Results.alpha,[1 0 0]);
end
axis equal
% scatter3(vector(:,1),vector(:,2),vector(:,3),varargin{:})
end