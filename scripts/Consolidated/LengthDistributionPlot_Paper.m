NatInd = 5;
numNeurs = size(plottingN,2);
neur = 71;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0.4 1 0.4];[0 0.5 0];[0.05 0.8 0.8];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[237 130 237]]/255;
axFont = 18;
labelFont = 30;
numlengthbins = 10;
numTlengthbins = 10;


IBLcomb = cell(numNeurs,1);
ITLcomb = cell(numNeurs,1);
AveBLcomb = cell(numNeurs,1);
AllBLcomb = cell(numNeurs,1);
AllBLnormcomb = cell(numNeurs,1);
ICountscomb = cell(numNeurs,1);
iterations = cell(numNeurs,1);

for m = 1:numNeurs
    NS = struct();
    for i = 1:size(plottingN(m).ItData,2)
        NS(i).IL = plottingN(m).ItData(i).IL;
    end
    NS(1).SLA = plottingN(m).SLA;

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
    AllBLnormcomb{m,1} = AllBLcomb{m,1};
    AllBLnormcomb{m,1}(:,1) = AllBLnormcomb{m,1}(:,1)./max(AllBLnormcomb{m,1}(:,1));
end

numsegstotal = 0;
maxit = max(cellfun(@max,iterations));
ICountscomp = zeros(maxit,1);
totalits = 0;
for m = 1:numNeurs
    totalits = totalits + iterations{m,1};
    for i = 1:iterations{m,1}
        ICountscomp(i,1) = ICountscomp(i,1) + ICountscomb{m,1}(i,1);
    end
    numsegstotal = numsegstotal + size(AllBLcomb{m,1},1);
end
ITLcomp = zeros(totalits,2);
ITLnormcomp = zeros(totalits,2);
AveBLcomp = zeros(maxit,1);
AllBLcomp = zeros(numsegstotal,2);
AllBLnormcomp = zeros(numsegstotal,2);
scount = 0;
icount = 0;
for m = 1:numNeurs
    for i = 1:iterations{m,1}
        icount = icount + 1;
        ITLcomp(icount,:) = [ITLcomb{m,1}(i,1) i];
        ITLnormcomp(icount,:) = [ITLcomb{m,1}(i,1)./max(ITLcomb{m,1}(:,1)) i];
        AveBLcomp(i,1) = AveBLcomp(i,1) + AveBLcomb{m,1}(i,1)*ICountscomb{m,1}(i,1)/ICountscomp(i,1);
    end
    for j = 1:size(AllBLcomb{m,1},1)
        scount = scount + 1;
        AllBLcomp(scount,:) = AllBLcomb{m,1}(j,:);
        AllBLnormcomp(scount,:) = AllBLnormcomb{m,1}(j,:);
    end
end
AveBLcompErr = cell(maxit,1);
for i = 1:maxit
    AveBLcompErr{i,1} = AllBLcomp(AllBLcomp(:,2) == i,1);
    AveBLcomp(i,2) = std(AveBLcompErr{i,1});
end

% for neur = 1:238
%     if iterations{neur,1} == 6
        maxlength = max(AllBLcomb{neur,1}(:,1));
        % lengthrange = floor(min(AllBLcomb{neur,1}(:,1))):(ceil(max(AllBLcomb{neur,1}(:,1)))-floor(min(AllBLcomb{neur,1}(:,1))))/numlengthbins:ceil(max(AllBLcomb{neur,1}(:,1)));
        lengthrange = 0:1/numlengthbins:1;
%         lengthrange = 0:10:120;
        lengthbincenter = zeros(numlengthbins,1);
        inlengthbin = cell(numlengthbins,iterations{neur,1});
        numinlengthbin = zeros(numlengthbins,iterations{neur,1});
        NeurILAves = zeros(1,iterations{neur,1});
        NeurILMeds = zeros(1,iterations{neur,1});
        NeurILDevs = zeros(1,iterations{neur,1});
        NIBLs = cell(1,iterations{neur,1});
        for i = 1:iterations{neur,1}
            NIBLs{1,i} = AllBLcomb{neur,1}(AllBLcomb{neur,1}(:,2)==i,1);
            NeurILAves(1,i) = mean(maxlength./NIBLs{1,i});
            NeurILMeds(1,i) = median(maxlength./NIBLs{1,i});
            NeurILDevs(1,i) = std(maxlength./NIBLs{1,i});
            for k = 1:numlengthbins
                inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{neur,1}(:,1)./maxlength & AllBLcomb{neur,1}(:,1)./maxlength < lengthrange(1,k+1) & AllBLcomb{neur,1}(:,2) == i;
