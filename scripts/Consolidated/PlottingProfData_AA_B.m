% load('K:\Keck\Programs\Consolidated\plottingN.mat');
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
order = [2,3,4,5,6,7,8,9];
Corder = ["025" "050" "075" "100" "125" "150" "175" "200"];
ShowBoxPlots = 0;
ShowSANormPlots = 1;
ClearVarsAtEnd = 1;
PlotFont = 16;
BoxPlotFont = 14;
LabelFont = 22;
TitleFont = 26;

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
D = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BVbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
V = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BPbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
P = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
M = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BSAbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SA = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BSAtbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SAt = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BSABbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SAB = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BVMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
VM = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
L = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);

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
    if i > 1
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

%%
plotrangex = [1.33 1.75];
plotrangepro = [0.37 4.51];
plotrangevol = [0.2 11];
% The following plots Potential Connectivity (C) vs Fractal Dimension
% (D) as well as Volume (V) vs D using data from all the different
% modifications
binRange = [1.32 1.72];
Numbins = 9;
% fit1end = 4;
[DAve, DDev, PAve, PDev] = BinDatabyD(binRange,Numbins,D,P./M);
[~, ~, RPAve, RPDev] = BinDatabyD(binRange,Numbins,D,P);
[~, ~, VAve, VDev] = BinDatabyD(binRange,Numbins,D,1./V);
[~, ~, MAve, MDev] = BinDatabyD(binRange,Numbins,D,M);
% Pfit1 = polyfit(DAve(1:1:fit1end),PAve(1:1:fit1end),1);
% Pfit2 = polyfit(DAve(fit1end+1:1:Numbins),PAve(fit1end+1:1:Numbins),1);
% Drange1 = 1.35:0.01:1.47;
% Drange2 = 1.44:0.01:1.65;
figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
subplot(2,1,1)
ax1P = gca;
ax1P.FontSize = PlotFont;
hold(ax1P,'on');
ttl1 = title('Basal (All Angles)');
ttl1.FontSize = TitleFont;
% plot(Drange1,(Pfit1(1)*Drange1)+Pfit1(2),'k--','LineWidth',2);
% plot(Drange2,(Pfit2(1)*Drange2)+Pfit2(2),'k--','LineWidth',2);
xlb1P = xlabel('Fractal Dimension (D)');
ylb1P = ylabel('Potential Connectivity (C)');
set(ylb1P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
xlim(plotrangex)
% ylim(plotrangepro)
errorbar(DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
subplot(2,1,2)
errorbar(DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
ax1V = gca;
ax1V.FontSize = PlotFont;
xlb1V = xlabel('Fractal Dimension (D)');
ylb1V = ylabel('Volume^-^1 (1/V)');
set(ylb1V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
xlim(plotrangex)
ylim(plotrangevol)
hold(ax1P,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb1V.FontSize = LabelFont;
ylb1V.FontSize = LabelFont;
ylb1P.FontSize = LabelFont;
%%
% The following creates scatter plots of \sigma vs D and V vs D with the
% different modifications having different colors
figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax2P = subplot(2,1,1);
hold(ax2P,'on');
% set(ax2P,'FontSize',12);
% plot(ax2P,Drange1,(Pfit1(1)*Drange1)+Pfit1(2),'k--','LineWidth',2);
% plot(ax2P,Drange2,(Pfit2(1)*Drange2)+Pfit2(2),'k--','LineWidth',2);
xlb2P = xlabel('Fractal Dimension (D)');
ylb2P = ylabel('Potential Connectivity (C)');
set(ylb2P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax2P.FontSize = PlotFont;
ttl2 = title('Basal (All Angles)');
ttl2.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax2P,BDbyM(order(i),:),BPbyM(order(i),:)./BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax2P,DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
% ylim(plotrangepro)
lgd2 = legend(Corder);
lgd2.FontSize = 16;
hold(ax2P,'off');
ax2V = subplot(2,1,2);
hold(ax2V,'on');
xlb2V = xlabel('Fractal Dimension (D)');
ylb2V = ylabel('Volume^-^1 (1/V)');
set(ylb2V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax2V.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax2V,BDbyM(order(i),:),1./BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax2V,DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
xlim(plotrangex)
ylim(plotrangevol)
hold(ax2V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb2V.FontSize = LabelFont;
ylb2V.FontSize = LabelFont;
ylb2P.FontSize = LabelFont;

% The following creates scatter plots of \sigma vs D and V vs D using only
% data from the natural neurons
NatbinRange = [1.33 1.5];
NatNumbins = 5;
[NatDAve, NatDDev, NatPAve, NatPDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BMbyM(5,:));
[~, ~, NatVAve, NatVDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),1./BVbyM(5,:));
figure('Name','3','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax3P = subplot(2,1,1);
hold(ax3P,'on');
% set(ax3P,'FontSize',12);
% Natfit1 = polyfit(NatDAve(1:3),NatPAve(1:3),1);
% Natfit2 = polyfit(NatDAve(3:NatNumbins),NatPAve(3:NatNumbins),1);
% NatDrange1 = 1.35:0.01:1.47;
% NatDrange2 = 1.43:0.01:1.58;
% plot(ax3P,NatDrange1,(Natfit1(1)*NatDrange1)+Natfit1(2),'k--','LineWidth',2);
% plot(ax3P,NatDrange2,(Natfit2(1)*NatDrange2)+Natfit2(2),'k--','LineWidth',2);
xlb3P = xlabel('Fractal Dimension (D)');
ylb3P = ylabel('Potential Connectivity (C)');
set(ylb3P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax3P.FontSize = PlotFont;
ttl3 = title('Basal (Naturals)');
ttl3.FontSize = TitleFont;
scatter(ax3P,BDbyM(5,:),BPbyM(5,:)./BMbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
errorbar(ax3P,NatDAve,NatPAve,NatPDev,NatPDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
% ylim(plotrangepro)
hold(ax3P,'off');
ax3V = subplot(2,1,2);
hold(ax3V,'on');
xlb3V = xlabel('Fractal Dimension (D)');
ylb3V = ylabel('Volume^-^1 (1/V)');
set(ylb3V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax3V.FontSize = PlotFont;
scatter(ax3V,BDbyM(5,:),1./BVbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
errorbar(ax3V,NatDAve,NatVAve,NatVDev,NatVDev,NatDDev,NatDDev,'ks','LineWidth',2)
xlim(plotrangex)
ylim(plotrangevol)
hold(ax3V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb3V.FontSize = LabelFont;
ylb3V.FontSize = LabelFont;
ylb3P.FontSize = LabelFont;

% The following section creates figures showing the raw profile area and
% mass values versus the fractal dimension.
plotrangex = [1.33 1.75];
plotrangepro = [0.47 1.19];
plotrangemass = [0 6];
figure('Name','4','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax4C = subplot(2,3,[1,4]);
hold(ax4C,'on');
xlb4C = xlabel('Fractal Dimension (D)');
ylb4C = ylabel('Connectivity (C)');
% set(ylb4C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4C.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax4C,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangex)
ylim(plotrangepro)
lgd4 = legend(Corder);
lgd4.FontSize = 16;
hold(ax4C,'off');
ax4P = subplot(2,3,2);
hold(ax4P,'on');
xlb4P = xlabel('Fractal Dimension (D)');
ylb4P = ylabel('Average Profile Area');
% set(ylb4P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4P.FontSize = PlotFont;
ttl4 = title('Basal (All Angles)');
ttl4.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax4P,BDbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangex)
hold(ax4P,'off');
ax4M = subplot(2,3,3);
hold(ax4M,'on');
xlb4M = xlabel('Fractal Dimension (D)');
ylb4M = ylabel('Mass (M)');
% set(ylb4M, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4M.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax4M,BDbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangex)
hold(ax4M,'off');
ax4L = subplot(2,3,5);
hold(ax4L,'on');
xlb4L = xlabel('Fractal Dimension (D)');
ylb4L = ylabel('Length (L)');
% set(ylb4L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4L.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax4L,BDbyM(order(i),:),BLbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangex)
hold(ax4L,'off');
ax4V = subplot(2,3,6);
hold(ax4V,'on');
xlb4V = xlabel('Fractal Dimension (D)');
ylb4V = ylabel('Volume^-^1 (1/V)');
% set(ylb4V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4V.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax4V,BDbyM(order(i),:),1./BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangex)
hold(ax4V,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb4C.FontSize = LabelFont;
xlb4P.FontSize = LabelFont;
xlb4M.FontSize = LabelFont;
xlb4L.FontSize = LabelFont;
xlb4V.FontSize = LabelFont;
ylb4C.FontSize = LabelFont;
ylb4P.FontSize = LabelFont;
ylb4M.FontSize = LabelFont;
ylb4L.FontSize = LabelFont;
ylb4V.FontSize = LabelFont;
% This figure only shows the natural neurons
figure('Name','7','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax7C = subplot(2,3,[1,4]);
hold(ax7C,'on');
xlb7C = xlabel('Fractal Dimension (D)');
ylb7C = ylabel('Connectivity (C)');
% set(ylb7C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7C.FontSize = PlotFont;
scatter(ax7C,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
ylim(plotrangepro)
hold(ax7C,'off');
ax7P = subplot(2,3,2);
hold(ax7P,'on');
xlb7P = xlabel('Fractal Dimension (D)');
ylb7P = ylabel('Average Profile Area');
% set(ylb7P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7P.FontSize = PlotFont;
ttl7 = title('Basal (All Angles)');
ttl7.FontSize = TitleFont;
scatter(ax7P,BDbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7P,'off');
ax7M = subplot(2,3,3);
hold(ax7M,'on');
xlb7M = xlabel('Fractal Dimension (D)');
ylb7M = ylabel('Mass (M)');
% set(ylb7M, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7M.FontSize = PlotFont;
scatter(ax7M,BDbyM(5,:),BMbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7M,'off');
ax7L = subplot(2,3,5);
hold(ax7L,'on');
xlb7L = xlabel('Fractal Dimension (D)');
ylb7L = ylabel('Length (L)');
% set(ylb7L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7L.FontSize = PlotFont;
scatter(ax7L,BDbyM(5,:),BLbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7L,'off');
ax7V = subplot(2,3,6);
hold(ax7V,'on');
xlb7V = xlabel('Fractal Dimension (D)');
ylb7V = ylabel('Volume^-^1 (V)');
% set(ylb7V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7V.FontSize = PlotFont;
scatter(ax7V,BDbyM(5,:),1./BVbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7V,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb7C.FontSize = LabelFont;
xlb7P.FontSize = LabelFont;
xlb7M.FontSize = LabelFont;
xlb7L.FontSize = LabelFont;
xlb7V.FontSize = LabelFont;
ylb7C.FontSize = LabelFont;
ylb7P.FontSize = LabelFont;
ylb7M.FontSize = LabelFont;
ylb7L.FontSize = LabelFont;
ylb7V.FontSize = LabelFont;

% The following section creates figures showing the connectivity, raw
% profile area, total length, fractal dimension and volume versus mass.
figure('Name','5','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax5C = subplot(2,3,[1,4]);
hold(ax5C,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb5C = xlabel('Mass (M)');
ylb5C = ylabel('Connectivity (C)');
% set(ylb5C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5C.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax5C,BMbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
ylim(plotrangepro)
lgd5 = legend(Corder);
lgd5.FontSize = 16;
hold(ax5C,'off');
ax5P = subplot(2,3,2);
hold(ax5P,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb5P = xlabel('Mass (M)');
ylb5P = ylabel('Average Profile Area');
% set(ylb5P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5P.FontSize = PlotFont;
ttl5 = title('Basal (All Angles)');
ttl5.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax5P,BMbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
hold(ax5P,'off');
ax5V = subplot(2,3,3);
hold(ax5V,'on');
xlb5V = xlabel('Mass (M)');
ylb5V = ylabel('Volume^-^1 (1/V)');
% set(ylb5V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5V.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax5V,BMbyM(order(i),:),1./BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
hold(ax5V,'off');
ax5D = subplot(2,3,5);
hold(ax5D,'on');
xlb5D = xlabel('Mass (M)');
ylb5D = ylabel('Fractal Dimension (D)');
% set(ylb5D, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5D.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax5D,BMbyM(order(i),:),BDbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
hold(ax5D,'off');
ax5L = subplot(2,3,6);
hold(ax5L,'on');
xlb5L = xlabel('Mass (M)');
ylb5L = ylabel('Length (L)');
% set(ylb5L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5L.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax5L,BMbyM(order(i),:),BLbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
hold(ax5L,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb5C.FontSize = LabelFont;
xlb5P.FontSize = LabelFont;
xlb5V.FontSize = LabelFont;
xlb5D.FontSize = LabelFont;
xlb5L.FontSize = LabelFont;
ylb5C.FontSize = LabelFont;
ylb5P.FontSize = LabelFont;
ylb5V.FontSize = LabelFont;
ylb5D.FontSize = LabelFont;
ylb5L.FontSize = LabelFont;
% This figure only shows the natural neurons
figure('Name','6','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax6C = subplot(2,3,[1,4]);
hold(ax6C,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb6C = xlabel('Mass (M)');
ylb6C = ylabel('Connectivity (C)');
% set(ylb6C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax6C.FontSize = PlotFont;
scatter(ax6C,BMbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeM)
ylim(plotrangepro)
hold(ax6C,'off');
ax6P = subplot(2,3,2);
hold(ax6P,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb6P = xlabel('Mass (M)');
ylb6P = ylabel('Average Profile Area');
% set(ylb6P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax6P.FontSize = PlotFont;
ttl6 = title('Basal (All Angles)');
ttl6.FontSize = TitleFont;
scatter(ax6P,BMbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeM)
hold(ax6P,'off');
ax6V = subplot(2,3,3);
hold(ax6V,'on');
xlb6V = xlabel('Mass (M)');
ylb6V = ylabel('Volume^-^1 (1/V)');
% set(ylb6V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax6V.FontSize = PlotFont;
scatter(ax6V,BMbyM(5,:),1./BVbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeM)
hold(ax6V,'off');
ax6D = subplot(2,3,5);
hold(ax6D,'on');
xlb6D = xlabel('Mass (M)');
ylb6D = ylabel('Fractal Dimension (D)');
% set(ylb6D, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax6D.FontSize = PlotFont;
scatter(ax6D,BMbyM(5,:),BDbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeM)
hold(ax6D,'off');
ax6L = subplot(2,3,6);
hold(ax6L,'on');
xlb6L = xlabel('Mass (M)');
ylb6L = ylabel('Length (L)');
% set(ylb6L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax6L.FontSize = PlotFont;
scatter(ax6L,BMbyM(5,:),BLbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeM)
hold(ax6L,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb6C.FontSize = LabelFont;
xlb6P.FontSize = LabelFont;
xlb6V.FontSize = LabelFont;
xlb6D.FontSize = LabelFont;
xlb6L.FontSize = LabelFont;
ylb6C.FontSize = LabelFont;
ylb6P.FontSize = LabelFont;
ylb6V.FontSize = LabelFont;
ylb6D.FontSize = LabelFont;
ylb6L.FontSize = LabelFont;

% The following section creates plots of Average Profile Area, Volume, and
% Mass versus the total length of the neuron
figure('Name','9','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax9C = subplot(2,3,[1,4]);
hold(ax9C,'on');
plotrangeL = [min(min(BLbyM))-100 max(max(BLbyM))+100];
xlb9C = xlabel('Length (L)');
ylb9C = ylabel('Connectivity (C)');
% set(ylb9C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9C.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax9C,BLbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeL)
ylim(plotrangepro)
lgd9 = legend(Corder);
lgd9.FontSize = 16;
hold(ax9C,'off');
ax9P = subplot(2,3,2);
hold(ax9P,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb9P = xlabel('Length (L)');
ylb9P = ylabel('Average Profile Area');
% set(ylb9P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9P.FontSize = PlotFont;
ttl9 = title('Basal (All Angles)');
ttl9.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax9P,BLbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeL)
hold(ax9P,'off');
ax9V = subplot(2,3,3);
hold(ax9V,'on');
xlb9V = xlabel('Length (L)');
ylb9V = ylabel('Volume^-^1 (1/V)');
% set(ylb9V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9V.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax9V,BLbyM(order(i),:),1./BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeL)
hold(ax9V,'off');
ax9D = subplot(2,3,5);
hold(ax9D,'on');
xlb9D = xlabel('Length (L)');
ylb9D = ylabel('Fractal Dimension (D)');
% set(ylb9D, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9D.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax9D,BLbyM(order(i),:),BDbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeL)
hold(ax9D,'off');
ax9L = subplot(2,3,6);
hold(ax9L,'on');
xlb9L = xlabel('Length (L)');
ylb9L = ylabel('Mass (M)');
% set(ylb9L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9L.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax9L,BLbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeL)
hold(ax9L,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb9C.FontSize = LabelFont;
xlb9P.FontSize = LabelFont;
xlb9V.FontSize = LabelFont;
xlb9D.FontSize = LabelFont;
xlb9L.FontSize = LabelFont;
ylb9C.FontSize = LabelFont;
ylb9P.FontSize = LabelFont;
ylb9V.FontSize = LabelFont;
ylb9D.FontSize = LabelFont;
ylb9L.FontSize = LabelFont;
% This figure only shows the natural neurons
figure('Name','8','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax8C = subplot(2,3,[1,4]);
hold(ax8C,'on');
plotrangeL = [min(min(BLbyM))-100 max(max(BLbyM))+100];
xlb8C = xlabel('Length (L)');
ylb8C = ylabel('Connectivity (C)');
% set(ylb8C, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax8C.FontSize = PlotFont;
scatter(ax8C,BLbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeL)
ylim(plotrangepro)
hold(ax8C,'off');
ax8P = subplot(2,3,2);
hold(ax8P,'on');
plotrangeL = [min(min(BLbyM))-100 max(max(BLbyM))+100];
xlb8P = xlabel('Length (L)');
ylb8P = ylabel('Average Profile Area');
% set(ylb8P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax8P.FontSize = PlotFont;
ttl8 = title('Basal (All Angles)');
ttl8.FontSize = TitleFont;
scatter(ax8P,BLbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeL)
hold(ax8P,'off');
ax8V = subplot(2,3,3);
hold(ax8V,'on');
xlb8V = xlabel('Length (L)');
ylb8V = ylabel('Volume^-^1 (1/V)');
% set(ylb8V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax8V.FontSize = PlotFont;
scatter(ax8V,BLbyM(5,:),1./BVbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeL)
hold(ax8V,'off');
ax8D = subplot(2,3,5);
hold(ax8D,'on');
xlb8D = xlabel('Length (L)');
ylb8D = ylabel('Fractal Dimension (D)');
% set(ylb8D, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax8D.FontSize = PlotFont;
scatter(ax8D,BLbyM(5,:),BDbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeL)
hold(ax8D,'off');
ax8L = subplot(2,3,6);
hold(ax8L,'on');
xlb8L = xlabel('Length (L)');
ylb8L = ylabel('Mass (M)');
% set(ylb8L, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax8L.FontSize = PlotFont;
scatter(ax8L,BLbyM(5,:),BMbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangeL)
hold(ax8L,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb8C.FontSize = LabelFont;
xlb8P.FontSize = LabelFont;
xlb8V.FontSize = LabelFont;
xlb8D.FontSize = LabelFont;
xlb8L.FontSize = LabelFont;
ylb8C.FontSize = LabelFont;
ylb8P.FontSize = LabelFont;
ylb8V.FontSize = LabelFont;
ylb8D.FontSize = LabelFont;
ylb8L.FontSize = LabelFont;
% figure('Name','9','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% ax9P = subplot(3,1,1);
% hold(ax9P,'on');
% xlb9P = xlabel('Total Length (L_T)');
% ylb9P = ylabel('Average Profile Area');
% set(ylb9P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax9P.FontSize = PlotFont;
% ttl9 = title('Basal (All Angles)');
% ttl9.FontSize = TitleFont;
% for i = 1:BNumMods-1
%     scatter(ax9P,BLbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end
% hold(ax9P,'off');
% ax9V = subplot(3,1,2);
% hold(ax9V,'on');
% xlb9V = xlabel('Total Length (L_T)');
% ylb9V = ylabel('Volume (V)');
% set(ylb9V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax9V.FontSize = PlotFont;
% for i = 1:BNumMods-1
%     scatter(ax9V,BLbyM(order(i),:),BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end
% hold(ax9V,'off');
% ax9M = subplot(3,1,3);
% hold(ax9M,'on');
% xlb9M = xlabel('Total Length (L_T)');
% ylb9M = ylabel('Mass (M)');
% set(ylb9M, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax9M.FontSize = PlotFont;
% for i = 1:BNumMods-1
%     scatter(ax9M,BLbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end
% hold(ax9M,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
% xlb9M.FontSize = LabelFont;
% ylb9V.FontSize = LabelFont;
% ylb9P.FontSize = LabelFont;
% ylb9M.FontSize = LabelFont;
% % This figure only shows the natural neurons
% figure('Name','8','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% ax8P = subplot(3,1,1);
% hold(ax8P,'on');
% xlb8P = xlabel('Total Length (L_T)');
% ylb8P = ylabel('Average Profile Area');
% set(ylb8P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax8P.FontSize = PlotFont;
% ttl8 = title('Basal (Naturals)');
% ttl8.FontSize = TitleFont;
% scatter(ax8P,BLbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
% hold(ax8P,'off');
% ax8V = subplot(3,1,2);
% hold(ax8V,'on');
% xlb8V = xlabel('Total Length (L_T)');
% ylb8V = ylabel('Volume (V)');
% set(ylb8V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax8V.FontSize = PlotFont;
% scatter(ax8V,BLbyM(5,:),BVbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
% hold(ax8V,'off');
% ax8M = subplot(3,1,3);
% hold(ax8M,'on');
% xlb8M = xlabel('Total Length (L_T)');
% ylb8M = ylabel('Mass (M)');
% set(ylb8M, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax8M.FontSize = PlotFont;
% scatter(ax8M,BLbyM(5,:),BMbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
% hold(ax8M,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
% xlb8M.FontSize = LabelFont;
% ylb8V.FontSize = LabelFont;
% ylb8P.FontSize = LabelFont;
% ylb8M.FontSize = LabelFont;

% The following section shows plots for SA/V, C/SA, C/V, and (V-VM)/V
% versus fractal dimension
plotrangeSoBV = [0 2.1].*10^-3;
plotrangeCoS = [0.47 1.19];
plotrangeCoBV = [0.8 11].*10^-4;
plotrangeVF = [0.9993 1];
[~, ~, SoBVAve, SoBVDev] = BinDatabyD(binRange,Numbins,D,SA./(V.*BAveNatVol));
[~, ~, CoSAve, CoSDev] = BinDatabyD(binRange,Numbins,D,P./SA);
[~, ~, CoBVAve, CoBVDev] = BinDatabyD(binRange,Numbins,D,P./(V.*BAveNatVol));
[~, ~, VFAve, VFDev] = BinDatabyD(binRange,Numbins,D,((V.*BAveNatVol)-VM)./(V.*BAveNatVol));
figure('Name','16','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax16SoBV = subplot(2,2,1);
hold(ax16SoBV,'on');
xlb16SoBV = xlabel('Fractal Dimension (D)');
ylb16SoBV = ylabel('SA/V_B');
% set(ylb16SoBV, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax16SoBV.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax16SoBV,BDbyM(order(i),:),BSAbyM(order(i),:)./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax16SoBV,DAve,SoBVAve,SoBVDev,SoBVDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeSoBV)
lg16SoBV = legend(Corder);
lgd16SoBV.FontSize = 16;
hold(ax16SoBV,'off');
ax16CoS = subplot(2,2,2);
hold(ax16CoS,'on');
xlb16CoS = xlabel('Fractal Dimension (D)');
ylb16CoS = ylabel('Connectivity (C)');
% set(ylb, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax16CoS.FontSize = PlotFont;
% ttl16CoS = title('Basal (All Angles)');
% ttl16CoS.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax16CoS,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax16CoS,DAve,CoSAve,CoSDev,CoSDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoS)
hold(ax16CoS,'off');
ax16CoBV = subplot(2,2,3);
hold(ax16CoBV,'on');
xlb16CoBV = xlabel('Fractal Dimension (D)');
ylb16CoBV = ylabel('Profile/V_B');
% set(ylb16CoBV, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax16CoBV.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax16CoBV,BDbyM(order(i),:),BPbyM(order(i),:)./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax16CoBV,DAve,CoBVAve,CoBVDev,CoBVDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoBV)
hold(ax16CoBV,'off');
ax16VF = subplot(2,2,4);
hold(ax16VF,'on');
xlb16VF = xlabel('Fractal Dimension (D)');
ylb16VF = ylabel('(V_B-V_M)/V_B');
% set(ylb16VF, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax16VF.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax16VF,BDbyM(order(i),:),((BVbyM(order(i),:).*BAveNatVol)-BVMbyM(order(i),:))./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax16VF,DAve,VFAve,VFDev,VFDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeVF)
hold(ax16VF,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb16SoBV.FontSize = LabelFont;
xlb16CoS.FontSize = LabelFont;
xlb16CoBV.FontSize = LabelFont;
xlb16VF.FontSize = LabelFont;
ylb16SoBV.FontSize = LabelFont;
ylb16CoS.FontSize = LabelFont;
ylb16CoBV.FontSize = LabelFont;
ylb16VF.FontSize = LabelFont;

[~, ~, NatSoBVAve, NatSoBVDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BSAbyM(5,:)./(BVbyM(5,:).*BAveNatVol));
[~, ~, NatCoSAve, NatCoSDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:));
[~, ~, NatCoBVAve, NatCoBVDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./(BVbyM(5,:).*BAveNatVol));
[~, ~, NatVFAve, NatVFDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),((BVbyM(5,:).*BAveNatVol)-BVMbyM(5,:))./(BVbyM(5,:).*BAveNatVol));
figure('Name','17','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax17SoBV = subplot(2,2,1);
hold(ax17SoBV,'on');
xlb17SoBV = xlabel('Fractal Dimension (D)');
ylb17SoBV = ylabel('SA/V_B');
% set(ylb17SoBV, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax17SoBV.FontSize = PlotFont;
for i = 4
    scatter(ax17SoBV,BDbyM(order(i),:),BSAbyM(order(i),:)./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax17SoBV,NatDAve,NatSoBVAve,NatSoBVDev,NatSoBVDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeSoBV)
hold(ax17SoBV,'off');
ax17CoS = subplot(2,2,2);
hold(ax17CoS,'on');
xlb17CoS = xlabel('Fractal Dimension (D)');
ylb17CoS = ylabel('Connectivity (C)');
% set(ylb, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax17CoS.FontSize = PlotFont;
% ttl17CoS = title('Basal (All Angles)');
% ttl17CoS.FontSize = TitleFont;
for i = 4
    scatter(ax17CoS,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax17CoS,NatDAve,NatCoSAve,NatCoSDev,NatCoSDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoS)
hold(ax17CoS,'off');
ax17CoBV = subplot(2,2,3);
hold(ax17CoBV,'on');
xlb17CoBV = xlabel('Fractal Dimension (D)');
ylb17CoBV = ylabel('Profile/V_B');
% set(ylb17CoBV, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax17CoBV.FontSize = PlotFont;
for i = 4
    scatter(ax17CoBV,BDbyM(order(i),:),BPbyM(order(i),:)./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax17CoBV,NatDAve,NatCoBVAve,NatCoBVDev,NatCoBVDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoBV)
hold(ax17CoBV,'off');
ax17VF = subplot(2,2,4);
hold(ax17VF,'on');
xlb17VF = xlabel('Fractal Dimension (D)');
ylb17VF = ylabel('(V_B-V_M)/V_B');
% set(ylb17VF, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax17VF.FontSize = PlotFont;
for i = 4
    scatter(ax17VF,BDbyM(order(i),:),((BVbyM(order(i),:).*BAveNatVol)-BVMbyM(order(i),:))./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax17VF,NatDAve,NatVFAve,NatVFDev,NatVFDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeVF)
hold(ax17VF,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb17SoBV.FontSize = LabelFont;
xlb17CoS.FontSize = LabelFont;
xlb17CoBV.FontSize = LabelFont;
xlb17VF.FontSize = LabelFont;
ylb17SoBV.FontSize = LabelFont;
ylb17CoS.FontSize = LabelFont;
ylb17CoBV.FontSize = LabelFont;
ylb17VF.FontSize = LabelFont;

plotrangeSoBA = [0.04 0.43];
plotrangeCoBA = [0.0455 0.204];
[~, ~, SoBAAve, SoBADev] = BinDatabyD(binRange,Numbins,D,SA./SAB);
[~, ~, CoSAve, CoSDev] = BinDatabyD(binRange,Numbins,D,P./SA);
[~, ~, CoBAAve, CoBADev] = BinDatabyD(binRange,Numbins,D,P./SAB);
[~, ~, VFAve, VFDev] = BinDatabyD(binRange,Numbins,D,((V.*BAveNatVol)-VM)./(V.*BAveNatVol));
figure('Name','18','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax18SoBA = subplot(2,2,1);
hold(ax18SoBA,'on');
xlb18SoBA = xlabel('Fractal Dimension (D)');
ylb18SoBA = ylabel('SA/SA_B');
% set(ylb18SoBA, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax18SoBA.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax18SoBA,BDbyM(order(i),:),BSAbyM(order(i),:)./BSABbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax18SoBA,DAve,SoBAAve,SoBADev,SoBADev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeSoBA)
lg18SoBA = legend(Corder);
lgd18SoBA.FontSize = 16;
hold(ax18SoBA,'off');
ax18CoS = subplot(2,2,2);
hold(ax18CoS,'on');
xlb18CoS = xlabel('Fractal Dimension (D)');
ylb18CoS = ylabel('Connectivity (C)');
% set(ylb, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax18CoS.FontSize = PlotFont;
% ttl18CoS = title('Basal (All Angles)');
% ttl18CoS.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax18CoS,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax18CoS,DAve,CoSAve,CoSDev,CoSDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoS)
hold(ax18CoS,'off');
ax18CoBA = subplot(2,2,3);
hold(ax18CoBA,'on');
xlb18CoBA = xlabel('Fractal Dimension (D)');
ylb18CoBA = ylabel('Profile/SA_B');
% set(ylb18CoBA, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax18CoBA.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax18CoBA,BDbyM(order(i),:),BPbyM(order(i),:)./BSABbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax18CoBA,DAve,CoBAAve,CoBADev,CoBADev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoBA)
hold(ax18CoBA,'off');
ax18VF = subplot(2,2,4);
hold(ax18VF,'on');
xlb18VF = xlabel('Fractal Dimension (D)');
ylb18VF = ylabel('(V_B-V_M)/V_B');
% set(ylb18VF, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax18VF.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax18VF,BDbyM(order(i),:),((BVbyM(order(i),:).*BAveNatVol)-BVMbyM(order(i),:))./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax18VF,DAve,VFAve,VFDev,VFDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeVF)
hold(ax18VF,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb18SoBA.FontSize = LabelFont;
xlb18CoS.FontSize = LabelFont;
xlb18CoBA.FontSize = LabelFont;
xlb18VF.FontSize = LabelFont;
ylb18SoBA.FontSize = LabelFont;
ylb18CoS.FontSize = LabelFont;
ylb18CoBA.FontSize = LabelFont;
ylb18VF.FontSize = LabelFont;

[~, ~, NatSoBAAve, NatSoBADev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BSAbyM(5,:)./BSABbyM(5,:));
[~, ~, NatCoSAve, NatCoSDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:));
[~, ~, NatCoBAAve, NatCoBADev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSABbyM(5,:));
[~, ~, NatVFAve, NatVFDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),(BVbyM(5,:).*BAveNatVol-BVMbyM(5,:))./(BVbyM(5,:).*BAveNatVol));
figure('Name','19','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax19SoBA = subplot(2,2,1);
hold(ax19SoBA,'on');
xlb19SoBA = xlabel('Fractal Dimension (D)');
ylb19SoBA = ylabel('SA/SA_B');
% set(ylb19SoBA, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax19SoBA.FontSize = PlotFont;
for i = 4
    scatter(ax19SoBA,BDbyM(order(i),:),BSAbyM(order(i),:)./BSABbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax19SoBA,NatDAve,NatSoBAAve,NatSoBADev,NatSoBADev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeSoBA)
hold(ax19SoBA,'off');
ax19CoS = subplot(2,2,2);
hold(ax19CoS,'on');
xlb19CoS = xlabel('Fractal Dimension (D)');
ylb19CoS = ylabel('Connectivity (C)');
% set(ylb, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax19CoS.FontSize = PlotFont;
% ttl19CoS = title('Basal (All Angles)');
% ttl19CoS.FontSize = TitleFont;
for i = 4
    scatter(ax19CoS,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax19CoS,NatDAve,NatCoSAve,NatCoSDev,NatCoSDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoS)
hold(ax19CoS,'off');
ax19CoBA = subplot(2,2,3);
hold(ax19CoBA,'on');
xlb19CoBA = xlabel('Fractal Dimension (D)');
ylb19CoBA = ylabel('Profile/SA_B');
% set(ylb19CoBA, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax19CoBA.FontSize = PlotFont;
for i = 4
    scatter(ax19CoBA,BDbyM(order(i),:),BPbyM(order(i),:)./BSABbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax19CoBA,NatDAve,NatCoBAAve,NatCoBADev,NatCoBADev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeCoBA)
hold(ax19CoBA,'off');
ax19VF = subplot(2,2,4);
hold(ax19VF,'on');
xlb19VF = xlabel('Fractal Dimension (D)');
ylb19VF = ylabel('(V_B-V_M)/V_B');
% set(ylb19VF, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax19VF.FontSize = PlotFont;
for i = 4
    scatter(ax19VF,BDbyM(order(i),:),((BVbyM(order(i),:).*BAveNatVol)-BVMbyM(order(i),:))./(BVbyM(order(i),:).*BAveNatVol),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax19VF,NatDAve,NatVFAve,NatVFDev,NatVFDev,NatDDev,NatDDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangeVF)
hold(ax19VF,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb19SoBA.FontSize = LabelFont;
xlb19CoS.FontSize = LabelFont;
xlb19CoBA.FontSize = LabelFont;
xlb19VF.FontSize = LabelFont;
ylb19SoBA.FontSize = LabelFont;
ylb19CoS.FontSize = LabelFont;
ylb19CoBA.FontSize = LabelFont;
ylb19VF.FontSize = LabelFont;

if ShowSANormPlots == 1
    binRange = [1.32 1.72];
    Numbins = 9;
    figure('Name','15','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    [SADAve, SADDev, PbySAAve, PbySADev] = BinDatabyD(binRange,Numbins,D,P./SA);
    ax15P = subplot(1,1,1);
    hold(ax15P,'on');
    xlb15P = xlabel('Fractal Dimension (D)');
    ylb15P = ylabel('Potential Connectivity (C)');
    % set(ylb15P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax15P.FontSize = PlotFont;
    ttl15 = title('Norm by SA');
    % ttl15.FontSize = TitleFont;
    for i = 1:BNumMods - 1
        scatter(ax15P,BDbyM(order(i),:),BPbyM(order(i),:)./BSAbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
%         scatter(ax15P,BDbyM(i,:),BPbyM(i,:)./BSAbyM(i,:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    end
%     scatter(ax15P,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    xlim(plotrangex)
    errorbar(ax15P,SADAve,PbySAAve,PbySADev,PbySADev,SADDev,SADDev,'ks','LineWidth',2);
    lgd15 = legend(Corder);
    lgd15.FontSize = 16;
    xlim([min(D)-0.01 max(D)+0.01])
    hold(ax15P,'off');
    xlb15P.FontSize = LabelFont;
    ylb15P.FontSize = LabelFont;
    
% % %     figure('Name','16','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% % %     [~, ~, PbySAtAve, PbySAtDev] = BinDatabyD(binRange,Numbins,D,P./SAt);
% % %     ax16P = subplot(1,1,1);
% % %     hold(ax16P,'on');
% % %     xlb16P = xlabel('Fractal Dimension (D)');
% % %     ylb16P = ylabel('Potential Connectivity (C)');
% % %     % set(ylb16P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% % %     ax16P.FontSize = PlotFont;
% % %     ttl16 = title('Norm by SAt');
% % %     % ttl16.FontSize = TitleFont;
% % %     for i = 1:BNumMods - 1
% % %         scatter(ax16P,BDbyM(order(i),:),BPbyM(order(i),:)./BSAtbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% % % %         scatter(ax16P,BDbyM(i,:),BPbyM(i,:)./BSAbyM(i,:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% % %     end
% % % %     scatter(ax16P,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
% % %     errorbar(ax16P,SADAve,PbySAtAve,PbySAtDev,PbySAtDev,SADDev,SADDev,'ks','LineWidth',2);
% % %     xlim([min(D)-0.01 max(D)+0.01])
% % %     hold(ax16P,'off');

% The following creates scatter plots of C vs D for different normalization
% methods
%     NatbinRange = [1.33 1.5];
%     NatNumbins = 5;
    [NatDAve, NatDDev, NatPAve, NatPDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:));
    [~, ~, NatPSAtAve, NatPSAtDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSAtbyM(5,:));
    figure('Name','14','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax14P = subplot(1,4,1);
    hold(ax14P,'on');
    xlb14P = xlabel('Fractal Dimension (D)');
    ylb14P = ylabel('Potential Connectivity (C)');
    % set(ylb14P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax14P.FontSize = PlotFont;
    ttl14P = title('Norm by SA');
    % ttl14.FontSize = TitleFont;
    scatter(ax14P,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    errorbar(ax14P,NatDAve,NatPAve,NatPDev,NatPDev,NatDDev,NatDDev,'ks','LineWidth',2);
    xlim([min(BDbyM(5,:))-0.01 max(BDbyM(5,:))+0.01])
%     ylim([1.3 1.9])
    hold(ax14P,'off');
    ax14PSAt = subplot(1,4,2);
    hold(ax14PSAt,'on');
    xlb14PSAt = xlabel('Fractal Dimension (D)');
    ylb14PSAt = ylabel('Potential Connectivity (C)');
    % set(ylb14PSAt, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax14PSAt.FontSize = PlotFont;
    ttl14PSAt = title('Norm by SAt');
    % ttl14.FontSize = TitleFont;
    scatter(ax14PSAt,BDbyM(5,:),BPbyM(5,:)./BSAtbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    errorbar(ax14PSAt,NatDAve,NatPSAtAve,NatPSAtDev,NatPSAtDev,NatDDev,NatDDev,'ks','LineWidth',2);
    xlim([min(BDbyM(5,:))-0.01 max(BDbyM(5,:))+0.01])
%     ylim([1.3 1.9])
    hold(ax14PSAt,'off');
    ax14PbyM = subplot(1,4,3);
    hold(ax14PbyM,'on');
    xlb14PbyM = xlabel('Fractal Dimension (D)');
    ylb14PbyM = ylabel('Potential Connectivity (C)');
    ax14PbyM.FontSize = PlotFont;
    ttl14PbyM = title('Norm by Mass');
    % ttl14.FontSize = TitleFont;
    % set(ylb14PbyM, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    [~, ~, NatPbyMAve, NatPbyMDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BMbyM(5,:));
    scatter(ax14PbyM,BDbyM(5,:),BPbyM(5,:)./BMbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    errorbar(ax14PbyM,NatDAve,NatPbyMAve,NatPbyMDev,NatPbyMDev,NatDDev,NatDDev,'ks','LineWidth',2);
    xlim([min(BDbyM(5,:))-0.01 max(BDbyM(5,:))+0.01])
    hold(ax14PbyM,'off');
    ax14PNat = subplot(1,4,4);
    hold(ax14PNat,'on');
    xlb14PNat = xlabel('Fractal Dimension (D)');
    ylb14PNat = ylabel('Potential Connectivity (C)');
    % set(ylb14PNat, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ttl14PNat = title('No Norm');
    ax14PNat.FontSize = PlotFont;
    [~, ~, NatPNatAve, NatPNatDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:));
    scatter(ax14PNat,BDbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    errorbar(ax14PNat,NatDAve,NatPNatAve,NatPNatDev,NatPNatDev,NatDDev,NatDDev,'ks','LineWidth',2);
    xlim([min(BDbyM(5,:))-0.01 max(BDbyM(5,:))+0.01])
    hold(ax14PNat,'off');
    xlb14P.FontSize = LabelFont;
    xlb14PSAt.FontSize = LabelFont;
    xlb14PNat.FontSize = LabelFont;
    xlb14PbyM.FontSize = LabelFont;
    ylb14P.FontSize = LabelFont;
    ylb14PSAt.FontSize = LabelFont;
    ylb14PNat.FontSize = LabelFont;
    ylb14PbyM.FontSize = LabelFont;
end

binRange = [1.32 1.72];
Numbins = 9;
NatbinRange = [1.33 1.5];
NatNumbins = 5;
if ShowBoxPlots == 1
    figure('Name','10','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax10P = subplot(2,1,1);
    hold(ax10P,'on');
    xlb10P = xlabel('Fractal Dimension Range (D)');
    ylb10P = ylabel('Connectivity (C)');
    set(ylb10P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax10P.FontSize = BoxPlotFont;
    ttl10 = title('Basal (All Angles) Box Plots Norm by M');
    ttl10.FontSize = TitleFont;
    BoxPlotNumbins = 7;
    BinSize = (binRange(2)-binRange(1))/BoxPlotNumbins;
    BinInd = cell(1,BoxPlotNumbins);
    BinnedDs = zeros(BoxPlotNumbins,1);
    DGroups = cell(1,BoxPlotNumbins);
    MaxNumInBin = 0;
    for i = 1:BoxPlotNumbins
        BinnedDs(i,1) = binRange(1) + (i-1/2)*BinSize;
        BinInd{1,i} = D >= BinnedDs(i)-(1/2)*BinSize & D < BinnedDs(i)+(1/2)*BinSize;
        if MaxNumInBin < sum(BinInd{1,i})
            MaxNumInBin = sum(BinInd{1,i});
        end
        DGroups{1,i} = strcat(num2str(round(BinnedDs(i,1)-(1/2)*BinSize,4,'significant')), '-', num2str(round(BinnedDs(i,1)+(1/2)*BinSize,4,'significant')));
    end
    BinnedCVals = NaN(MaxNumInBin,BoxPlotNumbins);
    for i = 1:BoxPlotNumbins
        BinnedCVals(1:sum(BinInd{1,i}),i) = P(BinInd{1,i})./M(BinInd{1,i});
    end
    boxplot(BinnedCVals,DGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
    hold(ax10P,'off');
    ax10V = subplot(2,1,2);
    hold(ax10V,'on');
    xlb10V = xlabel('Fractal Dimension Range (D)');
    ylb10V = ylabel('Volume^-^1 (1/V)');
    set(ylb10V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax10V.FontSize = BoxPlotFont;
    BinnedVVals = NaN(MaxNumInBin,BoxPlotNumbins);
    for i = 1:BoxPlotNumbins
        BinnedVVals(1:sum(BinInd{1,i}),i) = 1./V(BinInd{1,i});
    end
    boxplot(BinnedVVals,DGroups,'Notch','on','Whisker',1.75)%,'Positions',BinnedDs)
    hold(ax10V,'off');
    samexaxis('abc','xmt','on','ytac','join','yld',1);
    xlb10V.FontSize = LabelFont;
    ylb10V.FontSize = LabelFont;
    ylb10P.FontSize = LabelFont;
    
    figure('Name','11','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax11P = subplot(2,1,1);
    hold(ax11P,'on');
    xlb111P = xlabel('Fractal Dimension Range (D)');
    ylb111P = ylabel('Connectivity (C)');
    set(ylb111P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax11P.FontSize = BoxPlotFont;
    ttl11 = title('Basal (Naturals) Box Plots Norm by M');
    ttl11.FontSize = TitleFont;
    NatBinSize = (NatbinRange(2)-NatbinRange(1))/NatNumbins;
    NatBinInd = cell(1,NatNumbins);
    NatBinnedDs = zeros(NatNumbins,1);
    NatDGroups = cell(1,NatNumbins);
    NatMaxNumInBin = 0;
    for i = 1:NatNumbins
        NatBinnedDs(i) = NatbinRange(1) + (i-1/2)*NatBinSize;
        NatBinInd{1,i} = BDbyM(5,:) >= NatBinnedDs(i)-(1/2)*NatBinSize & BDbyM(5,:) < NatBinnedDs(i)+(1/2)*NatBinSize;
        if NatMaxNumInBin < sum(NatBinInd{1,i})
            NatMaxNumInBin = sum(NatBinInd{1,i});
        end
        NatDGroups{1,i} = strcat(num2str(round(NatBinnedDs(i,1)-(1/2)*NatBinSize,4,'significant')), '-', num2str(round(NatBinnedDs(i,1)+(1/2)*NatBinSize,4,'significant')));
    end
    NatBinnedCVals = NaN(NatMaxNumInBin,NatNumbins);
    for i = 1:NatNumbins
        NatBinnedCVals(1:sum(NatBinInd{1,i}),i) = BPbyM(5,NatBinInd{1,i})./BMbyM(5,NatBinInd{1,i});
    end
    boxplot(NatBinnedCVals,NatDGroups,'Notch','on','Whisker',1.75);
    hold(ax11P,'off');
    ax11V = subplot(2,1,2);
    hold(ax11V,'on');
    xlb111V = xlabel('Fractal Dimension Range (D)');
    ylb111V = ylabel('Volume^-^1 (1/V)');
    set(ylb111V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax11V.FontSize = BoxPlotFont;
    NatBinnedVVals = NaN(NatMaxNumInBin,NatNumbins);
    for i = 1:NatNumbins
        NatBinnedVVals(1:sum(NatBinInd{1,i}),i) = 1./V(NatBinInd{1,i});
    end
    boxplot(NatBinnedVVals,NatDGroups,'Notch','on','Whisker',1.75);
    hold(ax11V,'off');
    samexaxis('abc','xmt','on','ytac','join','yld',1);
    xlb111V.FontSize = LabelFont;
    ylb111V.FontSize = LabelFont;
    ylb111P.FontSize = LabelFont;
    
    figure('Name','12','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax12P = subplot(1,1,1);
    hold(ax12P,'on');
    xlb112P = xlabel('Fractal Dimension Range (D)');
    ylb112P = ylabel('Connectivity (C)');
    set(ylb112P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax12P.FontSize = BoxPlotFont;
    ttl12 = title('Basal (All Angles) Box Plots Norm by SA');
    ttl12.FontSize = TitleFont;
    BinnedCbyLVals = NaN(MaxNumInBin,BoxPlotNumbins);
    for i = 1:BoxPlotNumbins
        BinnedCbyLVals(1:sum(BinInd{1,i}),i) = P(BinInd{1,i})./SA(BinInd{1,i});
    end
    boxplot(BinnedCbyLVals,DGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
    hold(ax12P,'off');
%     ax12V = subplot(2,1,2);
%     hold(ax12V,'on');
%     xlb112V = xlabel('Fractal Dimension Range (D)');
%     ylb112V = ylabel('Volume^-^1 (1/V)');
%     set(ylb112V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
%     ax12V.FontSize = BoxPlotFont;
%     boxplot(BinnedVVals,DGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
%     hold(ax12V,'off');
%     samexaxis('abc','xmt','on','ytac','join','yld',1);
%     xlb112V.FontSize = LabelFont;
%     ylb112V.FontSize = LabelFont;
%     ylb112P.FontSize = LabelFont;
    
    figure('Name','13','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax13P = subplot(1,1,1);
    hold(ax13P,'on');
    xlb113P = xlabel('Fractal Dimension Range (D)');
    ylb113P = ylabel('Connectivity (C)');
    set(ylb113P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax13P.FontSize = BoxPlotFont;
    ttl13 = title('Basal (Naturals) Box Plots Norm By SA');
    ttl13.FontSize = TitleFont;
    NatBinnedCbyLVals = NaN(NatMaxNumInBin,NatNumbins);
    for i = 1:NatNumbins
        NatBinnedCbyLVals(1:sum(NatBinInd{1,i}),i) = BPbyM(5,NatBinInd{1,i})./BSAbyM(5,NatBinInd{1,i});
    end
    boxplot(NatBinnedCbyLVals,NatDGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
    hold(ax13P,'off');
%     ax13V = subplot(2,1,2);
%     hold(ax13V,'on');
%     xlb113V = xlabel('Fractal Dimension Range (D)');
%     ylb113V = ylabel('Volume^-^1 (1/V)');
%     set(ylb113V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
%     ax13V.FontSize = BoxPlotFont;
%     boxplot(NatBinnedVVals,NatDGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
%     hold(ax13V,'off');
%     samexaxis('abc','xmt','on','ytac','join','yld',1);
%     xlb113V.FontSize = LabelFont;
%     ylb113V.FontSize = LabelFont;
%     ylb113P.FontSize = LabelFont;
end

clearvars -except plottingN D V P M L SA SAt SAB VM BFbyM BDbyM BVbyM BPbyM BMbyM BLbyM BSAbyM BSAtbyM BSABbyM BVMbyM BNumMods order Corder clr PlotFont BoxPlotFont LabelFont TitleFont