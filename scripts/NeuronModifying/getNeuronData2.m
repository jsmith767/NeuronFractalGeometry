%Function that loads many files and rescales them for the constant mass
%case
[P,F] = openNeuronOBJS();%gets the file paths and file names of obj files

%Check to make sure that all folders have the same files and in the same
%ororder. Exit the program with a warning if they do not.
try
    same = compareCellArrays(F);
catch
    warning(['Folders are not the same, or the file structure is not' ...
    ' as expected, exiting program']);
    return;
end
if ~same
    warning('Folders are not the same, exiting program');
    return;
end

Vols = cell(1,length(F));%initializes a volume variable
VolsExact = cell(1,length(F));%initializes a volume variable for the skeleton
V= cell(1,length(F));%for each folder (curvature)
VAll = cell(1,length(F));%for each folder (curvature)
Face = cell(1,length(F));%for each folder (curvature)
lengths = cell(1,length(F));
Group = cell(1,length(F));%for each folder (curvature)

%The below code assumes that there are identical sets of neuron obj files
%in several folders
Facewrapper = cell(1,length(F{1}));
Groupwrapper = cell(1,length(F{1}));
Vscaledwrapper = cell(1,length(F{1}));
VAllscaledwrapper = cell(1,length(F{1}));
Volscaledwrapper = cell(1,length(F{1}));
VolscaledExactwrapper = cell(1,length(F{1}));
for i=1:length(F{1})%for the number of files to be ran through.
    for j=1:length(F) %for the number of folders (curvatures)
%         [V,~,~,~] = ReadOBJtest([P{j} '\' F{j}{i}]);
        [V{j},VAll{j},lengths{j},Face{j},Group{j}] = analyzeNeuronPristine(P{j},F{j}{i}(1:end-4)); 
        AllV = [];%initialize variable to collect multiple branches into one array
        AllVAll = [];%same as above but for entire rings
        for k=1:length(V{j}) %for all branches
            AllVAll = [AllVAll; VAll{j}{k}];
            AllV = [AllV ; V{j}{k}];
        end
        [~,Vols{j}]=convhull(AllVAll(:,1),AllVAll(:,2),AllVAll(:,3));%finds the volume
        %for a specific neuron at the j'th curvature
%         [~,VolsExact{j}]=convhull(AllV(:,1),AllV(:,2),AllV(:,3));
        neuron(j).name(i) = F{j}{i}(1:end-4);
        neuron(j).DM(i)= 
        ,neuron(i).WL{j},neuron(i).PL{j},neuron(i).SLA{j},neuron(i).VRM{j},neuron(i).V{j},neuron(i).VAll{j}] = getNeuronData(fileName,filePath);
%               
    end
end
% 
