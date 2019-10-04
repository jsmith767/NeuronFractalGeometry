%Navigate to the 'Basal' or 'Apical' folder of 'As they were Sent'
%readPath = 'E:\Julian\Arbors as they were sent\Basal'
%writePathBase = 'E:\Julian\OriginalNew3\';
function s = getFacesForMaster(s,varargin)

p = inputParser;
% addParameter(p, 'method','allangles', @ischar);
addParameter(p, 'readPath', 'E:\Julian\Arbors as they were sent\Basal', @ischar);
parse(p,varargin{:});
readPath = p.Results.readPath;
% method = p.Results.method;
% [~,upFolder]=fileparts(readPath); %upfolder should be the folder you are in.  Either 'Basal' or 'Apical'

% writePath = fullfile(writePathBase,upFolder); 
% curveRange = 0:0.25:2;
% scaling = 3;
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
% method = 'I';
% method = 'W';
% method = 'P';

% masterN = struct('name','','path','','data',[],'SLA',[],'VRM',[],'DM',[],'WL',[],'PL',[],'IL',[],'TL',[],'S',[]);
[P,F] = openNeuronOBJS(readPath);%gets the file paths and file names of obj files
k=1;
for i=1:length(F)
    for j = 1:length(F{i})
        [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
        masterN(k).name = fileName;
        masterN(k).path = P{i};
        k = k+1;
    end
end
for i=1:length(s)
[~,~,~,F,~] = analyzeNeuron(masterN(structfind(masterN,'name',s(i).name)).path,masterN(structfind(masterN,'name',s(i).name)).name);
s(i).F = F;
i
end
end