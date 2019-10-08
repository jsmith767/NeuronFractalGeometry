ShowFig4 = 1;
ShowFig6 = 1;
clearvarsAtEnd = 0;
PlotVForRho = 0; % 0 for rho or 1 for VF

% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr2 = [[255 20 20];[30 30 180]]/255;
% HTClr = [0 50 75]/255;
% SHTClr = [161 30 34]/255;
% NClr = [0 50 75]/255;
% NNClr = [161 30 34]/255;
HTClr = clr2(2,:);
SHTClr = clr2(1,:);
NClr = clr2(2,:);
NNClr = clr2(1,:);
ErrorClr = [0 0 0]/255;
BckClr = [255 255 255]/255;
order = [1,2,3,4,5,6,7,8,9];
Corder = ["000" "025" "050" "075" "100" "125" "150" "175" "200"];
Use0Case = 1;
ShowBoxPlots = 0;
ShowSANormPlots = 1;
ClearVarsAtEnd = 1;
PlotFont = 18;
BoxPlotFont = 14;
LabelFont = 30;
TitleFont = 30;
HTDotSize = 5;
SHIDotSize = 35;
NDotSize = 5;
NNDotSize = 12;
NNInd = 5;
NDlims = [1.25 1.68];
F4LTL = [0.7 0.8 0.9];
F4LT = [0.7 0.8 0.9];
F4RTL = [1.35 1.4 1.45 1.5];
F4RT = [1.35 1.4 1.45 1.5];
Dticks = [1.3 1.4 1.5 1.6];
DtickLabels = [1.3 1.4 1.5 1.6];
% Ny2Ticks = [0.05 0.15 0.25];
% Ny2TickLabels = [0.05 0.15 0.25];
Ny1Ticks = [0.6 0.85 1.1];
Ny1TickLabels = [0.6 0.85 1.1];
Ny2Ticks = [0.05 0.15 0.25];
Ny2TickLabels = [0.05 0.15 0.25];
Ny3Ticks = [0.05 0.15 0.25];
Ny3TickLabels = [0.05 0.15 0.25];
Ny4Ticks = [0.993 0.996 0.999];
Ny4TickLabels = [0.993 0.996 0.999];
Ny4RhoTicks = [0.001 0.003 0.005];
Ny4RhoTickLabels = ["1" "3" "5        "];
% HTy2Ticks = [0.01 0.04 0.07];
% HTy2TickLabels = [0.01 0.04 0.07];
HTy1Ticks = [0.8 0.88 0.96];
HTy1TickLabels = [0.8 0.88 0.96];
HTy2Ticks = [0.01 0.04 0.07];
HTy2TickLabels = [0.01 0.04 0.07];
HTy3Ticks = [0.01 0.04 0.07];
HTy3TickLabels = [0.01 0.04 0.07];
HTy4Ticks = [0.99982 0.9999 0.99998];
HTy4TickLabels = [0.99982 0.9999 0.99998];
HTy4RhoTicks = [0.25 1 1.75]*10^-4;
HTy4RhoTickLabels = ["0.25","1.00","1.75"];
XaxWidth = 2;
YaxWidth = 2;

plotrangex = [1.25 1.68];
binRange = [1.3 1.6];
Numbins = 9;
NatbinRange = [1.33 1.5];
NatNumbins = 5;
plotrangepro = [0.5 1.28];
plotrangemass = [0 6];
plotrangeSoBV = [0.05 1.4].*10^-3;
% plotrangeCoS = [0 0.3];
plotrangeCoS = [0.52 1.27];
plotrangeCoBV = [0.06 0.8].*10^-3;
plotrangeVF = [0.99945 1];
plotrangeSoBA = [0.037 0.3];
plotrangeHSoBA = [0 0.08];
% plotrangeCoBA = [0.045 0.175];
plotrangeCoBA = [0.037 0.3];
plotrangeHCoBA = [0 0.08];
plotrangeNrho = [0 6.5].*10^-3;

if Use0Case == 0
    FirstMod = 2;
else
    FirstMod = 1;
end
BNumMods = size(plottingN(1).data.W,2);
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
% SAtcell = cell(BNumMods,size(plottingN,2));
SABcell = cell(BNumMods,size(plottingN,2));
VMcell = cell(BNumMods,size(plottingN,2));
Rcell = cell(BNumMods,size(plottingN,2));
Lcell = cell(1,size(plottingN,2));
for c = 1:BNumMods
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.W(c).D)
                Dcell{c,n} = plottingN(n).data.W(c).D;
                Vcell{c,n} = plottingN(n).data.W(c).volume;
                Pcell{c,n} = plottingN(n).data.W(c).AveP;
                Mcell{c,n} = plottingN(n).data.W(c).mass;
                SAcell{c,n} = plottingN(n).data.W(c).SA;
