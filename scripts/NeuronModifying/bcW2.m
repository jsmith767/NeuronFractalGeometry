%boxCountWrapper that explictely looks for a folder in the function.  Then
%just loops through all the files in that folder.
function masterN = bcW2(masterN,method,varargin)
p=inputParser;
addParameter(p,'fracOfBBox',3,@isnumeric);
addParameter(p,'smallestBox',1,@isnumeric);
addParameter(p,'resOfVox',4,@isnumeric); %resolution of voxelization in voxels/micron: Default VintR4 -> 4
parse(p,varargin{:});

for i=1:length(masterN)%for neuron number
    for j=1:length(masterN(i).data.(genvarname(method))) % for the curvature
        bc.name = masterN(i).name;
        bc.Curvature = masterN(i).data.(genvarname(method))(j).Curvature;
        s.x = masterN(i).data.(genvarname(method))(j).VintR4(:,1)'*p.Results.resOfVox;
        s.y = masterN(i).data.(genvarname(method))(j).VintR4(:,2)'*p.Results.resOfVox;
        s.z = masterN(i).data.(genvarname(method))(j).VintR4(:,3)'*p.Results.resOfVox;
        ns = boxCountInput(s,varargin{:});  %'L-0_25'->4
        bc.res = extractfield(ns,'res');
        bc.L = extractfield(ns,'L');
        bc.N = extractfield(ns,'N');
        masterN(i).data.(genvarname(method))(j).Ddata = bc;
    end
end
end