%                 inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{neur,1}(:,1) & AllBLcomb{neur,1}(:,1) < lengthrange(1,k+1) & AllBLcomb{neur,1}(:,2) == i;
                numinlengthbin(k,i) = sum(inlengthbin{k,i});
            end
        end
        for k = 1:numlengthbins
            lengthbincenter(k,1) = (lengthrange(1,k) + lengthrange(1,k+1))/2;
        end

%         F5 = figure('Name','EScat','units','normalized','outerposition',[1.02 0.12 0.6 0.85],'visible','off');
%         hold;
%         counts = sum(numinlengthbin);
%         for i = 1:iterations{neur,1}
%             errorbar(log(NeurILAves(1,i)),log(counts(1,i)),log(NeurILDevs(1,i)),'horizontal','^','LineWidth',2,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
%         end
%         ax5 = gca;
%         ax5.FontSize = axFont;
%         ax5L = xlabel('log(L_{max}/<L>)');
%         ax5L.FontSize = labelFont;
%         ay5L = ylabel('log(N)','Rotation',0,'HorizontalAlignment','right');
%         ay5L.FontSize = labelFont;
%         F1 = figure('Name','Hist','units','normalized','outerposition',[1.02 0.12 0.6 0.85],'visible','off');
%         title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur).name)},'Interpreter','None');
%         hold;
%         b = bar(lengthbincenter,numinlengthbin,'stacked','FaceColor','flat','BarWidth',1);
%         lgdstr = cell(iterations{neur,1},1);
%         count = 1;
%         for i = 1:iterations{neur,1}
%             lgdstr{i,1} = ['It ' num2str(i)];
%             b(i).CData = clr(count,:);
%             if count == size(clr,1)
%                 count = 1;
%             else
%                 count = count + 1;
%             end
%         end
%         ax = gca;
%         ax.FontSize = axFont;
%         axL = xlabel('L/L_{max}');
%         axL.FontSize = labelFont;
%         ayL = ylabel('N','Rotation',0,'HorizontalAlignment','right');
%         ayL.FontSize = labelFont;
%         legend(lgdstr,'Location','northeast','FontSize',10);
%         
%         print(['D:\Conor\Research\Figures\Neuron Analysis\Hists\Hist' num2str(neur)],'-djpeg')
%         close(F1)
%     end
% end


figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur).name)},'Interpreter','None');
hold;
b = bar(lengthbincenter,numinlengthbin,'stacked','FaceColor','flat','BarWidth',1);
lgdstr = cell(iterations{neur,1},1);
count = 1;
for i = 1:iterations{neur,1}
    lgdstr{i,1} = ['It ' num2str(i)];
    b(i).CData = clr(count,:);
    if count == size(clr,1)
        count = 1;
    else
        count = count + 1;
    end
end
ax = gca;
ax.FontSize = axFont;
axL = xlabel('L/L_{max}');
axL.FontSize = labelFont;
ayL = ylabel('N','Rotation',0,'HorizontalAlignment','right');
ayL.FontSize = labelFont;
legend(lgdstr,'Location','northeast','FontSize',10);

maxlengthALL = max(AllBLcomp(:,1));
% lengthrangeALL = floor(min(AllBLcomp(:,1))):(ceil(max(AllBLcomp(:,1)))-floor(min(AllBLcomp(:,1))))/numlengthbins:ceil(max(AllBLcomp(:,1)));
lengthrangeALL = 0:1/numlengthbins:1;
lengthbincenterALL = zeros(numlengthbins,1);
inlengthbinALL = cell(numlengthbins,maxit);
numinlengthbinALL = zeros(numlengthbins,maxit);
inlengthbinALLnorm = cell(numlengthbins,maxit);
numinlengthbinALLnorm = zeros(numlengthbins,maxit);

