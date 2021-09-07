%batch Neuron Creator
%masterN = bNC(readPath,fullfile(writePathBase,method),curveRange,method)
%readPath = 'E:\Julian\Arbors as they were sent\Basal'
%writePathBase = 'E:\Julian\Rediscovery_9-7-2021\Neurons'
%curveRange = 0:0.25:2;
%method = 'W';  %see pNR for methods

% r = 'E:\Julian\FractalNeurons\37_0005_Special\Basal';
% w = 'E:\Julian\FractalNeurons\37_0005_Special\Results';
% rA = 'E:\Julian\FractalNeurons\NeuronOBJs\Basal';
% wA = 'E:\Julian\FractalNeurons\createNeurons';

%old confusing, but probably works
%e.g. mS = bNC(rA,fullfile(wA,'S'),i,'S','scaling',i,'timeOne',true);


function masterN = bNC(readPath,writePathBase,curveRange,method,varargin)

p=inputParser;
addParameter(p, 'redo',false, @islogical); % redo the neuron
addParameter(p, 'SA',true, @islogical); % get the surface area of the neuron
addParameter(p, 'Angles',true, @islogical); % extract the angles of the neuron
addParameter(p, 'Mass',true, @islogical); % find the mass of the neuron
addParameter(p, 'BoundingArea',true, @islogical); % Get bounding area of neuron
addParameter(p, 'Voxelize',true, @islogical); % voxelize the data
addParameter(p, 'BoxCount',true, @islogical); % box count of the data
addParameter(p, 'Regression',true, @islogical); % regression analysis of the data
addParameter(p, 'Profile',true, @islogical); % Get profile of the data
addParameter(p, 'CreationOnly',false,@islogical); %skips all secondary analysis
addParameter(p, 'Timing',false, @islogical); % times all the code
addParameter(p, 'timeParts',false, @islogical); % times parts of the code
addParameter(p, 'timeOne',false, @islogical); % times One neuron for all parts of the code
addParameter(p, 'scaling',1, @isnumeric); % scaling used for several methods 'S' for instance
addParameter(p,'saveString','masterN',@ischar);

parse(p,varargin{:});
[~,upFolder]=fileparts(readPath); %upfolder should be the folder you are in.  Either 'Basal' or 'Apical'

writePath = fullfile(writePathBase,upFolder); 
scaling = p.Results.scaling;


masterN = struct('name','','path','','data',[],'SLA',[],'VRM',[],'DM',[],'WL',[],'PL',[],'IL',[],'TL',[],'S',[]);
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

if ~exist(writePath,'dir')
   mkdir(writePath); 
end
if p.Results.Timing
    T = clock;
end
for i=1:length(masterN)%length(masterN):-1:1%198:-1:100%length(masterN):-1:150
        disp(num2str(i));
        if p.Results.timeOne
            tN = clock;
        end
        %checks to see if the output file we will write already exists.
        if (exist(fullfile(writePath,[masterN(i).name '-' num2str(curveRange) '.mat']),'file') == 2) && ~p.Results.redo
            neuron = load(fullfile(writePath,[masterN(i).name '-' num2str(curveRange) '.mat']));
            for fn = fieldnames(neuron.x)'
                masterN(i).(fn{1}) = neuron.x.(fn{1});
            end
        else
%             try
                if p.Results.timeParts
                    t = clock;
                end
                [V,VAll,SLA,VRM,DM,WL,PL,IL,N,Face]=pNR(masterN(i).name,masterN(i).path,writePath,curveRange,scaling,method);
                masterN(i).data = getCurveData2(curveRange,V,VAll,N,method); %get data specific to each curvature
                masterN(i).F = Face;%faces for the neuron
                masterN(i).SLA = SLA;%segment length array
                masterN(i).VRM = VRM;%vertex reptition matrix
                masterN(i).DM = DM;%daughter matrix
                masterN(i).WL = WL;%wonky list
                masterN(i).PL = PL;%parent List
                masterN(i).IL = IL;%iteration List
                masterN(i).TL = getNeuronTotLength(SLA); %gets the total length of the neuron
                masterN(i).S = scaling;%scaling factor
                if ~p.Results.CreationOnly
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Gen Neuron time = ' num2str(e)]);
                    end
                    if p.Results.SA
                        if p.Results.timeParts
                            t = clock;
                        end
                        [masterN(i),~,~,~] =getSurfArea(masterN(i),method,1);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['SA time = ' num2str(e)]);
                        end
                    end
                    if p.Results.Angles
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = getAnglesForMasterN(masterN(i),method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Angles time = ' num2str(e)]);
                        end
                    end
                    if p.Results.Mass
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = getMassBySeg2(masterN(i),method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Mass time = ' num2str(e)]);
                        end
                    end
                    if p.Results.BoundingArea
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = getConvHullSA(masterN(i),method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Bounding Area time = ' num2str(e)]);
                        end
                    end
                    if p.Results.Voxelize
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = Vint(masterN(i),'round',4,'method',method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Voxelize time = ' num2str(e)]);
                        end
                    end
                    if p.Results.BoxCount
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = bcW2(masterN(i),method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Box Count time = ' num2str(e)]);
                        end
                    end
                    if p.Results.Regression
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = batchRegAnalysisMat2(masterN(i),2,1/5,1,method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['Regression time = ' num2str(e)]);
                        end
                    end

                    if p.Results.Profile
                        if p.Results.timeParts
                            t = clock;
                        end
                        masterN(i) = profileAreaWrapper(masterN(i), 'method',method);
                        if p.Results.timeParts
                            e = etime(clock,t);
                            disp(['profile time = ' num2str(e)]);
                        end
                    end
                    %
    %                 specificN = masterN(i);

                end
                if p.Results.timeParts
                    t = clock;
                end
                parsave(fullfile(writePath,[masterN(i).name '-' num2str(curveRange) '.mat']),masterN(i));
                if p.Results.timeParts
                    e = etime(clock,t);
                    disp(['parsave time = ' num2str(e)]);
                end
%             catch
%                 disp(['Something went wrong when processing ' masterN(i).name]);
%             end
        end
        if p.Results.timeOne
            e = etime(clock,tN);
            disp(['One Neuron time = ' num2str(e)]);
        end
end
if p.Results.Timing
    e = etime(clock,T);
    disp(['Totale time = ' num2str(e)]);
end
save(fullfile(writePath,[p.Results.saveString '.mat']),'masterN','-v7.3');
end