%Process Neuron Return
%should be in program folder, or at least not in the folder where you move
%things to.

function [TotVnew,TotVAllnew,SLA,VRM,DM,WL,PL,IL,N,Face]= pNR(fileName,filePath,writePath,curveRange,scaling,method)

    [V,VAll,SLA,Face,Group] = analyzeNeuron(filePath,fileName); 
    VRM = cell(1,length(Group));
    DM = cell(1,length(Group));
    WL = cell(1,length(Group));
    PL = cell(1,length(Group));
    IL = cell(1,length(Group));
    Vnew = cell(1,length(Group));
    VAllnew = cell(1,length(Group));
    
    N = cell(1,length(curveRange));
    TotVnew = cell(1,length(curveRange));
    TotVAllnew = cell(1,length(curveRange));
    
%     W = getAllWidth(VAll);
    
    for i=1:length(Group)
         
         VRM{i} = distVertPos(V{i});
         [DM{i},WL{i},PL{i}] = daughterM(SLA{i},VRM{i});
         IL{i} = getItList(PL{i});
    end
    %global params (e.g. for LT case)
    TL=getNeuronTotLength(SLA);
    sla = vertcat(SLA{:});
    numBranch = size(vertcat(SLA{:}),1);
    %
    k = 1;
    for i=curveRange
         for j=1:length(Group)
             switch method
                 case 'original' %all angles of a single branch are manipulated.  Only not the angle from the last segment to the first of another
                     [Vnew{j},VAllnew{j}] = straightenNeuronOriginal(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'A' %all angles are manipulated, even between branches
                     [Vnew{j},VAllnew{j}] = straightenNeuronAllAngle(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'end' %all angles are manipulated but the first angle is set such that the end of the branch lies along a line that passed through the unmodifed end pt
                     [Vnew{j},VAllnew{j}] = straightenNeuronEnd(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--     
                 case 'init' %the angle between branches is manipulated
                     [Vnew{j},VAllnew{j}] = straightenNeuronInit(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'I' %the angle between branches is manipulated (I think this is maybe the same as Init?)
                       [Vnew{j},VAllnew{j}] = straightenNeuronI(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'W' %all the weave anlges, everything beyond the init and first angle of a branch
                     [Vnew{j},VAllnew{j}] = straightenNeuronW(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'P'%The init and first angle between segments in a branch
                     [Vnew{j},VAllnew{j}] = straightenNeuronP(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'F' %The fork angle (first angle between segments in a branch) is modified. All other angles set to 0
                     [Vnew{j},VAllnew{j}] = straightenNeuronForkDelta(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'SA' %Just the fork angle is set to 0. 'SA' is the second angle (which is really the first angle between segments in a branch)
                     [Vnew{j},VAllnew{j}] = straightenNeuronSA(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'L' %All lengths are set to the median without adjusting any angles
%                      sla = vertcat(SLA{:});
                     medL = median(sla(:,1))*scaling;%max(sla(:,1));%mean(sla(:,1));
                     [Vnew{j},VAllnew{j},SLA{j}] = straightenNeuronL(V{j},VAll{j},DM{j},SLA{j},medL,PL{j});%--
                 case 'LT' %All lengths are set to the value that keeps the total length fixed
                     branchL = (TL/numBranch)*scaling;%max(sla(:,1));%mean(sla(:,1));
                     [Vnew{j},VAllnew{j},SLA{j}] = straightenNeuronL(V{j},VAll{j},DM{j},SLA{j},branchL,PL{j});%--                                         
                 case 'S' %scale the neuron lengths without adjusting the widths
%                      sla = vertcat(SLA{:});
                     [Vnew{j},VAllnew{j},SLA{j}] = scaleNeuronL(V{j},VAll{j},DM{j},SLA{j},scaling,PL{j});%--    
                 case 'SN' %Scaling but then divide down so width is shrunk, but the whole neuron isn't scaled up
%                      sla = vertcat(SLA{:});
                     [Vnew{j},VAllnew{j},SLA{j}] = scaleNeuronL(V{j},VAll{j},DM{j},SLA{j},scaling,PL{j},'normalized',true);%--
                  case 'SNN' %Scale neuron naively. Literall just multiply things Be careful with your box counting ranges!
%                      sla = vertcat(SLA{:});
                    Vnew{j} = V{j}*scaling;
                    VAllnew{j} = VAll{j}*scaling;
                    SLA{j}(:,1) = SLA{j}(:,1)*scaling;     
             end
         end
         TotVnew{k} = Vnew;
         TotVAllnew{k} = VAllnew;
         N{k} = getVoxByIt(scaling,IL,SLA,VAllnew,Face);
         writeOBJpath(VAllnew,Face,Group,i,strcat(fileName,'Full'),writePath); %-- %writes rings to an obj file.
         k = k+1;
    end
end