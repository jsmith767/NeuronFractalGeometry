% load('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_56_W_Prof.mat');
% masterNB = masterN;
% clear('masterN')

clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
order = [1,2,3,4,5,6,7,8,9];
Corder = ["Trend" "0.00" "0.25" "0.50" "0.75" "1.00" "1.25" "1.50" "1.75" "2.00"];
NatInd = 5;
Numbins = 6;
binfitstart = 1;
binfitend = 6;
% Variables for W method
plotrangex = [1.3 1.61];
plotrangepro = [0.078 0.163];
PartitionStart = 1.374;
PartitionEnd = 1.4626;
% % Variables for P method
% plotrangex = ;
% plotrangepro = ;
% PartitionStart = ;
% PartitionEnd = ;
% % Variables for AllAngles method
% plotrangex = ;
% plotrangepro = ;
% PartitionStart = ;
% PartitionEnd = ;
NumParts = 4; %Must be either 4 or 6
BPartitions = PartitionStart:(PartitionEnd-PartitionStart)/(NumParts-2):PartitionEnd;


BNumMods = size(plottingN(1).data.allangles,2);
Fcell = extractfield(plottingN,'name');
for i = 1:BNumMods
    for j = 1:size(Fcell,2)
        Fcell{i,j} = Fcell{1,j};
    end
end
Dcell = cell(BNumMods,size(plottingN,2));
Vcell = cell(BNumMods,size(plottingN,2));
Pcell = cell(BNumMods,size(plottingN,2));
Mcell = cell(BNumMods,size(plottingN,2));
SAcell = cell(BNumMods,size(plottingN,2));
SAtcell = cell(BNumMods,size(plottingN,2));
SABcell = cell(BNumMods,size(plottingN,2));
VMcell = cell(BNumMods,size(plottingN,2));
Lcell = cell(1,size(plottingN,2));
for c = 1:BNumMods
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.allangles(c).Ddata)
                Dcell{c,n} = plottingN(n).data.allangles(c).Ddata.reg.D;
                Vcell{c,n} = plottingN(n).data.allangles(c).volume;
                Pcell{c,n} = plottingN(n).data.allangles(c).AveP;
                Mcell{c,n} = plottingN(n).data.allangles(c).mass;
                SAcell{c,n} = plottingN(n).data.allangles(c).SA;
                SAtcell{c,n} = plottingN(n).data.allangles(c).SAt;
                SABcell{c,n} = plottingN(n).data.allangles(c).convHullSA;
                VMcell{c,n} = plottingN(n).data.allangles(c).volMass;
            end
        end
    end
end
% for c = 1:BNumMods
%     for n = 1:size(plottingN,2)
%         if ~isempty(plottingN(n).data)
%             if ~isempty(plottingN(n).data.W(c).Ddata)
%                 Dcell{c,n} = plottingN(n).data.W(c).Ddata.reg.D;
%                 Vcell{c,n} = plottingN(n).data.W(c).volume;
%                 Pcell{c,n} = plottingN(n).data.W(c).AveP;
%                 Mcell{c,n} = plottingN(n).data.W(c).mass;
%                 SAcell{c,n} = plottingN(n).data.W(c).SA;
%                 SAtcell{c,n} = plottingN(n).data.W(c).SAt;
%                 SABcell{c,n} = plottingN(n).data.W(c).convHullSA;
%                 VMcell{c,n} = plottingN(n).data.W(c).volMass;
%             end
%         end
%     end
% end
for n = 1:size(plottingN,2)
    if ~isempty(plottingN(n).data)
        Lcell{1,n} = plottingN(n).TL;
    end
end
IF = ~cellfun(@isempty,Fcell);
ID = ~cellfun(@isempty,Dcell);
IV = ~cellfun(@isempty,Vcell);
IP = ~cellfun(@isempty,Pcell);
IM = ~cellfun(@isempty,Mcell);
ISA = ~cellfun(@isempty,SAcell);
ISAt = ~cellfun(@isempty,SAtcell);
ISAB = ~cellfun(@isempty,SABcell);
IVM = ~cellfun(@isempty,VMcell);
Index = and(IF,ID);
Index = and(Index,IV);
Index = and(Index,IP);
Index = and(Index,IM);
Index = and(Index,ISA);
Index = and(Index,ISAt);
Index = and(Index,ISAB);
Index = and(Index,IVM);
UseIndex = 1;
checknum = sum(Index(UseIndex,:));
for i = 1:BNumMods
    if checknum > sum(Index(i,:))
        checknum = sum(Index(i,:));
        UseIndex = i;
    end
