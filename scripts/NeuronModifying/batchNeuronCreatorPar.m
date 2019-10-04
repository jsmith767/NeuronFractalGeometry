%Navigate to the 'Basal' or 'Apical' folder
function masterN = batchNeuronCreatorPar(readPath,writePathBase)

[~,upFolder]=fileparts(readPath); %upfolder should be the folder you are in.  Either 'Basal' or 'Apical'
% writePathBase = 'E:\Julian\Init\';
writePath = fullfile(writePathBase,upFolder); 
curveRange = 0:0.25:2;
scaling = 3;
% method = 'original';
method = 'init';
% method = 'allangles';
% method = 'end';

masterN = struct('name','','path','','data',[],'SLA',[],'VRM',[],'DM',[],'WL',[],'PL',[],'IL',[],'TL',[],'S',[]);
[P,F] = openNeuronOBJS();%gets the file paths and file names of obj files
k=1;
for i=1:length(F)
    for j = 1:length(F{i})
        [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
        masterN(k).name = fileName;
        masterN(k).path = P{i};
        k = k+1;
    end
end

    

for i=1%length(masterN):-1:1%198:-1:100%length(masterN):-1:150
        i

        %checks to see if the output file we will write already exists.
        if (exist(fullfile(writePath,[masterN(i).name '.mat']),'file') == 2)
            neuron = load(fullfile(writePath,[masterN(i).name '.mat']));
            for fn = fieldnames(neuron.x)'
                masterN(i).(fn{1}) = neuron.x.(fn{1});
            end
        else
            try
                [V,VAll,SLA,VRM,DM,WL,PL,IL,N]=processNeuronReturn(masterN(i).name,masterN(i).path,writePath,curveRange,scaling,method);
                masterN(i).data = getCurveData(curveRange,V,VAll,N,method); %get data specific to each curvature
                masterN(i).SLA = SLA;%segment length array
                masterN(i).VRM = VRM;%vertex reptition matrix
                masterN(i).DM = DM;%daughter matrix
                masterN(i).WL = WL;%wonky list
                masterN(i).PL = PL;%parent List
                masterN(i).IL = IL;%iteration List
%                 masterN(i).W = W;%branch width
                masterN(i).TL = getNeuronTotLength(SLA); %gets the total length of the neuron
                masterN(i).S = scaling;%scaling factor

                %
%                 specificN = masterN(i);
                parsave(fullfile(writePath,[masterN(i).name '.mat']),masterN(i));
% 
            catch
                disp(['Something went wrong when processing ' masterN(i).name]);
            end
        end
end
% save(fullfile(writePath,'masterN.mat'),'masterN','-v7.3');

end