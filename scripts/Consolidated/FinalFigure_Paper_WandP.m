ShowFig4 = 0;
ShowFig6 = 1;
clearvarsAtEnd = 0;
PlotVForRho = 0; % 0 for rho or 1 for VF

% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr3 = [[255 20 20];[30 30 180];[120 40 150]]/255;
% HTClr = [0 50 75]/255;
% SHTClr = [161 30 34]/255;
% NClr = [0 50 75]/255;
% NNClr = [161 30 34]/255;
HTClr = clr3(2,:);
SHTClr = clr3(1,:);
NClr = clr3(2,:);
NPClr = clr3(2,:);
NNClr = clr3(1,:);
ErrorClr = [0 0 0]/255;
BckClr = [255 255 255]/255;
order = [1,2,3,4,5,6,7,8,9];
Corder = ["000" "025" "050" "075" "100" "125" "150" "175" "200"];
Use0Case = 1;
ShowBoxPlots = 0;
ShowSANormPlots = 1;
ClearVarsAtEnd = 1;
PlotFont = 22; % 18
BoxPlotFont = 14;
LabelFont = 36; % 30
TitleFont = 30;
HTDotSize = 4;
SHIDotSize = 35;
NDotSize = 4;
NNDotSize = 15;
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

HTP1loc = [0.5 0.75 0.35 0.2];
HTP2loc = [0.5 0.55 0.35 0.2];
HTP3loc = [0.5 0.35 0.35 0.2];
HTP4loc = [0.5 0.15 0.35 0.2];
NP1loc = [0.15 0.75 0.35 0.2];
NP2loc = [0.15 0.55 0.35 0.2];
NP3loc = [0.15 0.35 0.35 0.2];
NP4loc = [0.15 0.15 0.35 0.2];
HTP1I = 'b';
HTP2I = 'd';
HTP3I = 'f';
HTP4I = 'h';
NP1I = 'a';
NP2I = 'c';
NP3I = 'e';
NP4I = 'g';
HTP1iloc = [0.505 0.86 0.1 0.1];
HTP2iloc = [0.505 0.66 0.1 0.1];
HTP3iloc = [0.505 0.46 0.1 0.1];
HTP4iloc = [0.505 0.26 0.1 0.1];
NP1iloc = [0.155 0.86 0.1 0.1];
NP2iloc = [0.155 0.66 0.1 0.1];
NP3iloc = [0.155 0.46 0.1 0.1];
NP4iloc = [0.155 0.26 0.1 0.1];

plotrangex = [1.25 1.68];
binRange = [1.3 1.6];
Numbins = 9;
NatbinRange = [1.33 1.5];
NatNumbins = 5;
plotrangepro = [0.5 1.28];
plotrangemass = [0 6];
plotrangeSoBV = [0.05 1.4].*10^-3;
plotrangeHCoS = [0.74 1.04];
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

BDbyM = cell(1,2);
BVbyM = cell(1,2);
BPbyM = cell(1,2);
BMbyM = cell(1,2);
BSAbyM = cell(1,2);
BSABbyM = cell(1,2);
BVMbyM = cell(1,2);
BRbyM = cell(1,2);
BLbyM = cell(1,2);
D = cell(1,2);
V = cell(1,2);
P = cell(1,2);
M = cell(1,2);
SA = cell(1,2);
SAB = cell(1,2);
VM = cell(1,2);
R = cell(1,2);
L = cell(1,2);
[D{1,1},V{1,1},P{1,1},M{1,1},SA{1,1},SAB{1,1},VM{1,1},R{1,1},L{1,1},BDbyM{1,1},BVbyM{1,1},BPbyM{1,1},BMbyM{1,1},BSAbyM{1,1},BSABbyM{1,1},BVMbyM{1,1},BRbyM{1,1},BLbyM{1,1},~] = GetNData_W(plottingN);
[D{1,2},V{1,2},P{1,2},M{1,2},SA{1,2},SAB{1,2},VM{1,2},R{1,2},L{1,2},BDbyM{1,2},BVbyM{1,2},BPbyM{1,2},BMbyM{1,2},BSAbyM{1,2},BSABbyM{1,2},BVMbyM{1,2},BRbyM{1,2},BLbyM{1,2},~] = GetNData_P(plottingN);

BPbyMAve = cell(1,2);
BPbyMDev = cell(1,2);
BDbyMAve = cell(1,2);
BDbyMDev = cell(1,2);
NDAve = cell(1,2);
NDDev = cell(1,2);
NAoAAve = cell(1,2);
NAoADev = cell(1,2);
NPoMAve = cell(1,2);
NPoMDev = cell(1,2);
NPoAAve = cell(1,2);
NPoADev = cell(1,2);
NVFAve = cell(1,2);
NVFDev = cell(1,2);
BPbyMAve{1,1} = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev{1,1} = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve{1,1} = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev{1,1} = zeros(1,BNumMods-(FirstMod-1));
BPbyMAve{1,2} = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev{1,2} = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve{1,2} = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev{1,2} = zeros(1,BNumMods-(FirstMod-1));
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve{1,1}(1,i) = mean(BPbyM{1,1}(i,:)./BSAbyM{1,1}(i,:));
    BPbyMDev{1,1}(1,i) = std(BPbyM{1,1}(i,:)./BSAbyM{1,1}(i,:));
    BDbyMAve{1,1}(1,i) = mean(BDbyM{1,1}(i,:));
    BDbyMDev{1,1}(1,i) = std(BDbyM{1,1}(i,:));