end
BFbyM = cell(1,sum(Index(UseIndex,:)));
BDbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
D = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BVbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
V = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BPbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
P = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
M = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BSAbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SA = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BSAtbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SAt = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BSABbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SAB = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BVMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
VM = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
L = zeros((BNumMods)*sum(Index(UseIndex,:)),1);

count = 0;
BAveNatVol = mean(vertcat(Vcell{5,Index(UseIndex,:)}));
for i = 1:BNumMods
    BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
    BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)})./BAveNatVol;
    BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
    BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
    BSAbyM(i,:) = vertcat(SAcell{i,Index(UseIndex,:)});
    BSAtbyM(i,:) = vertcat(SAtcell{i,Index(UseIndex,:)});
    BSABbyM(i,:) = vertcat(SABcell{i,Index(UseIndex,:)});
    BVMbyM(i,:) = vertcat(VMcell{i,Index(UseIndex,:)});
    BLbyM(i,:) = vertcat(Lcell{1,Index(UseIndex,:)});
    
    jsub = 0;
    if i > 0
        for j = 1:size(plottingN,2)
            if Index(UseIndex,j)
                count = count + 1;
                D(count,1) = BDbyM(i,j-jsub);
                V(count,1) = BVbyM(i,j-jsub);
                P(count,1) = BPbyM(i,j-jsub);
                M(count,1) = BMbyM(i,j-jsub);
                L(count,1) = BLbyM(i,j-jsub);
                SA(count,1) = BSAbyM(i,j-jsub);
                SAt(count,1) = BSAtbyM(i,j-jsub);
                SAB(count,1) = BSABbyM(i,j-jsub);
                VM(count,1) = BVMbyM(i,j-jsub);
            else
                jsub = jsub+1;
            end
        end
    end
end
jsub = 0;
for j = 1:size(plottingN,2)
    if Index(UseIndex,j)
        BFbyM{1,j-jsub} = plottingN(j).name;
    else
        jsub = jsub+1;
    end
end


BPI = cell(NumParts,1);
BPI{1,1} = BDbyM(NatInd,:)<=BPartitions(1);
BPI{NumParts,1} = BDbyM(NatInd,:)>BPartitions(end);
for p = 2:NumParts-1
    BPI{p,1} = BDbyM(NatInd,:)>BPartitions(p-1) & BDbyM(NatInd,:)<=BPartitions(p);
end
Pfit = zeros(NumParts,2);
Dfitrange = cell(NumParts,1);

if NumParts == 4 || NumParts == 6
    figure
end
for p = 1:NumParts
    
% Use this portion for the _W.mat plottingN data
    if p == 1
        binRange = [mean(BDbyM(NatInd,BPI{p}))-4.5*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+4.5*std(BDbyM(1,BPI{p}))];
    elseif p == NumParts
        binRange = [mean(BDbyM(NatInd,BPI{p}))-7.0*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+5.0*std(BDbyM(1,BPI{p}))];
    else
        binRange = [mean(BDbyM(NatInd,BPI{p}))-7.0*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+5.0*std(BDbyM(1,BPI{p}))];
    end
    
% % Use this portion for the _I.mat masterN data
%     if p == 1
%         binRange = [mean(BDbyM(NatInd,BPI{p}))-2.0*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+2.0*std(BDbyM(1,BPI{p}))];
%     elseif p == NumParts
%         binRange = [mean(BDbyM(NatInd,BPI{p}))-5.0*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+1.5*std(BDbyM(1,BPI{p}))];
%     else
%         binRange = [mean(BDbyM(NatInd,BPI{p}))-2.5*std(BDbyM(NatInd,BPI{p})) mean(BDbyM(1,BPI{p}))+2.5*std(BDbyM(1,BPI{p}))];
%     end
    
    Dfitrange{p} = binRange(1)-0.02:(binRange(2)+0.04-binRange(1))/29:binRange(2)+0.02;

    if length(plottingN) == 1
        F = F';
    end
