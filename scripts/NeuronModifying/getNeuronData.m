function [DM,WL,PL,SLA,VRM,V,VAll] = getNeuronData(fileName,filePath)
    % fileName = 'a28_0001_M';
    % fileName = 'a28_0003_M'; %works!!
    % filePath = 'C:\Users\jsmit\Google Drive\Research\NeuronData\Arbors as they were sent\Apical\Set 1\28';
    [V,VAll,SLA,Face,Group] = analyzeNeuron(filePath,fileName);
    VRM = cell(1,length(Group));  %vertex representation matrix
    DM = cell(1,length(Group));  %Daughter Matrix
    WL = cell(1,length(Group));  %wonky list
    PL = cell(1,length(Group));  %Parent List
    Vnew = cell(1,length(Group)); 
    VAllnew = cell(1,length(Group));

    for i=1:length(Group)
         VRM{i} = distVertPos(V{i});
         [DM{i},WL{i},PL{i}] = daughterM(SLA{i},VRM{i});
    end
    %these next lines will probably need to be amended later
%     SLA = {cat(1, SLA{:})};

end
% histogram(SLA{1}(:,1),20); % produces a nice histogram plot
% [y,x] = hist(SLA{1}(:,1),20); %gets histogram x,y pairs

% plot(x,y);
% scatter(log(1./x),log(y)); % has the problem that some bins have zero
% height and thus inf for log(Y).  Need to discuss how best to fit

%clears y of infinities
% x = x(y>0);
% y = y(y>0);

% polyfit(log(x),log(y),1); %first element  should be slope