end
[NDAve{1,1}, NDDev{1,1}, NAoAAve{1,1}, NAoADev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},SA{1,1}./SAB{1,1});
[~, ~, NPoMAve{1,1}, NPoMDev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},P{1,1}./SA{1,1});
[~, ~, NPoAAve{1,1}, NPoADev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},P{1,1}./SAB{1,1});
[~, ~, NVFAve{1,1}, NVFDev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},VM{1,1}./V{1,1});
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve{1,2}(1,i) = mean(BPbyM{1,2}(i,:)./BSAbyM{1,2}(i,:));
    BPbyMDev{1,2}(1,i) = std(BPbyM{1,2}(i,:)./BSAbyM{1,2}(i,:));
    BDbyMAve{1,2}(1,i) = mean(BDbyM{1,2}(i,:));
    BDbyMDev{1,2}(1,i) = std(BDbyM{1,2}(i,:));
end
[NDAve{1,2}, NDDev{1,2}, NAoAAve{1,2}, NAoADev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},SA{1,2}./SAB{1,2});
[~, ~, NPoMAve{1,2}, NPoMDev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},P{1,2}./SA{1,2});
[~, ~, NPoAAve{1,2}, NPoADev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},P{1,2}./SAB{1,2});
[~, ~, NVFAve{1,2}, NVFDev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},VM{1,2}./V{1,2});

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
[~, ~, HTVFAve, HTVFDev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),MassV./CHV(1,NDvalInd));
% [~, ~, HTAoRAAve, HTAoRADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),MassSA./ArbSA(1,NDvalInd));
% [~, ~, HTPoRAAve, HTPoRADev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),AveP(1,NDvalInd)./ArbSA(1,NDvalInd));
% [~, ~, HTVFRAve, HTVFRDev] = BinDatabyD(binRange,Numbins,BCD(1,NDvalInd),(ArbV(1,NDvalInd)-MassV)./ArbV(1,NDvalInd));


if ShowFig4 == 1
    fig = figure('Name','CandCvsAngM','units','normalized','outerposition',[1.02 0.12 0.6 0.85]);
    set(fig,'defaultAxesColorOrder',[[0 0 0];[0 0 0]]);
    ax = axes('Position',[0.15 0.15 0.7 0.8],'Box','off','Color',BckClr,'LineWidth',4);
    topline = axes('Position',[0.15 0.15 0.7 0.802],'Box','on','Color',BckClr,'xtick',[],'ytick',[],'xcolor',[0 0 0]/255,'ycolor',[0 0 0]/255,'LineWidth',4);
    axes(ax);
%     axi = annotation('textbox',[0.15 0.85 0.1 0.1],'String','a','LineStyle','none','Color',[0 0 0]/255,'FontSize',PlotFont);
    hold on;
    xlbF4 = xlabel('\alpha');
    set(xlbF4,'Units','Normalized','Position',[0.5, -0.03]);
    xlim([-0.1+(FirstMod-1)*0.25 2.1])
    xticks(0:0.25:2);
    yyaxis right
    ylbF4R = ylabel('$D$','Interpreter','latex','Rotation',0);%,'HorizontalAlignment','left','VerticalAlignment','middle');
    set(ylbF4R,'Units','Normalized','Position',[1.145, 0.34]);
    ylim([1.33 1.65])
    errorbar((FirstMod-1)*0.25:0.25:2,BDbyMAve{1,1},BDbyMDev{1,1}/sqrt(size(plottingN,2)),'LineWidth',2.2,'Color',clr3(2,:));
    set(ax,'ytick',F4RT,'yticklabel',F4RTL);
    yyaxis left
    ylbF4L = ylabel('$\frac{P}{A_S}$','Interpreter','latex','Rotation',0);%,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(ylbF4L,'Units','Normalized','Position',[-0.15, 0.23]);
