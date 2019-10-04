%Function that loads many files and finds useful Data about them and puts
%them into a struct

[P,F] = openNeuronOBJS();%gets the file paths and file names of obj files
% type = 'Apical';

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

% Vols = cell(1,length(F));%initializes a volume variable
% VolsExact = cell(1,length(F));%initializes a volume variable for the skeleton
% V= cell(1,length(F));%for each folder (curvature)
% VAll = cell(1,length(F));%for each folder (curvature)
% Face = cell(1,length(F));%for each folder (curvature)
% SLA = cell(1,length(F)); %for each folder (curvature)
% Group = cell(1,length(F));%for each folder (curvature)

%The below code assumes that there are identical sets of neuron obj files
%in several folders
% Facewrapper = cell(1,length(F{1}));
% Groupwrapper = cell(1,length(F{1}));
% Vscaledwrapper = cell(1,length(F{1}));
% VAllscaledwrapper = cell(1,length(F{1}));
% Volscaledwrapper = cell(1,length(F{1}));
% VolscaledExactwrapper = cell(1,length(F{1}));
for i=1:length(F{1})%for the number of files to be ran through.
%     i
    for j=1:length(F) %for the number of folders (curvatures)
%         [V,~,~,~] = ReadOBJtest([P{j} '\' F{j}{i}]);
%         try
            [V,VAll,SLA,Face,Group] = analyzeNeuronPristine(P{j},F{j}{i}(1:end-4)); 
            AllV = [];%initialize variable to collect multiple branches into one array
            AllVAll = [];%same as above but for entire rings
            for k=1:length(V) %for all branches
                AllVAll = [AllVAll; VAll{k}];
                AllV = [AllV ; V{k}];
            end
            VRM = cell(1,length(Group));  %vertex representation matrix
            DM = cell(1,length(Group));  %Daughter Matrix
            WL = cell(1,length(Group)); %Wonky List
            PL = cell(1,length(Group)); %Parent List
            for p=5:length(Group)
             VRM{p} = distVertPos(V{p});
             [DM{p},WL{p},PL{p}] = daughterM(SLA{p},VRM{p});
            end
            [~,Vol]=convhull(AllVAll(:,1),AllVAll(:,2),AllVAll(:,3));%finds the volume
            %for a specific neuron at the j'th curvature
    %         [~,VolsExact{j}]=convhull(AllV(:,1),AllV(:,2),AllV(:,3));
            neuron(j).name{i} = F{j}{i}(1:end-4);
            neuron(j).DM{i} = DM;
            neuron(j).WL{i} = WL;
            neuron(j).PL{i} = PL;
            neuron(j).SLA{i} = SLA;
            neuron(j).VRM{i} = VRM;
            neuron(j).V{i} = V;
            neuron(j).VAll{i} = VAll;
            neuron(j).AllV{i} = AllV;
            neuron(j).AllVAll{i} = AllVAll; 
            neuron(j).Vol{i} = Vol;
%         catch
%             disp(['Something went wrong when getting data' F{j}{i}]);
%         end
    end
end
% ADataSV = neuron;
% name = ['ADataOSV.mat'];
% save(name,'ADataOSV','-v7.3');

