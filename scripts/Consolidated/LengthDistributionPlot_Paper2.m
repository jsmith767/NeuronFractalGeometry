% load('K:\Keck\Programs\Consolidated\MATs\plottingH_4-18-19.mat');
% load('D:\Conor\Research\Mathematica\HTree-Models\3D-7It-Both\MATs\masterH-3.mat');
HTreeM = ImportTxt_HTree('D:\Conor\Research\Mathematica\HTree-Models\3D-7It-Both\Mathematica-Txts\It7Branch2D1.40Length2900Width1.5Theta0Phi0BranchAngle90.001.txt');

neur = 28; % 88, 96, 104, 184 (These are for plottingN_5-2-19.mat) 88 (28 for healthy only) and 104 prefered

NatInd = 5;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0.4 1 0.4];[0 0.5 0];[0.05 0.8 0.8];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
clr = [[255 0 0];[253 122 0];[255 255 0];[0 255 0];[0 0 255];[127 0 128];[237 130 237]]/255;
BckClr = 'none';
axFont = 18;
labelFont = 26;
LWidth = 2;
MSize = 8;
BarWidth = 1;
numlengthbins = 10;
numNeurs = size(plottingN,2);
% ax1loc = [0.075 0.66 0.5 0.37];
% ax2loc = [0.427 0.66 0.5 0.37];
ax1loc = [0.2 0.69 0.25 0.24];
ax2loc = [0.47 0.69 0.25 0.24];
ax3loc = [0.2 0.46 0.25 0.2];
ax4loc = [0.47 0.46 0.25 0.2];
ax5loc = [0.2 0.15 0.25 0.2];
ax6loc = [0.47 0.15 0.25 0.2];
ax1I = 'a';
ax1iloc = [0.2 0.839 0.1 0.1];
ax2I = 'b';
ax2iloc = [0.47 0.839 0.1 0.1];
ax3I = 'c';
ax3iloc = [0.2 0.57 0.1 0.1];
ax4I = 'd';
ax4iloc = [0.47 0.57 0.1 0.1];
ax5I = 'e';
ax5iloc = [0.2 0.25 0.1 0.1];
ax6I = 'f';
ax6iloc = [0.47 0.26 0.1 0.1];
% ax3xtick = ;
% ax4xtick = ;
% ax5xtick = ;
% ax6xtick = ;
ax3ytick = [0 30 60];
ax4ytick = [0 6 12];
ax5ytick = [0.3 1 1.7];
ax6ytick = [0.6 0.9 1.2];
HBarRangeX = [-0.05 1.05];
HBarRangeY = [0 85];
NBarRangeX = [-0.05 1.05];
NBarRangeY = [0 16];
HScaleRangeX = [-1.275 0.1];
HScaleRangeY = [0.15 2.1];
NScaleRangeX = [-1.4 0.1];
NScaleRangeY = [0.53 1.27];

latlonview = [1.8;122.9];


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
%             NeurILAves(1,i) = mean(maxlength./NIBLs{1,i});
%             NeurILMeds(1,i) = median(maxlength./NIBLs{1,i});
%             NeurILDevs(1,i) = std(maxlength./NIBLs{1,i});
%             NeurILAves(1,i) = maxlength./mean(NIBLs{1,i});
%             NeurILMeds(1,i) = maxlength./median(NIBLs{1,i});
%             NeurILDevs(1,i) = std(log10(maxlength./NIBLs{1,i}));
            NeurILAves(1,i) = mean(NIBLs{1,i})./maxlength;
            NeurILMeds(1,i) = median(NIBLs{1,i})./maxlength;
            NeurILDevs(1,i) = std(log10(NIBLs{1,i}./maxlength));
            for k = 1:numlengthbins-1
                inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{neur,1}(:,1)./maxlength & AllBLcomb{neur,1}(:,1)./maxlength < lengthrange(1,k+1) & AllBLcomb{neur,1}(:,2) == i;