%     ylbF4L = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    ylim([0.69 1.15])
%     ylim([0.71 1.17])
    errorbar((FirstMod-1)*0.25:0.25:2,BPbyMAve{1,1},BPbyMDev{1,1}/sqrt(size(plottingN,2)),'LineWidth',2.2,'Color',clr3(1,:));
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
    
    HTP1 = axes('Position',HTP1loc,'Box','on','Color',BckClr);
    HTP1i = annotation('textbox',HTP1iloc,'String',HTP1I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(HTP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BCD(1,NDvalInd),AveP(1,NDvalInd)/MassSA,HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP1,'on');
    xlim(NDlims);
    ylim(plotrangeHCoS);
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
    
    HTP2 = axes('Position',HTP2loc,'Color',BckClr);
    HTP2i = annotation('textbox',HTP2iloc,'String',HTP2I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(HTP2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BCD(1,NDvalInd),MassSA./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP2,'on');
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
    
    HTP3 = axes('Position',HTP3loc,'Color',BckClr);
    HTP3i = annotation('textbox',HTP3iloc,'String',HTP3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(HTP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BCD(1,NDvalInd),AveP(1,NDvalInd)./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP3,'on');
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
    
    HTP4 = axes('Position',HTP4loc,'Color',BckClr);
    HTP4i = annotation('textbox',HTP4iloc,'String',HTP4I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(HTP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    yyaxis left;
    set(HTP4,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255);
    yyaxis right;
    if PlotVForRho == 1
        scatter(BCD(1,NDvalInd),(CHV(1,NDvalInd)-MassV)./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
        hold(HTP4,'on');
        set(HTP4,'ytick',HTy4Ticks,'yticklabel',HTy4TickLabels);
%         ylbHTP4 = ylabel('$\frac{V_B-V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
        ylbHTP4 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
%         set(ylbHTP4,'Units','Normalized','Position',[1.118, 0.5]);
    else
        scatter(BCD(1,NDvalInd),MassV./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
        hold(HTP4,'on');
        set(HTP4,'ytick',HTy4RhoTicks,'yticklabel',HTy4RhoTickLabels);
%         ylbHTP4 = ylabel('$\frac{V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
        ylbHTP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle');
%         set(ylbHTP4,'Units','Normalized','Position',[1.118, 0.5]);
    end
    xlim(NDlims);
    set(HTP4,'xtick',Dticks,'xticklabel',DtickLabels);
    HTP4.XRuler.Axle.LineWidth = XaxWidth;
    xlbHTP4 = xlabel('$D$','Interpreter','latex');
    HTP4.FontSize = PlotFont;
    xlbHTP4.FontSize = LabelFont;
    ylbHTP4.FontSize = LabelFont;
    hold(HTP4,'off');
    
    NP1 = axes('Position',[0.15 0.75 0.35 0.2],'Box','on','Color',BckClr);
    NP1i = annotation('textbox',NP1iloc,'String',NP1I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(NP1,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,1},P{1,1}./SA{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP1,'on');
    scatter(D{1,2},P{1,2}./SA{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    scatter(BDbyM{1,1}(NNInd,:),BPbyM{1,1}(NNInd,:)./BSAbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
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
    NP2i = annotation('textbox',NP2iloc,'String',NP2I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(NP2,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,1},SA{1,1}./SAB{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP2,'on');
    scatter(D{1,2},SA{1,2}./SAB{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    scatter(BDbyM{1,1}(NNInd,:),BSAbyM{1,1}(NNInd,:)./BSABbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
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
    NP3i = annotation('textbox',NP3iloc,'String',NP3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(NP3,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,1},P{1,1}./SAB{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    hold(NP3,'on');
    scatter(D{1,2},P{1,2}./SAB{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    scatter(BDbyM{1,1}(NNInd,:),BPbyM{1,1}(NNInd,:)./BSABbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
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
    NP4i = annotation('textbox',NP4iloc,'String',NP4I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
    yyaxis right;
    set(NP4,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
    yyaxis left;
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    if PlotVForRho == 1
        scatter(D{1,1},(V{1,1}-VM{1,1})./V{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
        hold(NP4,'on');
        scatter(D{1,2},(V{1,2}-VM{1,2})./V{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        scatter(BDbyM{1,1}(NNInd,:),(BVbyM{1,1}(NNInd,:)-BVMbyM{1,1}(NNInd,:))./BVbyM{1,1}(NNInd,:),NNDotSize,'s','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        set(NP4,'ytick',Ny4Ticks,'yticklabel',Ny4TickLabels);
%         ylbNP4 = ylabel('$\frac{V_B-V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        ylbNP4 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        set(ylbNP4,'Units','Normalized','Position',[-0.118, 0.5]);
    else
        scatter(D{1,1},VM{1,1}./V{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
        hold(NP4,'on');
        scatter(D{1,2},VM{1,2}./V{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        scatter(BDbyM{1,1}(NNInd,:),BVMbyM{1,1}(NNInd,:)./BVbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        ylim(plotrangeNrho);
        set(NP4,'ytick',Ny4RhoTicks,'yticklabel',Ny4RhoTickLabels);
%         ylbNP4 = ylabel('$\frac{V_M}{V_B}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        set(ylbNP4,'Units','Normalized','Position',[-0.09, 0.5]);
    end
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    NP4.XRuler.Axle.LineWidth = XaxWidth;
    xlbNP4 = xlabel('$D$','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end

% figure; scatter(BDbyM{1,1}(NNInd,:),BLbyM{1,1}(NNInd,:)/max(BLbyM{1,1}(NNInd,:)),'r','filled');
% xlabel('D')
% ylabel('L/L_{max}')

if clearvarsAtEnd == 1
    clearvars -except plottingN plottingH masterN masterH mNVox HTreeM
end