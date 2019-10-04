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
Group = cell(1,length(F));%for each folder (curvature)

%The below code assumes that there are identical sets of neuron obj files
%in several foldersget
Facewrapper = cell(1,length(F{1}));
Groupwrapper = cell(1,length(F{1}));
Vscaledwrapper = cell(1,length(F{1}));
VAllscaledwrapper = cell(1,length(F{1}));
Volscaledwrapper = cell(1,length(F{1}));
VolscaledExactwrapper = cell(1,length(F{1}));
for i=47:length(F{1})%for the number of files to be ran through.
    try
        for j=1:length(F) %for the number of folders (curvatures)
    %         [V,~,~,~] = ReadOBJtest([P{j} '\' F{j}{i}]);
            [V{j},VAll{j},~,Face{j},Group{j}] = analyzeNeuronPristine(P{j},F{j}{i}(1:end-4)); 
            AllV = [];%initialize variable to collect multiple branches into one array
            AllVAll = [];%same as above but for entire rings
            for k=1:length(V{j}) %for all branches
                AllVAll = [AllVAll; VAll{j}{k}];
                AllV = [AllV ; V{j}{k}];
            end
            [~,Vols{j}]=convhull(AllVAll(:,1),AllVAll(:,2),AllVAll(:,3));%finds the volume
            %for a specific neuron at the j'th curvature
            [~,VolsExact{j}]=convhull(AllV(:,1),AllV(:,2),AllV(:,3));
        end
        Vscaled = cell(1,length(Vols));
        VAllscaled = cell(1,length(Vols));
        Volscaled = cell(1,length(Vols));
        VolscaledExact = cell(1,length(VolsExact));
        for m=1:length(Vols) %runs over all curvatures
    %         for n=1:length(V) 
    %             R = nthroot(Vols{2}/Vols{m},3);
                R = nthroot(VolsExact{2}/VolsExact{m},3);%Finds the factor that you must multiply
                %the m'th curvature by to make the same volume as the 2nd
                %(natural) in this case
                [Vscaled{m}, VAllscaled{m}] = rescaleNeuron(V{m},VAll{m},R);
                AllVAllscaled = [];
                AllVscaled = [];
                for k=1:length(V{m}) %for all branches
                    AllVAllscaled = [AllVAllscaled; VAllscaled{m}{k}];
                    AllVscaled = [AllVscaled ; Vscaled{m}{k}];
                end
                [~,Volscaled{m}]=convhull(AllVAllscaled(:,1),AllVAllscaled(:,2),AllVAllscaled(:,3));%finds the volume
                 %for a specific neuron at the j'th curvature
                [~,VolscaledExact{m}]=convhull(AllVscaled(:,1),AllVscaled(:,2),AllVscaled(:,3));
    %             [~,Volscaled{m}]= convhull(VAllscaled{m}{1}(:,1),VAllscaled{m}{1}(:,2),VAllscaled{m}{1}(:,3));
    %             [~,VolscaledExact{m}]= convhull(Vscaled{m}{1}(:,1),Vscaled{m}{1}(:,2),Vscaled{m}{1}(:,3));
                %         end

        end
    %     Facewrapper{i} = Face;
    %     Groupwrapper{i} = Group;
    %     Vscaledwrapper{i} = Vscaled;
    %     VAllscaledwrapper{i} = VAllscaled;
    %     Volscaledwrapper{i} = Volscaled;
    %     VolscaledExactwrapper{i} = VolscaledExact;
        for j=1:length(F) %for the number of folders (curvatures)
            [oldPath,fileEnd] = fileparts(P{j});
            [~,neuronType] = fileparts(oldPath);
            folderPath = ['N:\FractalGeometryOfNeurons\NeuronOBJsOrigSameVolume\' neuronType '\'];
            exptocut = regexp(F{j}{i},'Full.*','match');
            sizeToCut = length(exptocut{1});
    %         sizeToCut = length(fileEnd) + 4 + 4; %amount to cut off end of filename.
            writeOBJFulltestPath(VAllscaled{j},Face{j},Group{j},str2num(fileEnd)/100,strcat(F{j}{i}(1:end-sizeToCut),'OrigSameVol'),folderPath)
    %         writeOBJFulltestPath(VAllscaledwrapper{i}{j},Facewrapper{i}{j},Groupwrapper{i}{j},str2num(fileEnd)/100,strcat(F{j}{i}(1:end-sizeToCut),'OrigSameVol'),folderPath)
        end 
    catch
        disp(['i=' num2str(i) ', Neuron = ' F{j}{i}]);
    end
end
%% 

% for i=1:length(F{1})%for the number of files to be ran through.
%     for j=1:length(F) %for the number of folders (curvatures)
%         [oldPath,fileEnd] = fileparts(P{j});
%         [~,neuronType] = fileparts(oldPath);
%         folderPath = ['N:\NeuronOBJsOrigSameVolume\' neuronType '\'];
%         sizeToCut = length(fileEnd) + 4 + 4; %amount to cut off end of filename.
%         writeOBJFulltestPath(VAllscaledwrapper{i}{j},Facewrapper{i}{j},Groupwrapper{i}{j},str2num(fileEnd)/100,strcat(F{j}{i}(1:end-sizeToCut),'OrigSameVol'),folderPath)
%     end 
% end

% for i=1:length(F)
%     for j=1:length(F{i})
% %         fileName = F{i}(j);
%         [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
%         filePath = P{i};
%         %checks to see if the output file we will write already exists.
%         %Have to look at 'writeOBJFulltest.m' to find the path.  clunky...
%         if ~(exist(fullfile('C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\',[fileName 'Full0.obj']),'file') == 2)
%             try
%                 processNeuron(fileName,filePath);
%             catch
%                 disp(['Something went wrong when processing' fileName]);
%             end
%         end
%     end
% end
% 
