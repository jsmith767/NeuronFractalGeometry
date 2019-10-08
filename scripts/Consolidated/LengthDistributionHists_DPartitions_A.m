% load('D:\SharedProjects\Consolidated\plottingN.mat');

AorB = 'Apical';
NatInd = 5;
BNumCurvs = size(plottingN(1).data.allangles,2);
PartitionStart = 1.375;
PartitionEnd = 1.455;
BNumParts = 4; %Must be greater than or equal to 3
BPartitions = PartitionStart:(PartitionEnd-PartitionStart)/(BNumParts-2):PartitionEnd;
neur = zeros(1,BNumParts);
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0.4 1 0.4];[0 0.5 0];[0.05 0.8 0.8];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
axFont = 16;
labelFont = 18;
numlengthbins = 10;
numTlengthbins = 10;

F = extractfield(plottingN,'name');
for i = 2:BNumCurvs
    for j = 1:size(F,2)
        F{i,j} = F{1,j};
    end
end
D = cell(BNumCurvs,size(plottingN,2));
for c = 1:BNumCurvs
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.allangles(c).Ddata)
                D{c,n} = plottingN(n).data.allangles(c).Ddata.reg.D;
            end
        end
    end
end
IF = ~cellfun(@isempty,F);
ID = ~cellfun(@isempty,D);
Index = and(IF,ID);
UseIndex = 1;
checknum = sum(Index(UseIndex,:));
for i = 1:BNumCurvs
    if checknum > sum(Index(i,:))
        checknum = sum(Index(i,:));
        UseIndex = i;
    end
end
BFbyC = cell(BNumCurvs,sum(Index(UseIndex,:)));
BDbyC = zeros(BNumCurvs,sum(Index(UseIndex,:)));
for i = 1:BNumCurvs
    jsub = 0;
    for j = 1:size(plottingN,2)
        if Index(UseIndex,j)
            BFbyC{i,j-jsub} = plottingN(j).name;
        else
            jsub = jsub+1;
        end
    end
    BDbyC(i,:) = vertcat(D{i,Index(UseIndex,:)});
end
BPI = cell(BNumParts,1);
BPI{1,1} = BDbyC(NatInd,:)<=BPartitions(1);
BPI{BNumParts,1} = BDbyC(NatInd,:)>BPartitions(end);
for p = 2:BNumParts-1
    BPI{p,1} = BDbyC(NatInd,:)>BPartitions(p-1) & BDbyC(NatInd,:)<=BPartitions(p);
end

MIndex = zeros(1,size(BPI{1,1},2));
nsub = 0;
for n = 1:size(plottingN,2)
    if Index(UseIndex,n)
        MIndex(1,n-nsub) = n;
    else
        nsub = nsub+1;
    end
end
IndexChange = cell(BNumParts,1);
numNeurs = cell(BNumParts,1);
for p = 1:BNumParts
    numNeurs{p,1} = sum(BPI{p,1});
    IndexChange{p,1} = zeros(1,numNeurs{p,1});
    BPIN = find(BPI{p,1});
    for m = 1:numNeurs{p,1}
        IndexChange{p,1}(1,m) = MIndex(1,BPIN(1,m));
    end
end


clearvars -except 'plottingN' 'AorB' 'neur' 'NatInd' 'IndexChange' 'numNeurs' 'clr' 'axFont' 'labelFont' 'numlengthbins' 'numTlengthbins' 'masterNA' 'API' 'AFbyC' 'ADbyC' 'APartitions' 'ANumCurvs' 'ANumParts' 'masterNB' 'BPI' 'BFbyC' 'BDbyC' 'BPartitions' 'BNumCurvs' 'BNumParts'


