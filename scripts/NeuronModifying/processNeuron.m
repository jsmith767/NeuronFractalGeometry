%should be in program folder, or at least not in the folder where you move
%things to.

%Need to have a write file that can handle the new cell array format of
%this code!!

function y = processNeuron(fileName,filePath)
    % fileName = 'a28_0001_M';
%     fileName = 'a28_0003_M'; 
%     filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Apical\Set 1\28';
    % fileName = 'a1_0001_B';
    % filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Apical\Set 1\1';
    % fileName = '1_0004';
    % fileName = '7_0002_MFull100';
    % fileName = '1_0001';
    % fileName = '1_BAS2';
    % filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Basal\Batch 1\1';
    % fileName = '2_0004';
%     fileName = '2_BAS1';
%     filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Basal\Batch 1\2';
    % [V,VAll,SLA,Face] = analyzeNeuron(filePath,fileName);
    [V,VAll,SLA,Face,Group] = analyzeNeuron(filePath,fileName); 
    VRM = cell(1,length(Group));
    DM = cell(1,length(Group));
    WL = cell(1,length(Group));
    PL = cell(1,length(Group));
    Vnew = cell(1,length(Group));
    VAllnew = cell(1,length(Group));

    for i=1:length(Group)
         VRM{i} = distVertPos(V{i});
         [DM{i},WL{i},PL{i}] = daughterM(SLA{i},VRM{i});
    end
    for i=0:.02:2
    %      Vnew = straightenNeuron(V,DM,SLA,WL,i);
         for j=1:length(Group)
             [Vnew{j},VAllnew{j}] = straightenNeuron(V{j},VAll{j},DM{j},SLA{j},WL{j},i);%--
%             [Vnew{j},VAllnew{j}] = straightenNeuronAllAngle(V{j},VAll{j},DM{j},SLA{j},WL{j},PL{j},i);%--

         end
    %      writeOBJ(Vnew,i,fileName);
         writeOBJFulltest(VAllnew,Face,Group,i,strcat(fileName,'Full')); %-- %writes rings to an obj file.
    end
end