%batch Neuron Creator
%readPath = 'E:\Julian\Arbors as they were sent\Basal'
%writePathBase = 'E:\Julian\OriginalNew3\';

function masterN = bNCPar(readPath,writePathBase,curveRange,method,varargin)

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
addParameter(p, 'Timing',false, @islogical); % times all the code
addParameter(p, 'timeParts',false, @islogical); % times parts of the code
addParameter(p, 'timeOne',false, @islogical); % times One neuron for all parts of the code
parse(p,varargin{:});
[~,upFolder]=fileparts(readPath); %upfolder should be the folder you are in.  Either 'Basal' or 'Apical'

writePath = fullfile(writePathBase,upFolder); 
% curveRange = 0:0.25:2;
scaling = 1;
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
% method = 'I';
% method = 'W';
% method = 'P';
% method = 'F';

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
for i=1:length(masterN)
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
                m.name = masterN(i).name;
                m.path = masterN(i).path;
                m.data = getCurveData2(curveRange,V,VAll,N,method); %get data specific to each curvature
                m.F = Face;%faces for the neuron
                m.SLA = SLA;%segment length array
                m.VRM = VRM;%vertex reptition matrix
                m.DM = DM;%daughter matrix
                m.WL = WL;%wonky list
                m.PL = PL;%parent List
                m.IL = IL;%iteration List
                m.TL = getNeuronTotLength(SLA); %gets the total length of the neuron
                m.S = scaling;%scaling factor
                if p.Results.timeParts
                    e = etime(clock,t);
                    disp(['Gen Neuron time = ' num2str(e)]);
                end
                if p.Results.SA
                    if p.Results.timeParts
                        t = clock;
                    end
                    [m(i),~,~,~] =getSurfArea(m(i),method,1);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['SA time = ' num2str(e)]);
                    end
                end
                if p.Results.Angles
                    if p.Results.timeParts
                        t = clock;
                    end
                    m(i) = getAnglesForMasterN(m,method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Angles time = ' num2str(e)]);
                    end
                end
                if p.Results.Mass
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = getMassBySeg2(m,method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Mass time = ' num2str(e)]);
                    end
                end
                if p.Results.BoundingArea
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = getConvHullSA(m,method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Bounding Area time = ' num2str(e)]);
                    end
                end
                if p.Results.Voxelize
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = Vint(m,'round',4,'method',method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Voxelize time = ' num2str(e)]);
                    end
                end
                if p.Results.BoxCount
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = bcW2(m,method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Box Count time = ' num2str(e)]);
                    end
                end
                if p.Results.Regression
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = batchRegAnalysisMat2(m,2,1/5,1,method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['Regression time = ' num2str(e)]);
                    end
                end
                
                if p.Results.Profile
                    if p.Results.timeParts
                        t = clock;
                    end
                    m = profileAreaWrapper(m, 'method',method);
                    if p.Results.timeParts
                        e = etime(clock,t);
                        disp(['profile time = ' num2str(e)]);
                    end
                end
                %
%                 specificN = masterN(i);
                if p.Results.timeParts
                    t = clock;
                end
                parsave(fullfile(writePath,[m.name '-' num2str(curveRange) '.mat']),m);
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
% save(fullfile(writePath,'masterN.mat'),'masterN','-v7.3');
end