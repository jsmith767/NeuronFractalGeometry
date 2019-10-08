% load('K:\Keck\Programs\Consolidated\plottingN.mat');
ShowBoxPlots = 1;
ShowSANormPlots = 0;
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
Lcell = cell(1,size(plottingN,2));
% SAcell = cell(1,size(plottingN,2));
for c = 1:BNumMods
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.allangles(c).Ddata)
                Dcell{c,n} = plottingN(n).data.allangles(c).Ddata.reg.D;
                Vcell{c,n} = plottingN(n).data.allangles(c).volume;
                Pcell{c,n} = plottingN(n).data.allangles(c).AveP;
                Mcell{c,n} = plottingN(n).data.allangles(c).mass;
            end
        end
    end
end
for n = 1:size(plottingN,2)
    if ~isempty(plottingN(n).data)
        Lcell{1,n} = plottingN(n).TL;
%         SAcell{1,n} = plottingN(n).data.allangles(5).SA;
    end
end
IF = ~cellfun(@isempty,Fcell);
ID = ~cellfun(@isempty,Dcell);
IV = ~cellfun(@isempty,Vcell);
IP = ~cellfun(@isempty,Pcell);
IM = ~cellfun(@isempty,Mcell);
Index = and(IF,ID);
Index = and(Index,IV);
Index = and(Index,IP);
Index = and(Index,IM);
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
BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
L = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);
% BSAbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
% SA = zeros((BNumMods-1)*sum(Index(UseIndex,:)),1);

count = 0;
BAveNatVol = mean(vertcat(Vcell{5,Index(UseIndex,:)}));
for i = 1:BNumMods
    BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
    BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)})./BAveNatVol;
    BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
    BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
    BLbyM(i,:) = vertcat(Lcell{1,Index(UseIndex,:)});
%     BSAbyM(i,:) = vertcat(SAcell{1,Index(UseIndex,:)});
    
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
%                 SA(count,1) = BSAbyM(i,j-jsub);
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

