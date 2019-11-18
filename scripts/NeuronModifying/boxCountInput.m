% load('test_recarray_struct.mat')
%s is a struct with fields 'x','y', and 'z' which correspond to all the
%voxelized points of a neuron.  
% inputRes refers to the resolution which the file was voxelized at. this
% can be found in the neuranalyze.py file that created it.  Also it should
% be 1/(box size), give at the end of the 'mat' or '.npy' file 'L-0_25'->4

function ns = boxCountInput(s,varargin)
p=inputParser;
addParameter(p,'fracOfBBox',3,@isnumeric);
addParameter(p,'smallestBox',1,@isnumeric);
addParameter(p,'resOfVox',4,@isnumeric);
parse(p,varargin{:});
fracOfBBox = p.Results.fracOfBBox;
smallestBox = p.Results.smallestBox;
inputRes = p.Results.resOfVox;

bbox = max([max(s.x)-min(s.x),max(s.y)-min(s.y),max(s.z)-min(s.z)]); %define the bounding box
v = [s.x;s.y;s.z]'; %get the vertices (transpose for ease with later functions)
% inputRes = 5;
% tic %start timing
res = geomspace(fracOfBBox,bbox/smallestBox/inputRes,100); %geomspace(3,bbox/inputRes,100);%inputRes converts the boudning box 
%of the voxelized neuron to that of real units.  Think of res as a number of divisions of the bbox
% res = geomspace(1,bbox/inputRes/4,100); %-> values from a full box size to
% 0.25 micron
for i = 1:length(res) % goes through all the resolutions
%     disp(i)
    L = bbox/res(i); % finds the box length
    t = zeros(1,floor(L)+1); %initialize the counting struct
    for j = 0:floor(L) % loop through the box sizes
        t(j+1)=size(unique(uint16(ceil((v+j)./L)),'rows'),1); % gets all the counts at a particular length (see R.Montgomery thesis for algorithm)
    end
    ns(i).res = res(i); % Sets a struct with the resolution
    ns(i).L = L/inputRes; % Sets a struct with the box length
    ns(i).N = min(t); % Sets the min number of counts
end
% toc
end
        