%                 inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{neur,1}(:,1) & AllBLcomb{neur,1}(:,1) < lengthrange(1,k+1) & AllBLcomb{neur,1}(:,2) == i;
                numinlengthbin(k,i) = sum(inlengthbin{k,i});
            end
            k = numlengthbins;
            inlengthbin{k,i} = lengthrange(1,k) <= AllBLcomb{neur,1}(:,1)./maxlength & AllBLcomb{neur,1}(:,1)./maxlength <= lengthrange(1,k+1) & AllBLcomb{neur,1}(:,2) == i;
            numinlengthbin(k,i) = sum(inlengthbin{k,i});
        end
        for k = 1:numlengthbins
            lengthbincenter(k,1) = (lengthrange(1,k) + lengthrange(1,k+1))/2;
        end

figure('Name','LD Plot','units','normalized','outerposition',[1.02 0.12 0.6 0.85],'color','w')
ax4 = axes('Position',ax4loc,'Box','off','Color',BckClr,'LineWidth',LWidth,'TickDir','out','xcolor',[0 0 0],'ycolor',[0 0 0]);
topline4 = axes('Position',ax4loc,'Box','on','Color',BckClr,'xtick',[],'ytick',[],'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0]);
axes(ax4);
yyaxis right;
ax4i = annotation('textbox',ax4iloc,'String',ax4I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
ay4L = ylabel('$N$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
set(ax4,'ycolor',[0 0 0]/255,'xcolor',[0 0 0]/255,'LineWidth',LWidth,'ytick',ax4ytick);
% title({strcat("Branch Lengths For Basal Neuron ",plottingN(neur).name)},'Interpreter','None');
hold;
b4 = bar(lengthbincenter,numinlengthbin,'stacked','FaceColor','flat','BarWidth',BarWidth,'LineWidth',LWidth,'EdgeColor',[0 0 0]);
xlim(NBarRangeX);
ylim(NBarRangeY);
yyaxis left;
set(ax4,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
lgdstr = cell(iterations{neur,1},1);
count = 1;
for i = 1:iterations{neur,1}
    lgdstr{i,1} = num2str(i);
    b4(i).CData = clr(count,:);
    if count == size(clr,1)
        count = 1;
    else
        count = count + 1;
    end
end
% ax4 = gca;
ax4.FontSize = axFont;
% ax4L = xlabel('$\frac{L}{L_{max}}$','Interpreter','latex');
ax4L = xlabel('$L/L_{max}$','Interpreter','latex');
ax4L.FontSize = labelFont;
ay4L.FontSize = labelFont;
% legend(lgdstr,'Location','northeast','FontSize',10);

% figure('Name','6','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax6 = axes('Position',ax6loc,'Box','off','Color',BckClr,'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0]);
topline6 = axes('Position',ax6loc,'Box','on','Color',BckClr,'xtick',[],'ytick',[],'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0]);
axes(ax6);
yyaxis right;
ax6i = annotation('textbox',ax6iloc,'String',ax6I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
set(ax6,'ycolor',[0 0 0]/255,'xcolor',[0 0 0]/255,'LineWidth',LWidth,'ytick',ax6ytick);
ay6L = ylabel('$log(N)$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
hold;
counts = sum(numinlengthbin);
for i = 1:iterations{neur,1}
%     errorbar(log10(NeurILAves(1,i)),log10(counts(1,i)),NeurILDevs(1,i),'horizontal','^','MarkerSize',MSize,'LineWidth',LWidth,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
    errorbar(log10(NeurILAves(1,i)),log10(counts(1,i)),NeurILDevs(1,i),'horizontal','^','MarkerSize',MSize,'LineWidth',LWidth,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
end
xlim(NScaleRangeX)
ylim(NScaleRangeY)
yyaxis left;
set(ax6,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
% ax6 = gca;
ax6.FontSize = axFont;
% ax6L = xlabel('$log(\frac{L_{max}}{<L>})$','Interpreter','latex');
ax6L = xlabel('$log(L/L_{max})$','Interpreter','latex');
ax6L.FontSize = labelFont;
ay6L.FontSize = labelFont;
hold off;

% add axis
% figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax2 = axes('Position',ax2loc,'Box','on','Color',BckClr,'LineWidth',LWidth,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[],'xcolor',[0 0 0],'ycolor',[0 0 0]);
ax2i = annotation('textbox',ax2iloc,'String',ax2I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
% % neurim = imread(['K:\Keck\Programs\Profiles\FinalFigures_4-25-19\Neuron' num2str(neur) ' - Copy.png']);
% % imshow(neurim);
% axis equal;
% % axis off;
% grid off;
% set(gca,'CameraViewAngleMode','Manual');
% hold;
% for i = 1:size(mNVox(neur).data.A(5).ItData,2)
% %     scatter3(mNVox(neur).data.A(5).ItData(i).voxUAll(:,1),mNVox(neur).data.A(5).ItData(i).voxUAll(:,2),mNVox(neur).data.A(5).ItData(i).voxUAll(:,3),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
%     scatter(mNVox(neur).data.A(5).ItData(i).voxUAll(:,1),mNVox(neur).data.A(5).ItData(i).voxUAll(:,2),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end



its = 6;
tlen = 2900;
Df = 1.00:0.01:2.00;
D1p4i = 41;
numDfs = length(Df);
Nb = 2;
branchlen = zeros(numDfs,its);
branchrem = zeros(numDfs,its);
extralen = zeros(numDfs,1);
for d = 1:numDfs
    for i = 1:its
        branchlen(d,i) = (tlen/(sum(Nb.^(((1:its).*(Df(1,d)-1)+1)./Df(1,d)))))/(Nb^((i-1)/Df(1,d)));
%         branchrem(d,i) = rem(branchlen(d,i),floor(branchlen(d,i)));
%         extralen(d,1) = extralen(d,1) + (2^i)*(1-branchrem(d,i));
    end
%     extralen(d,1) = round(extralen(d,1));
end
Hmaxlength = max(branchlen(D1p4i,:));

% figure('Name','5','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax5 = axes('Position',ax5loc,'Box','off','Color',BckClr,'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0],'ytick',ax5ytick);
topline5 = axes('Position',ax5loc,'Box','on','Color',BckClr,'xtick',[],'ytick',[],'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0]);
axes(ax5);
ax5i = annotation('textbox',ax5iloc,'String',ax5I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
hold;
counts = Nb.^(1:its);
% HScaleFit = polyfit(log10(Hmaxlength./branchlen(D1p4i,:)),log10(counts(1,:)),1);
HScaleFit = polyfit(log10(branchlen(D1p4i,:)./Hmaxlength),log10(counts(1,:)),1);
HFitRange = -2:0.1:0.3;
plot(HFitRange,(HScaleFit(1)*HFitRange)+HScaleFit(2),'k-','LineWidth',LWidth);
for i = 1:its
%     errorbar(log10(Hmaxlength./branchlen(D1p4i,i)),log10(counts(1,i)),0,'horizontal','^','MarkerSize',MSize,'LineWidth',LWidth,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
    errorbar(log10(branchlen(D1p4i,i)./Hmaxlength),log10(counts(1,i)),0,'horizontal','^','MarkerSize',MSize,'LineWidth',LWidth,'MarkerFaceColor',clr(i,:),'Color',clr(i,:));
end
xlim(HScaleRangeX)
ylim(HScaleRangeY)
% ax5 = gca;
ax5.FontSize = axFont;
% ax5L = xlabel('$log(\frac{L_{max}}{L})$','Interpreter','latex');
ax5L = xlabel('$log(L/L_{max})$','Interpreter','latex');
ax5L.FontSize = labelFont;
ay5L = ylabel('$log(N)$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
ay5L.FontSize = labelFont;

Hinlengthbin = cell(numlengthbins,iterations{neur,1});
Hnuminlengthbin = zeros(numlengthbins,iterations{neur,1});
for i = 1:its
    for k = 1:numlengthbins-1
        if lengthrange(1,k) <= branchlen(D1p4i,i)/Hmaxlength && branchlen(D1p4i,i)/Hmaxlength < lengthrange(1,k+1)
            Hnuminlengthbin(k,i) = Nb.^i;
        end
    end
    k = numlengthbins;
    if lengthrange(1,k) <= branchlen(D1p4i,i)/Hmaxlength && branchlen(D1p4i,i)/Hmaxlength <= lengthrange(1,k+1)
        Hnuminlengthbin(k,i) = Nb.^i;
    end
end
% figure('Name','3','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax3 = axes('Position',ax3loc,'Box','off','Color',BckClr,'LineWidth',LWidth,'TickDir','out','xcolor',[0 0 0],'ycolor',[0 0 0],'ytick',ax3ytick);
topline3 = axes('Position',ax3loc,'Box','on','Color',BckClr,'xtick',[],'ytick',[],'LineWidth',LWidth,'xcolor',[0 0 0],'ycolor',[0 0 0]);
axes(ax3);
ax3i = annotation('textbox',ax3iloc,'String',ax3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
% title({strcat("Branch Lengths For D=1.4 HTree")},'Interpreter','None');
hold;
b3 = bar(lengthbincenter,Hnuminlengthbin,'stacked','FaceColor','flat','BarWidth',BarWidth,'LineWidth',LWidth,'EdgeColor',[0 0 0]);
xlim(HBarRangeX);
ylim(HBarRangeY);
lgdstr = cell(its,1);
count = 1;
for i = 1:its
%     lgdstr{i,1} = ['It ' num2str(i)];
    lgdstr{i,1} = num2str(i);
    b3(i).CData = clr(count,:);
    if count == size(clr,1)
        count = 1;
    else
        count = count + 1;
    end
end
% ax3 = gca;
ax3.FontSize = axFont;
% ax3L = xlabel('$\frac{L}{L_{max}}$','Interpreter','latex');
ax3L = xlabel('$L/L_{max}$','Interpreter','latex');
ax3L.FontSize = labelFont;
ay3L = ylabel('$N$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
ay3L.FontSize = labelFont;
legend(lgdstr,'Interpreter','latex','Location','northeast','FontSize',14,'Box','off');

HModel = cell(1,its);
HMview = cell(1,its);
for i = 1:its
    HModel{1,i} = HTreeM(HTreeM(:,4)==i,1:3);
    HMview{1,i} = HModel{1,i};
    for d = 1:size(HMview{1,i},1)
        HMview{1,i}(d,1:3) = rotationmat3D(-latlonview(1,1),[cos(pi/2+latlonview(2,1)) sin(pi/2+latlonview(2,1)) 0])*HMview{1,i}(d,:)';
    end
end
% figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax1 = axes('Position',ax1loc,'Box','on','Color',BckClr,'LineWidth',LWidth,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[],'xcolor',[0 0 0],'ycolor',[0 0 0]);
ax1i = annotation('textbox',ax1iloc,'String',ax1I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',labelFont,'FontName','SansSerif');
% % treeim = imread('K:\Keck\Programs\Profiles\FinalFigures_4-25-19\HTreeOutline - Copy.png');
% % imshow(treeim);
% axis equal;
% % axis off;
% grid off;
% set(gca,'CameraViewAngleMode','Manual','color','none');
% hold;
% for i = 1:its
% %     scatter3(HMview{1,i}(:,1),HMview{1,i}(:,2),HMview{1,i}(:,3),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
%     scatter(HMview{1,i}(:,1),HMview{1,i}(:,2),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end

clearvars -except plottingN plottingH masterN masterH HTreeM mNVox