% Use this portion for the _W.mat plottingN data
    [DAve, DDev, PAve, PDev] = BinDatabyD(binRange,Numbins,BDbyM(:,BPI{p}),BPbyM(:,BPI{p})./BSAbyM(:,BPI{p}));
    [~, ~, VAve, VDev] = BinDatabyD(binRange,Numbins,BDbyM(:,BPI{p}),BVbyM(:,BPI{p}));
    Pfit(p,:) = polyfit(BDbyM(:,BPI{p}),BPbyM(:,BPI{p})./BSAbyM(:,BPI{p}),1);
    
    if NumParts == 4
        if p < 3
            ax1 = subplot(2,3,p);
        else
            ax1 = subplot(2,3,p+1);
        end
    elseif NumParts == 6
        if p < 4
            ax1 = subplot(2,4,p);
        else
            ax1 = subplot(2,4,p+1);
        end
    else
        figure
    end
    hold(ax1,'on');
    set(ax1,'FontSize',12);
    if p == 1
        ttl1 = title(strcat("D Partition ",num2str(p)," = [0,",num2str(PartitionStart),']'));
    elseif p == NumParts
        ttl1 = title(strcat("D Partition ",num2str(p)," = (",num2str(PartitionEnd),',\infty)'));
    else
        ttl1 = title(strcat("D Partition ",num2str(p)," = (",num2str(BPartitions(p-1)),',',num2str(BPartitions(p)),']'));
    end
    ttl1.FontSize = 18;
    xlb1 = xlabel('Fractal Dimension (D)');
    xlb1.FontSize = 18;
    ylb1 = ylabel('Potential Connectivity (C)');
    ylb1.FontSize = 18;
    for i = 1:BNumMods
        scatter(ax1,BDbyM(order(i),BPI{p}),BPbyM(order(i),BPI{p})./BSAbyM(order(i),BPI{p}),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    end
    plot(ax1,Dfitrange{p},(Pfit(p,1)*Dfitrange{p})+Pfit(p,2),'k--','LineWidth',2);
    errorbar(ax1,DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
    xlim(plotrangex)
    ylim(plotrangepro)
    hold(ax1,'off');
%     legend(Corder)
%     ax2 = subplot(2,1,2);
%     hold(ax2,'on');
%     xlabel('Fractal Dimension (D)')
%     ylabel('Volume (V)')
%     for i = 1:NumCurvs
%         scatter(ax2,DbyC(order(i),PI{p}),VbyC(order(i),PI{p}),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
%     end
%     errorbar(ax2,DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
%     xlim(plotrangex)
%     hold(ax2,'off');
%     samexaxis('abc','xmt','on','ytac','join','yld',1);
    
end

lgdstr = cell(NumParts,1);
for p = 1:NumParts
    lgdstr{p,1} = ['Partition ' num2str(p)];
end
if NumParts == 4
    % For 4 partitions
    ax2 = subplot(2,3,[3,6]);
    ttl2 = title('Basal (Original) All Trendlines');
    hold(ax2,'on');
    plot(Dfitrange{1},(Pfit(1,1)*Dfitrange{1})+Pfit(1,2),'Color',[1 0 0],'LineWidth',2);
    plot(Dfitrange{2},(Pfit(2,1)*Dfitrange{2})+Pfit(2,2),'Color',[1 0.9 0],'LineWidth',2);
    plot(Dfitrange{3},(Pfit(3,1)*Dfitrange{3})+Pfit(3,2),'Color',[0 1 0],'LineWidth',2);
    plot(Dfitrange{4},(Pfit(4,1)*Dfitrange{4})+Pfit(4,2),'Color',[0 0 1],'LineWidth',2);
elseif NumParts == 6
    % For 6 partitions
    ax2 = subplot(2,4,[4,8]);
    ttl2 = title('Basal (Original) All Trendlines');
    hold(ax2,'on');
    plot(Dfitrange{1},(Pfit(1,1)*Dfitrange{1})+Pfit(1,2),'Color',[1 0 0]);
    plot(Dfitrange{2},(Pfit(2,1)*Dfitrange{2})+Pfit(2,2),'Color',[1 0.55 0]);
    plot(Dfitrange{3},(Pfit(3,1)*Dfitrange{3})+Pfit(3,2),'Color',[1 0.9 0]);
    plot(Dfitrange{4},(Pfit(4,1)*Dfitrange{4})+Pfit(4,2),'Color',[0 1 0]);
    plot(Dfitrange{5},(Pfit(5,1)*Dfitrange{5})+Pfit(5,2),'Color',[0 0 1]);
    plot(Dfitrange{6},(Pfit(6,1)*Dfitrange{6})+Pfit(6,2),'Color',[0.29 0 0.51]);
end
ttl2.FontSize = 18;
xlb2 = xlabel('Fractal Dimension (D)');
xlb2.FontSize = 18;
ylb2 = ylabel('Potential Connectivity (C)');
ylb2.FontSize = 18;
legend(lgdstr,'Location','northeast','FontSize',16);