for i = 1:maxit
    for k = 1:numlengthbins-1
        inlengthbinALL{k,i} = lengthrangeALL(1,k) <= AllBLcomp(:,1)./maxlengthALL & AllBLcomp(:,1)./maxlengthALL < lengthrangeALL(1,k+1) & AllBLcomp(:,2) == i;
        numinlengthbinALL(k,i) = sum(inlengthbinALL{k,i});
        inlengthbinALLnorm{k,i} = lengthrangeALL(1,k) <= AllBLnormcomp(:,1) & AllBLnormcomp(:,1) < lengthrangeALL(1,k+1) & AllBLnormcomp(:,2) == i;
        numinlengthbinALLnorm(k,i) = sum(inlengthbinALLnorm{k,i});
    end
    k = numlengthbins;
    inlengthbinALL{k,i} = lengthrangeALL(1,k) <= AllBLcomp(:,1)./maxlengthALL & AllBLcomp(:,1)./maxlengthALL < lengthrangeALL(1,k+1) & AllBLcomp(:,2) == i;
    numinlengthbinALL(k,i) = sum(inlengthbinALL{k,i});
    inlengthbinALLnorm{k,i} = lengthrangeALL(1,k) <= AllBLnormcomp(:,1) & AllBLnormcomp(:,1) <= lengthrangeALL(1,k+1) & AllBLnormcomp(:,2) == i;
    numinlengthbinALLnorm(k,i) = sum(inlengthbinALLnorm{k,i});
end
for k = 1:numlengthbins
    lengthbincenterALL(k,1) = (lengthrangeALL(1,k) + lengthrangeALL(1,k+1))/2;
end

inTlengthbinnorm = cell(numTlengthbins,maxit);
numinTlengthbinnorm = zeros(numTlengthbins,maxit);
for i = 1:maxit
    for k = 1:numTlengthbins
        inTlengthbinnorm{k,i} = lengthrangeALL(1,k) <= ITLnormcomp(:,1) & ITLnormcomp(:,1) < lengthrangeALL(1,k+1) & ITLcomp(:,2) == i;
        numinTlengthbinnorm(k,i) = sum(inTlengthbinnorm{k,i});
    end
end

figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
title(strcat("Branch Lengths For All Basal Neurons (Norm Over All)"))
hold;
b2 = bar(lengthbincenterALL,sum(numinlengthbinALL,2),'stacked','FaceColor',[0 1 0],'BarWidth',1);
% lgdstr = cell(maxit,1);
% count = 1;
% for i = 1:maxit
%     lgdstr{i,1} = ['It ' num2str(i)];
%     b(i).CData = clr(count,:);
%     if count == size(clr,1)
%         count = 1;
%     else
%         count = count + 1;
%     end
% end
% legend(lgdstr,'Location','northeast','FontSize',10);
ax2 = gca;
ax2.FontSize = axFont;
ax2L = xlabel('L/L_{max}');
ax2L.FontSize = labelFont;
ay2L = ylabel('N','Rotation',0,'HorizontalAlignment','right');
ay2L.FontSize = labelFont;

figure('Name','3','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
title(strcat("Branch Lengths For All Basal Neurons"))
hold;
b3 = bar(lengthbincenterALL,sum(numinlengthbinALLnorm,2),'stacked','FaceColor',[0 1 0],'BarWidth',1);
ax3 = gca;
ax3.FontSize = axFont;
ax3L = xlabel('L/L_{max}');
ax3L.FontSize = labelFont;
ay3L = ylabel('N','Rotation',0,'HorizontalAlignment','right');
ay3L.FontSize = labelFont;

% figure('Name','4','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% title(strcat("Total Length of All Branches in Each Iteration"))
% hold;
% b4 = bar(lengthbincenterALL,sum(numinTlengthbinnorm,2),'stacked','FaceColor',[0 1 0],'BarWidth',1);
% ax4 = gca;
% ax4.FontSize = axFont;
% ax4L = xlabel('TIL/TIL_{max}');
% ax4L.FontSize = labelFont;
% ay4L = ylabel('N','Rotation',0,'HorizontalAlignment','right');
% ay4L.FontSize = labelFont;

figure('Name','5','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
hold;
counts = sum(numinlengthbin);
for i = 1:iterations{neur,1}
    errorbar(log(NeurILAves(1,i)),log(counts(1,i)),log(NeurILDevs(1,i)),'horizontal','^','LineWidth',2,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
end
ax5 = gca;
ax5.FontSize = axFont;
ax5L = xlabel('log(L_{max}/<L>)');
ax5L.FontSize = labelFont;
ay5L = ylabel('log(N)','Rotation',0,'HorizontalAlignment','right');
ay5L.FontSize = labelFont;

% clearvars -except plottingN plottingH masterN masterH