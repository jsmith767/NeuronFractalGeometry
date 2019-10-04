% Returns the vertices and lengths of a reconstructed neuron.  
% Example "[V,SLA] = analyzeNeuron('a28_0001_M');" where V give the x,y,z,
% coordinates of the points and SLA (segment length array) gives the lengths of segments.
% previously [points,allPoints,lengths,faces] = analyzeNeuron(filePath,fileName)
function [points,allPoints,lengths,faces,groups] = analyzeNeuron(filePath,fileName)
% fileName = '6_BAS1 sansoma';
fileType = '.obj';
% filePath = 'C:\Users\Julian\Desktop\AData\8 Basal Tree Models\';
% filePath = 'C:\Users\Julian\Desktop\NeuronData\Arbors as they were sent\Apical\Set 1\28\';
% filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Apical\Set 1\28\';
% [VAll,~,F] = ReadOBJmodified([filePath '\' fileName fileType]);
[VAll,~,F,G] = ReadOBJtest(fullfile(filePath,[fileName fileType]));
if length(G) > 1  %kill the soma which is always the first group of points
    VAll(1) = []; %kill the first group of vertices
    F(1) = []; %get rid of the first set of faces
    F = cellfun(@(x) x-(G(2)-G(1)), F,'UniformOutput',false); %make the next set of faces index at 1
    G = G -(G(2)-G(1)); %adjust the group indexing
    G(1) = []; %get rid of the first group which was for the soma
end
V = cell(1,length(G));
B = cell(1,length(G));
for i=1:length(G)
    V{i} = convertNeuronRingsToPoints(VAll{i});
    B{i} = CalcNeuronBranchLengths(V{i});
end
% V = convertNeuronRingsToPoints(VAll);
% B = CalcNeuronBranchLengths(V);
points = V;
lengths = B;
allPoints = VAll;
faces = F;
groups = G;
end