%                 SAtcell{c,n} = plottingN(n).data.W(c).SAt;
                SABcell{c,n} = plottingN(n).data.W(c).convHullSA;
                VMcell{c,n} = plottingN(n).data.W(c).mass;
                Rcell{c,n} = plottingN(n).data.W(c).ArbR;
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
% ISAt = ~cellfun(@isempty,SAtcell);
ISAB = ~cellfun(@isempty,SABcell);
IVM = ~cellfun(@isempty,VMcell);
IR = ~cellfun(@isempty,Rcell);
Index = and(IF,ID);
Index = and(Index,IV);
Index = and(Index,IP);
Index = and(Index,IM);
Index = and(Index,ISA);
% Index = and(Index,ISAt);
Index = and(Index,ISAB);
Index = and(Index,IVM);
Index = and(Index,IR);
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
% BSAtbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
% SAt = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BSABbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
SAB = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BVMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
VM = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BRbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
R = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
L = zeros((BNumMods)*sum(Index(UseIndex,:)),1);

count = 0;
% BAveNatVol = mean(vertcat(Vcell{5,Index(UseIndex,:)}));
for i = 1:BNumMods
    BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
    BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)});
    BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
    BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
    BSAbyM(i,:) = vertcat(SAcell{i,Index(UseIndex,:)});
%     BSAtbyM(i,:) = vertcat(SAtcell{i,Index(UseIndex,:)});
    BSABbyM(i,:) = vertcat(SABcell{i,Index(UseIndex,:)});
    BVMbyM(i,:) = vertcat(VMcell{i,Index(UseIndex,:)});
    BRbyM(i,:) = vertcat(Rcell{i,Index(UseIndex,:)});
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
%                 SAt(count,1) = BSAtbyM(i,j-jsub);
                SAB(count,1) = BSABbyM(i,j-jsub);
                VM(count,1) = BVMbyM(i,j-jsub);
                R(count,1) = BRbyM(i,j-jsub);
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

BPbyMAve = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev = zeros(1,BNumMods-(FirstMod-1));
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve(1,i) = mean(BPbyM(i,:)./BSAbyM(i,:));
    BPbyMDev(1,i) = std(BPbyM(i,:)./BSAbyM(i,:));
    BDbyMAve(1,i) = mean(BDbyM(i,:));
    BDbyMDev(1,i) = std(BDbyM(i,:));
end

[NDAve, NDDev, NAoAAve, NAoADev] = BinDatabyD(binRange,Numbins,D,SA./SAB);
[~, ~, NPoMAve, NPoMDev] = BinDatabyD(binRange,Numbins,D,P./SA);
[~, ~, NPoAAve, NPoADev] = BinDatabyD(binRange,Numbins,D,P./SAB);
[~, ~, NVFAve, NVFDev] = BinDatabyD(binRange,Numbins,D,(V-VM)./V);


LDD = extractfield(plottingH,'LDD');
BCD = extractfield(plottingH,'BCD');
AveP = extractfield(plottingH,'AveP');
CHV = extractfield(plottingH,'CHV');
CHSA = extractfield(plottingH,'CHSA');
ArbR = extractfield(plottingH,'ArbR');
SHI = 41:41:4141;
temp = false(1,SHI(end));
count = 1;
for i = 1:SHI(end)
    if i == SHI(count)
        temp(1,i) = 1;
        count = count + 1;
    end
end
SHI = temp;

NDvalInd = BCD >= NDlims(1) & BCD <= NDlims(2);
% SHIInd = BCD >= NDlims(1) & BCD <= NDlims(2) & BCD == SHI;
TotalLength = 50000;
ArbV = 4/3*pi*ArbR.^3;
ArbSA = 4*pi*ArbR.^2;
MassV = TotalLength*pi*(0.5)^2; % I use 0.5 here because the width of the HTrees in this model is 1 pixel
MassSA = TotalLength*2*pi*(0.5);

[HTDAve, HTDDev, HTAoAAve, HTAoADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),MassSA./CHSA(1,NDvalInd));
[~, ~, HTPoMAve, HTPoMDev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),AveP(1,NDvalInd)/MassSA);
[~, ~, HTPoAAve, HTPoADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),AveP(1,NDvalInd)./CHSA(1,NDvalInd));
[~, ~, HTVFAve, HTVFDev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),(CHV(1,NDvalInd)-MassV)./CHV(1,NDvalInd));
% [~, ~, HTAoRAAve, HTAoRADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),MassSA./ArbSA(1,NDvalInd));
% [~, ~, HTPoRAAve, HTPoRADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),AveP(1,NDvalInd)./ArbSA(1,NDvalInd));
% [~, ~, HTVFRAve, HTVFRDev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),(ArbV(1,NDvalInd)-MassV)./ArbV(1,NDvalInd));