for p = 1:BNumParts
    IBLcomb = cell(numNeurs{p,1},1);
    ITLcomb = cell(numNeurs{p,1},1);
    AveBLcomb = cell(numNeurs{p,1},1);
    AllBLcomb = cell(numNeurs{p,1},1);
    ICountscomb = cell(numNeurs{p,1},1);
    iterations = cell(numNeurs{p,1},1);
    
    for m = 1:numNeurs{p,1}
        n = IndexChange{p,1}(1,m);
        NS = struct();
        for i = 1:size(plottingN(n).data.allangles(NatInd).ItData,2)
            NS(i).IL = plottingN(n).data.allangles(NatInd).ItData(i).IL;
        end
        NS(1).SLA = plottingN(n).SLA;

        iterations{m,1} = size(NS,2);
        numbranches = size(NS(1).IL,2);
        finalbranchit = zeros(numbranches,1);
        ICounts = cell(numbranches,1);
        II = cell(size(NS(1).IL,2),1);

        IBL = cell(numbranches,1);
        ITL = cell(numbranches,1);
        AveBL = cell(numbranches,1);
        AllBL = cell(numbranches,1);

        branches = zeros(iterations{m,1},1);
        numsegs = 0;
        for i = 1:iterations{m,1}
            branches(i,1) = size(NS(i).IL,2);
        end
        for b = 1:numbranches
            for i = 1:iterations{m,1}
                if b > branches(i,1)
                    finalbranchit(b,1) = i-1;
                    II{b,1} = false(finalbranchit(b,1),size(NS(finalbranchit(b,1)).IL{1,b},1));
                    for ii = 1:finalbranchit(b,1)
                        II{b,1}(ii,:) = NS(finalbranchit(b,1)).IL{1,b} == ii;
                    end
                    ICounts{b,1} = accumarray(NS(finalbranchit(b,1)).IL{1,b},1);
                    break
                elseif isempty(NS(i).IL{1,b})
                    finalbranchit(b,1) = i-1;
                    II{b,1} = false(finalbranchit(b,1),size(NS(finalbranchit(b,1)).IL{1,b},1));
                    for ii = 1:finalbranchit(b,1)
                        II{b,1}(ii,:) = NS(finalbranchit(b,1)).IL{1,b} == ii;
                    end
                    ICounts{b,1} = accumarray(NS(finalbranchit(b,1)).IL{1,b},1);
                    break
                elseif i == iterations{m,1} && ~isempty(NS(i).IL{1,b})
                    finalbranchit(b,1) = i;
                    II{b,1} = false(finalbranchit(b,1),size(NS(finalbranchit(b,1)).IL{1,b},1));
                    for ii = 1:finalbranchit(b,1)
                        II{b,1}(ii,:) = NS(finalbranchit(b,1)).IL{1,b} == ii;
                    end
                    ICounts{b,1} = accumarray(NS(finalbranchit(b,1)).IL{1,b},1);
                end
            end
            IBL{b,1} = zeros(iterations{m,1},max(ICounts{b,1}));
            ITL{b,1} = zeros(iterations{m,1},1);
            AveBL{b,1} = zeros(iterations{m,1},1);
            AllBL{b,1} = zeros(size(NS(finalbranchit(b,1)).IL{1,b},1),2);
            numsegs = numsegs + size(NS(finalbranchit(b,1)).IL{1,b},1);
        end

        scount = 0;
        IBLcomb{m,1} = zeros(iterations{m,1},max(cellfun(@max,ICounts)));
        ITLcomb{m,1} = zeros(iterations{m,1},1);
        AveBLcomb{m,1} = zeros(iterations{m,1},1);
        AllBLcomb{m,1} = zeros(numsegs,2);
        ICountscomb{m,1} = zeros(iterations{m,1},1);
        for i = 1:iterations{m,1}
            acount = zeros(numbranches,1);
            for b = 1:branches(i,1)
                if ~isempty(NS(i).IL{1,b})
                    BL = NS(1).SLA{1,b}(II{b,1}(i,:),1);
                    for j = 1:ICounts{b,1}(i,1)
                        acount(b,1) = acount(b,1) + 1;
                        scount = scount + 1;
                        IBL{b,1}(i,j) = IBL{b,1}(i,j) + BL(j,1);
                        AllBL{b,1}(acount(b,1),:) = [BL(j,1) i];

                        IBLcomb{m,1}(i,j) = IBLcomb{m,1}(i,j) + IBL{b,1}(i,j);
                        AllBLcomb{m,1}(scount,:) = [BL(j,1) i];
                    end
                    AveBL{b,1}(i,1) = sum(IBL{b,1}(i,:))/ICounts{b,1}(i,1);
                    ITL{b,1}(i,1) = sum(IBL{b,1}(i,:));

                    AveBLcomb{m,1}(i,1) = AveBLcomb{m,1}(i,1) + sum(IBL{b,1}(i,:));
                    ITLcomb{m,1}(i,1) = ITLcomb{m,1}(i,1) + ITL{b,1}(i,1);
                    ICountscomb{m,1}(i,1) = ICountscomb{m,1}(i,1) + ICounts{b,1}(i,1);
                end
            end
            AveBLcomb{m,1}(i,1) = AveBLcomb{m,1}(i,1)/ICountscomb{m,1}(i,1);
        end
    end

    numsegstotal = 0;
    maxit = max(cellfun(@max,iterations));
    ICountscomp = zeros(maxit,1);
    totalits = 0;
    for m = 1:numNeurs{p,1}
        totalits = totalits + iterations{m,1};
        for i = 1:iterations{m,1}
            ICountscomp(i,1) = ICountscomp(i,1) + ICountscomb{m,1}(i,1);
        end
        numsegstotal = numsegstotal + size(AllBLcomb{m,1},1);
    end
    ITLcomp = zeros(totalits,2);
    AveBLcomp = zeros(maxit,1);
    AllBLcomp = zeros(numsegstotal,2);
    scount = 0;
    icount = 0;
    for m = 1:numNeurs{p,1}
        for i = 1:iterations{m,1}
            icount = icount + 1;
            ITLcomp(icount,:) = [ITLcomb{m,1}(i,1) i];
            AveBLcomp(i,1) = AveBLcomp(i,1) + AveBLcomb{m,1}(i,1)*ICountscomb{m,1}(i,1)/ICountscomp(i,1);
        end
        for j = 1:size(AllBLcomb{m,1},1)
            scount = scount + 1;
            AllBLcomp(scount,:) = AllBLcomb{m,1}(j,:);
        end
    end
    AveBLcompErr = cell(maxit,1);
    for i = 1:maxit
        AveBLcompErr{i,1} = AllBLcomp(AllBLcomp(:,2) == i,1);
        AveBLcomp(i,2) = std(AveBLcompErr{i,1});
    end
    
    neur(1,p) = IndexChange{p,1}(1,1);
    lengthrange = floor(min(AllBLcomb{1,1}(:,1))):(ceil(max(AllBLcomb{1,1}(:,1)))-floor(min(AllBLcomb{1,1}(:,1))))/numlengthbins:ceil(max(AllBLcomb{1,1}(:,1)));
    lengthbincenter = zeros(numlengthbins,1);
    inlengthbin = cell(numlengthbins,iterations{1,1});
    numinlengthbin = zeros(numlengthbins,iterations{1,1});
    for i = 1:iterations{1,1}
        for k = 1:numlengthbins
            inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{1,1}(:,1) & AllBLcomb{1,1}(:,1) < lengthrange(1,k+1) & AllBLcomb{1,1}(:,2) == i;
            numinlengthbin(k,i) = sum(inlengthbin{k,i});
        end
    end
    for k = 1:numlengthbins
        lengthbincenter(k,1) = (lengthrange(1,k) + lengthrange(1,k+1))/2;
    end
    
    if p == 1
        figure('Name',strcat("Distributions for D partition = [0,",num2str(BPartitions(1,p)),"]"),'NumberTitle','off')
        subplot(2,2,1)
        title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur(1,p)).name),strcat("in D partition = [0,",num2str(BPartitions(1,p)),"]")},'Interpreter','None');
    elseif p == BNumParts
        figure('Name',strcat("Distributions for D partition = (",num2str(BPartitions(1,p-1)),",\infty)"),'NumberTitle','off')
        subplot(2,2,1)
        title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur(1,p)).name),strcat("in D partition = (",num2str(BPartitions(1,p-1)),",\infty)")},'Interpreter','None');
    else
        figure('Name',strcat("Distributions for D partition = (",num2str(BPartitions(1,p-1)),",",num2str(BPartitions(1,p)),"]"),'NumberTitle','off')
        subplot(2,2,1)
        title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur(1,p)).name),strcat("in D partition = (",num2str(BPartitions(1,p-1)),",",num2str(BPartitions(1,p)),"]")},'Interpreter','None');
    end
    hold;
    b = bar(lengthbincenter,numinlengthbin,'stacked','FaceColor','flat','BarWidth',1);
    lgdstr = cell(iterations{1,1},1);
    count = 1;
    for i = 1:iterations{1,1}
        lgdstr{i,1} = ['It ' num2str(i)];
        b(i).CData = clr(count,:);
        if count == 9
            count = 1;
        else
            count = count + 1;
        end
    end
    ax = gca;
    ax.FontSize = axFont;
    axL = xlabel('Branch Length');
    axL.FontSize = labelFont;
    ayL = ylabel('Counts');
    ayL.FontSize = labelFont;
    legend(lgdstr,'Location','northeast','FontSize',10);


    lengthrangeALL = floor(min(AllBLcomp(:,1))):(ceil(max(AllBLcomp(:,1)))-floor(min(AllBLcomp(:,1))))/numlengthbins:ceil(max(AllBLcomp(:,1)));
    lengthbincenterALL = zeros(numlengthbins,1);
    inlengthbinALL = cell(numlengthbins,maxit);
    numinlengthbinALL = zeros(numlengthbins,maxit);
    for i = 1:maxit
        for k = 1:numlengthbins
            inlengthbinALL{k,i} = lengthrangeALL(1,k) <= AllBLcomp(:,1) & AllBLcomp(:,1) < lengthrangeALL(1,k+1) & AllBLcomp(:,2) == i;
            numinlengthbinALL(k,i) = sum(inlengthbinALL{k,i});
        end
    end
    for k = 1:numlengthbins
        lengthbincenterALL(k,1) = (lengthrangeALL(1,k) + lengthrangeALL(1,k+1))/2;
    end
    % figure
    subplot(2,2,2)
    title(strcat("Branch Lengths For All ",AorB," Neurons"))
    hold;
    b = bar(lengthbincenterALL,numinlengthbinALL,'stacked','FaceColor','flat','BarWidth',1);
    lgdstr = cell(maxit,1);
    count = 1;
    for i = 1:maxit
        lgdstr{i,1} = ['It ' num2str(i)];
        b(i).CData = clr(count,:);
        if count == 9
            count = 1;
        else
            count = count + 1;
        end
    end
    ax = gca;
    ax.FontSize = axFont;
    axL = xlabel('Branch Lengths');
    axL.FontSize = labelFont;
    ayL = ylabel('Counts');
    ayL.FontSize = labelFont;
    legend(lgdstr,'Location','northeast','FontSize',10);


    Tlengthrange = floor(min(ITLcomp(:,1))):(ceil(max(ITLcomp(:,1)))-floor(min(ITLcomp(:,1))))/numTlengthbins:ceil(max(ITLcomp(:,1)));
    Tlengthbincenter = zeros(numTlengthbins,1);
    inTlengthbin = cell(numTlengthbins,maxit);
    numinTlengthbin = zeros(numTlengthbins,maxit);
    for i = 1:maxit
        for k = 1:numTlengthbins
            inTlengthbin{k,i} = Tlengthrange(1,k) <= ITLcomp(:,1) & ITLcomp(:,1) < Tlengthrange(1,k+1) & ITLcomp(:,2) == i;
            numinTlengthbin(k,i) = sum(inTlengthbin{k,i});
        end
    end
    for k = 1:numTlengthbins
        Tlengthbincenter(k,1) = (Tlengthrange(1,k) + Tlengthrange(1,k+1))/2;
    end
    % figure
    subplot(2,2,3)
    title({'Total Length of All Branches','in Each Iteration'})
    hold;
    b = bar(Tlengthbincenter,numinTlengthbin,'stacked','FaceColor','flat','BarWidth',1);
    lgdstr = cell(maxit,1);
    count = 1;
    for i = 1:maxit
        lgdstr{i,1} = ['It ' num2str(i)];
        b(i).CData = clr(count,:);
        if count == 9
            count = 1;
        else
            count = count + 1;
        end
    end
    ax = gca;
    ax.FontSize = axFont;
    axL = xlabel('Total Iteration Length');
    axL.FontSize = labelFont;
    ayL = ylabel('Counts');
    ayL.FontSize = labelFont;
    legend(lgdstr,'Location','northeast','FontSize',10);


    % figure
    subplot(2,2,4)
    title({'Average Branch Length','Within an Iteration'})
    hold;
    % errorbar(1:maxit,AveBLcomp(:,1),AveBLcomp(:,2),AveBLcomp(:,2),'k--s')
    b = bar(AveBLcomp(:,1),'FaceColor','flat','BarWidth',1);
    count = 1;
    for i = 1:maxit
        b.CData(i,:) = clr(count,:);
        if count == 9
            count = 1;
        else
            count = count + 1;
        end
    end
    ax = gca;
    ax.FontSize = axFont;
    axL = xlabel('Iteration');
    axL.FontSize = labelFont;
    ayL = ylabel('Average Branch Length');
    ayL.FontSize = labelFont;
end

for p = 1:BNumParts
    if p == 1
        disp(strcat("There are ",num2str(sum(BPI{p,1}))," ",AorB," neurons in D partition = [0,",num2str(BPartitions(1,p)),"]"));
    elseif p == BNumParts
        disp(strcat("There are ",num2str(sum(BPI{p,1}))," ",AorB," neurons in D partition = (",num2str(BPartitions(1,p-1)),",\infty)"));
    else
        disp(strcat("There are ",num2str(sum(BPI{p,1}))," ",AorB," neurons in D partition = (",num2str(BPartitions(1,p-1)),",",num2str(BPartitions(1,p)),"]"));
    end
end

clearvars -except 'plottingN'