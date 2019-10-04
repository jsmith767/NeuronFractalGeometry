%should be in program folder, or at least not in the folder where you move
%things to.

function [TotVnew,TotVAllnew,SLA,VRM,DM,WL,PL,IL,N]= processNeuronReturn(fileName,filePath,writePath,curveRange,scaling,method)

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
    k = 1;
    for i=curveRange
         for j=1:length(Group)
             switch method
                 case 'original'
                     [Vnew{j},VAllnew{j}] = straightenNeuronOriginal(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'allangles'
                     [Vnew{j},VAllnew{j}] = straightenNeuronAllAngle(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'end'
                     [Vnew{j},VAllnew{j}] = straightenNeuronEnd(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--     
                 case 'init'
                     [Vnew{j},VAllnew{j}] = straightenNeuronInit(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                 case 'I'
                       [Vnew{j},VAllnew{j}] = straightenNeuronI(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'W'
                     [Vnew{j},VAllnew{j}] = straightenNeuronW(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
                 case 'P'
                     [Vnew{j},VAllnew{j}] = straightenNeuronP(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--
                     
             end
         end
         TotVnew{k} = Vnew;
         TotVAllnew{k} = VAllnew;
         N{k} = getVoxByIterationShortTest(scaling,IL,SLA,VAllnew,Face,fileName);
%          writeOBJpath(VAllnew,Face,Group,i,strcat(fileName,'Full'),writePath); %-- %writes rings to an obj file.
         k = k+1;
    end
end