if ShowFig4 == 1
    fig = figure('Name','CandCvsAngM','units','normalized','outerposition',[1.02 0.12 0.6 0.85]);
    set(fig,'defaultAxesColorOrder',[[0 0 0];[0 0 0]]);
    ax = axes('Position',[0.15 0.15 0.7 0.8],'Box','off','Color',BckClr,'LineWidth',4);
    topline = axes('Position',[0.15 0.15 0.7 0.802],'Box','on','Color',BckClr,'xtick',[],'ytick',[],'xcolor',[0 0 0]/255,'ycolor',[0 0 0]/255,'LineWidth',4);
    axes(ax);
    hold on;
    xlbF4 = xlabel('\alpha');
    set(xlbF4,'Units','Normalized','Position',[0.5, -0.03]);
    xlim([-0.1+(FirstMod-1)*0.25 2.1])
    xticks(0:0.25:2);
    yyaxis right
    ylbF4R = ylabel('D','Interpreter','latex','Rotation',0);%,'HorizontalAlignment','left','VerticalAlignment','middle');
    set(ylbF4R,'Units','Normalized','Position',[1.145, 0.34]);
    ylim([1.33 1.65])
    errorbar((FirstMod-1)*0.25:0.25:2,BDbyMAve,BDbyMDev/sqrt(size(plottingN,2)),'LineWidth',2.2,'Color',clr2(2,:));
    set(ax,'ytick',F4RT,'yticklabel',F4RTL);
    yyaxis left
    ylbF4L = ylabel('$\frac{P}{A_S}$','Interpreter','latex','Rotation',0);%,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(ylbF4L,'Units','Normalized','Position',[-0.15, 0.23]);
%     ylbF4L = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    ylim([0.69 1.15])
%     ylim([0.71 1.17])
    errorbar((FirstMod-1)*0.25:0.25:2,BPbyMAve,BPbyMDev/sqrt(size(plottingN,2)),'LineWidth',2.2,'Color',clr2(1,:));
    set(ax,'ytick',F4LT,'yticklabel',F4LTL);
    set(ax,'xcolor',[0 0 0]/255,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2],'LineWidth',YaxWidth);
    ax.FontSize = PlotFont+8;
    xlbF4.FontSize = LabelFont+15;
    ylbF4L.FontSize = LabelFont+15;
    ylbF4R.FontSize = LabelFont+15;
    hold off;