% The following plots Potential Connectivity (C) vs Fractal Dimension
% (D) as well as Volume (V) vs D using data from all the different
% modifications
binRange = [1.32 1.77];
Numbins = 10;
fit1end = 4;
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
xlim([1.3 1.825])
ylim([0.125 0.275])
errorbar(DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
subplot(2,1,2)
errorbar(DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
ax1V = gca;
ax1V.FontSize = PlotFont;
xlb1V = xlabel('Fractal Dimension (D)');
ylb1V = ylabel('Volume^-^1 (1/V)');
set(ylb1V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
xlim([1.3 1.825])
ylim([0 10])
hold(ax1P,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb1V.FontSize = LabelFont;
ylb1V.FontSize = LabelFont;
ylb1P.FontSize = LabelFont;

% The following creates scatter plots of \sigma vs D and V vs D with the
% different modifications having different colors
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120]]/255;
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
clr2 = [[161 30 34]/255;[232 166 49]/255];
order = [2,3,4,5,6,7,8,9];
Corder = ["025" "050" "075" "100" "125" "150" "175" "200"];
plotrangex = [1.3 1.825];
plotrangepro = [0.125 0.275];
plotrangevol = [0 10];
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
ylim(plotrangepro)
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
NatbinRange = [1.35 1.475];
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
ylim(plotrangepro)
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
plotrangex = [1.3 1.825];
figure('Name','4','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax4P = subplot(2,1,1);
hold(ax4P,'on');
xlb4P = xlabel('Fractal Dimension (D)');
ylb4P = ylabel('Average Profile Area');
set(ylb4P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4P.FontSize = PlotFont;
ttl4 = title('Basal (All Angles)');
ttl4.FontSize = TitleFont;
for i = 1:BNumMods-1
    scatter(ax4P,BDbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax4P,DAve,RPAve,RPDev,RPDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
lgd4 = legend(Corder);
lgd4.FontSize = 16;
hold(ax4P,'off');
ax4V = subplot(2,1,2);
hold(ax4V,'on');
xlb4V = xlabel('Fractal Dimension (D)');
ylb4V = ylabel('Mass (M)');
set(ylb4V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4V.FontSize = PlotFont;
for i = 1:BNumMods-1
    scatter(ax4V,BDbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax4V,DAve,MAve,MDev,MDev,DDev,DDev,'ks','LineWidth',2)
xlim(plotrangex)
hold(ax4V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb4V.FontSize = LabelFont;
ylb4V.FontSize = LabelFont;
ylb4P.FontSize = LabelFont;
% This figure only shows the natural neurons
figure('Name','7','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax7P = subplot(2,1,1);
hold(ax7P,'on');
xlb7P = xlabel('Fractal Dimension (D)');
ylb7P = ylabel('Average Profile Area');
set(ylb7P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7P.FontSize = PlotFont;
ttl7 = title('Basal (Naturals)');
ttl7.FontSize = TitleFont;
scatter(ax7P,BDbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7P,'off');
ax7V = subplot(2,1,2);
hold(ax7V,'on');
xlb7V = xlabel('Fractal Dimension (D)');
ylb7V = ylabel('Mass (M)');
set(ylb7V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax7V.FontSize = PlotFont;
scatter(ax7V,BDbyM(5,:),BMbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
xlim(plotrangex)
hold(ax7V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);
xlb7V.FontSize = LabelFont;
ylb7V.FontSize = LabelFont;
ylb7P.FontSize = LabelFont;

% % The following section creates figures showing the raw profile area and
% % volume versus mass.
% figure('Name','5','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% ax5P = subplot(2,1,1);
% hold(ax5P,'on');
% plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
% xlb5P = xlabel('Mass (M)');
% ylb5P = ylabel('Average Profile Area');
% set(ylb5P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax5P.FontSize = PlotFont;
% ttl5 = title('Basal (All Angles)');
% ttl5.FontSize = TitleFont;
% for i = 1:BNumMods-1
%     scatter(ax5P,BMbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end
% xlim(plotrangeM)
% lgd5 = legend(Corder);
% lgd5.FontSize = 16;
% hold(ax5P,'off');
% ax5V = subplot(2,1,2);
% hold(ax5V,'on');
% xlb5V = xlabel('Mass (M)');
% ylb5V = ylabel('Volume (V)');
% set(ylb5V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax5V.FontSize = PlotFont;
% for i = 1:BNumMods-1
%     scatter(ax5V,BMbyM(order(i),:),BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end
% xlim(plotrangeM)
% hold(ax5V,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
% xlb5V.FontSize = LabelFont;
% ylb5V.FontSize = LabelFont;
% ylb5P.FontSize = LabelFont;
% % This figure only shows the natural neurons
% figure('Name','6','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% ax6P = subplot(2,1,1);
% hold(ax6P,'on');
% xlb6P = xlabel('Mass (M)');
% ylb6P = ylabel('Average Profile Area');
% set(ylb6P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax6P.FontSize = PlotFont;
% ttl6 = title('Basal (Naturals)');
% ttl6.FontSize = TitleFont;
% scatter(ax6P,BMbyM(5,:),BPbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
% xlim(plotrangeM)
% hold(ax6P,'off');
% ax6V = subplot(2,1,2);
% hold(ax6V,'on');
% xlb6V = xlabel('Mass (M)');
% ylb6V = ylabel('Volume (V)');
% set(ylb6V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
% ax6V.FontSize = PlotFont;
% scatter(ax6V,BMbyM(5,:),BVbyM(5,:),'.','MarkerFaceColor', clr(4,:), 'MarkerEdgeColor', clr(4,:))
% xlim(plotrangeM)
% hold(ax6V,'off');
% samexaxis('abc','xmt','on','ytac','join','yld',1);
% xlb6V.FontSize = LabelFont;
% ylb6V.FontSize = LabelFont;
% ylb6P.FontSize = LabelFont;
% 
% % The following section creates plots of Average Profile Area, Volume, and
% % Mass versus the total length of the neuron
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

% The following creates scatter plots of C vs D for only the natural
% neurons where connectivity is normalized by surface area.
if ShowSANormPlots == 1
    NatbinRange = [1.33 1.5];
    NatNumbins = 5;
    [NatDAve, NatDDev, NatPAve, NatPDev] = BinDatabyD(NatbinRange,NatNumbins,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:));
    figure('Name','14','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax14P = subplot(1,3,1);
    hold(ax14P,'on');
    xlb14P = xlabel('Fractal Dimension (D)');
    ylb14P = ylabel('Potential Connectivity (C)');
    % set(ylb14P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax14P.FontSize = PlotFont;
    ttl14 = title('Norm by SA');
    % ttl14.FontSize = TitleFont;
    scatter(ax14P,BDbyM(5,:),BPbyM(5,:)./BSAbyM(5,:),'.','MarkerFaceColor',clr(4,:),'MarkerEdgeColor',clr(4,:))
    errorbar(ax14P,NatDAve,NatPAve,NatPDev,NatPDev,NatDDev,NatDDev,'ks','LineWidth',2);
    xlim([min(BDbyM(5,:))-0.01 max(BDbyM(5,:))+0.01])
    hold(ax14P,'off');
    ax14PNat = subplot(1,3,2);
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
    ax14PbyM = subplot(1,3,3);
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
    xlb14P.FontSize = LabelFont;
    xlb14PbyM.FontSize = LabelFont;
    ylb14P.FontSize = LabelFont;
    ylb14PbyM.FontSize = LabelFont;
end


if ShowBoxPlots == 1
    figure('Name','10','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
    ax10P = subplot(2,1,1);
    hold(ax10P,'on');
    xlb10P = xlabel('Fractal Dimension Range (D)');
    ylb10P = ylabel('Connectivity (C)');
    set(ylb10P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
    ax10P.FontSize = BoxPlotFont;
    ttl10 = title('Basal (All Angles) Box Plots');
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
    ttl11 = title('Basal (Naturals) Box Plots');
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
    
%     figure('Name','12','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
%     ax12P = subplot(2,1,1);
%     hold(ax12P,'on');
%     xlb112P = xlabel('Fractal Dimension Range (D)');
%     ylb112P = ylabel('Connectivity (C)');
%     set(ylb112P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
%     ax12P.FontSize = BoxPlotFont;
%     ttl12 = title('Basal (All Angles) Box Plots');
%     ttl12.FontSize = TitleFont;
%     BinnedCbyLVals = NaN(MaxNumInBin,BoxPlotNumbins);
%     for i = 1:BoxPlotNumbins
%         BinnedCbyLVals(1:sum(BinInd{1,i}),i) = P(BinInd{1,i})./L(BinInd{1,i});
%     end
%     boxplot(BinnedCbyLVals,DGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
%     hold(ax12P,'off');
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
%     
%     figure('Name','13','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
%     ax13P = subplot(2,1,1);
%     hold(ax13P,'on');
%     xlb113P = xlabel('Fractal Dimension Range (D)');
%     ylb113P = ylabel('Connectivity (C)');
%     set(ylb113P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
%     ax13P.FontSize = BoxPlotFont;
%     ttl13 = title('Basal (Naturals) Box Plots');
%     ttl13.FontSize = TitleFont;
%     NatBinnedCbyLVals = NaN(NatMaxNumInBin,NatNumbins);
%     for i = 1:NatNumbins
%         NatBinnedCbyLVals(1:sum(NatBinInd{1,i}),i) = BPbyM(5,NatBinInd{1,i})./BLbyM(5,NatBinInd{1,i});
%     end
%     boxplot(NatBinnedCbyLVals,NatDGroups,'Notch','on','Whisker',1.75)%,'DataLim',[-3,3],'ExtremeMode','compress')%,'Positions',BinnedDs)
%     hold(ax13P,'off');
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

clearvars -except plottingN D V P M L SA BFbyM BDbyM BVbyM BPbyM BMbyM BLbyM BSAbyM