end
if ShowFig6 == 1
    figure('Name','HTP','units','normalized','outerposition',[0.02 0.12 0.96 0.85])
    N4Exp = annotation('textbox',[0.115 0.236 0.1 0.1],'String','*10^{-3}','LineStyle','none','Color',[0 0 0]/255,'FontSize',PlotFont);
    HT4Exp = annotation('textbox',[0.877 0.257 0.1 0.1],'String','*10^{-4}','LineStyle','none','Color',[0 0 0]/255,'FontSize',PlotFont);
    
    HTP1 = axes('Position',[0.5 0.75 0.35 0.2],'Box','on','Color',BckClr);
    yyaxis right;
    set(HTP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
%     scatter(LDD(1,NDvalInd),AveP(1,NDvalInd)/MassSA,HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    scatter(BCD(1,NDvalInd),AveP(1,NDvalInd)/MassSA,HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP1,'on');
%     scatter(BCD(1,SHI & NDvalInd),AveP(1,SHI & NDvalInd)./MassSA,SHIDotSize,'s','MarkerFaceColor', SHTClr, 'MarkerEdgeColor', SHTClr)
%     errorbar(HTDAve,HTPoMAve,HTPoMDev,HTPoMDev,HTDDev,HTDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    set(HTP1,'xtick',[],'xticklabel',[]);
    HTP1.XRuler.Axle.LineWidth = XaxWidth;
%     ylbHTP1 = ylabel('$\frac{P}{A_S}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    ylbHTP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    set(HTP1,'ytick',HTy1Ticks,'yticklabel',HTy1TickLabels);
    yyaxis left;
    set(HTP1,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    HTP1.FontSize = PlotFont;
    ylbHTP1.FontSize = LabelFont;
    hold(HTP1,'off');
    
    HTP2 = axes('Position',[0.5 0.55 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(HTP2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
%     scatter(LDD(1,NDvalInd),MassSA./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    scatter(BCD(1,NDvalInd),MassSA./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP2,'on');
%     scatter(BCD(1,SHI & NDvalInd),MassSA./CHSA(1,SHI & NDvalInd),SHIDotSize,'s','MarkerFaceColor', SHTClr, 'MarkerEdgeColor', SHTClr)
%     errorbar(HTDAve,HTAoAAve,HTAoADev,HTAoADev,HTDDev,HTDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    ylim(plotrangeHSoBA);
    set(HTP2,'xtick',[],'xticklabel',[]);
    HTP2.XRuler.Axle.LineWidth = XaxWidth;
%     ylbHTP2 = ylabel('$\frac{A_S}{A_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    ylbHTP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    set(HTP2,'ytick',HTy2Ticks,'yticklabel',HTy2TickLabels);
    yyaxis left
    set(HTP2,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    HTP2.FontSize = PlotFont;
    ylbHTP2.FontSize = LabelFont;
    hold(HTP2,'off');
    
    HTP3 = axes('Position',[0.5 0.35 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(HTP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
%     scatter(LDD(1,NDvalInd),AveP(1,NDvalInd)./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    scatter(BCD(1,NDvalInd),AveP(1,NDvalInd)./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP3,'on');
%     scatter(BCD(1,SHI & NDvalInd),AveP(1,SHI & NDvalInd)./CHSA(1,SHI & NDvalInd),SHIDotSize,'s','MarkerFaceColor', SHTClr, 'MarkerEdgeColor', SHTClr)
%     errorbar(HTDAve,HTPoAAve,HTPoADev,HTPoADev,HTDDev,HTDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    ylim(plotrangeHCoBA);
    set(HTP3,'xtick',[],'xticklabel',[]);
    HTP3.XRuler.Axle.LineWidth = XaxWidth;
%     ylbHTP3 = ylabel('$\frac{P}{A_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    ylbHTP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
    set(HTP3,'ytick',HTy3Ticks,'yticklabel',HTy3TickLabels);
    yyaxis left;
    set(HTP3,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    HTP3.FontSize = PlotFont;
    ylbHTP3.FontSize = LabelFont;
    hold(HTP3,'off');
    
    HTP4 = axes('Position',[0.5 0.15 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(HTP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    yyaxis left;
    set(HTP4,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255);
    yyaxis right;
    if PlotVForRho == 1
        scatter(LDD(1,NDvalInd),(CHV(1,NDvalInd)-MassV)./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
%         scatter(BCD(1,NDvalInd),(CHV(1,NDvalInd)-MassV)./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
        hold(HTP4,'on');
%         scatter(BCD(1,SHI & NDvalInd),(CHV(1,SHI & NDvalInd)-MassV)./CHV(1,SHI & NDvalInd),SHIDotSize,'s','MarkerFaceColor', SHTClr, 'MarkerEdgeColor', SHTClr)
%         errorbar(HTDAve,HTVFAve,HTVFDev,HTVFDev,HTDDev,HTDDev,'ks','LineWidth',2,'Color',ErrorClr)
        set(HTP4,'ytick',HTy4Ticks,'yticklabel',HTy4TickLabels);
%         ylbHTP4 = ylabel('$\frac{V_B-V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
        ylbHTP4 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
%         set(ylbHTP4,'Units','Normalized','Position',[1.118, 0.5]);
    else
        scatter(BCD(1,NDvalInd),MassV./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
%         scatter(LDD(1,NDvalInd),MassV./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
        hold(HTP4,'on');
%         scatter(BCD(1,SHI & NDvalInd),(CHV(1,SHI & NDvalInd)-MassV)./CHV(1,SHI & NDvalInd),SHIDotSize,'s','MarkerFaceColor', SHTClr, 'MarkerEdgeColor', SHTClr)
%         errorbar(HTDAve,HTVFAve,HTVFDev,HTVFDev,HTDDev,HTDDev,'ks','LineWidth',2,'Color',ErrorClr)
        set(HTP4,'ytick',HTy4RhoTicks,'yticklabel',HTy4RhoTickLabels);
%         ylbHTP4 = ylabel('${\rho}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
%         ylbHTP4 = ylabel('$\frac{V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
        ylbHTP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
%         set(ylbHTP4,'Units','Normalized','Position',[1.118, 0.5]);
    end
    xlim(NDlims);
    set(HTP4,'xtick',Dticks,'xticklabel',DtickLabels);
    HTP4.XRuler.Axle.LineWidth = XaxWidth;
    xlbHTP4 = xlabel('D','Interpreter','latex');
    HTP4.FontSize = PlotFont;
    xlbHTP4.FontSize = LabelFont;
    ylbHTP4.FontSize = LabelFont;
    hold(HTP4,'off');
    
    NP1 = axes('Position',[0.15 0.75 0.35 0.2],'Box','on','Color',BckClr);
    yyaxis right;
    set(NP1,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D,P./SA,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP1,'on');
    scatter(BDbyM(NNInd,:),BPbyM(NNInd,:)./BSAbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%     errorbar(NDAve,NPoMAve,NPoMDev,NPoMDev,NDDev,NDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    set(NP1,'xtick',[],'xticklabel',[]);
    NP1.XRuler.Axle.LineWidth = XaxWidth;
%     ylbNP1 = ylabel('$\frac{P}{A_S}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP1,'ytick',Ny1Ticks,'yticklabel',Ny1TickLabels);
    NP1.FontSize = PlotFont;
    xlbNP1.FontSize = LabelFont;
    ylbNP1.FontSize = LabelFont;
    hold(NP1,'off');
    
    NP2 = axes('Position',[0.15 0.55 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(NP2,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D,SA./SAB,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP2,'on');
    scatter(BDbyM(NNInd,:),BSAbyM(NNInd,:)./BSABbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%     errorbar(NDAve,NAoAAve,NAoADev,NAoADev,NDDev,NDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    ylim(plotrangeSoBA);
    set(NP2,'xtick',[],'xticklabel',[]);
    NP2.XRuler.Axle.LineWidth = XaxWidth;
%     ylbNP2 = ylabel('$\frac{A_S}{A_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP2,'ytick',Ny2Ticks,'yticklabel',Ny2TickLabels);
    NP2.FontSize = PlotFont;
    xlbNP2.FontSize = LabelFont;
    ylbNP2.FontSize = LabelFont;
    hold(NP2,'off');
    
    NP3 = axes('Position',[0.15 0.35 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(NP3,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D,P./SAB,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP3,'on');
    scatter(BDbyM(NNInd,:),BPbyM(NNInd,:)./BSABbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%     errorbar(NDAve,NPoAAve,NPoADev,NPoADev,NDDev,NDDev,'ks','LineWidth',2,'Color',ErrorClr)
    xlim(NDlims);
    ylim(plotrangeCoBA)
    set(NP3,'xtick',[],'xticklabel',[]);
    NP3.XRuler.Axle.LineWidth = XaxWidth;
%     ylbNP3 = ylabel('$\frac{P}{A_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP3,'ytick',Ny3Ticks,'yticklabel',Ny3TickLabels);
    NP3.FontSize = PlotFont;
    xlbNP3.FontSize = LabelFont;
    ylbNP3.FontSize = LabelFont;
    hold(NP3,'off');
    
    NP4 = axes('Position',[0.15 0.15 0.35 0.2],'Color',BckClr);
    yyaxis right;
    set(NP4,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    if PlotVForRho == 1
        scatter(D,(V-VM)./V,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
        hold(NP4,'on');
        scatter(BDbyM(NNInd,:),(BVbyM(NNInd,:)-BVMbyM(NNInd,:))./BVbyM(NNInd,:),NNDotSize,'s','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%         errorbar(NDAve,NVFAve,NVFDev,NVFDev,NDDev,NDDev,'s','LineWidth',2,'Color',ErrorClr)
        set(NP4,'ytick',Ny4Ticks,'yticklabel',Ny4TickLabels);
%         ylbNP4 = ylabel('$\frac{V_B-V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        ylbNP4 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        set(ylbNP4,'Units','Normalized','Position',[-0.118, 0.5]);
    else
        scatter(D,VM./V,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
        hold(NP4,'on');
        scatter(BDbyM(NNInd,:),BVMbyM(NNInd,:)./BVbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%         errorbar(NDAve,NVFAve,NVFDev,NVFDev,NDDev,NDDev,'s','LineWidth',2,'Color',ErrorClr)
        ylim(plotrangeNrho);
        set(NP4,'ytick',Ny4RhoTicks,'yticklabel',Ny4RhoTickLabels);
%         ylbNP4 = ylabel('${\rho}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
%         ylbNP4 = ylabel('$\frac{V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        set(ylbNP4,'Units','Normalized','Position',[-0.09, 0.5]);
    end
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    NP4.XRuler.Axle.LineWidth = XaxWidth;
    xlbNP4 = xlabel('D','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end

if clearvarsAtEnd == 1
    clearvars -except plottingN plottingH masterN masterH mNVox HTreeM
end