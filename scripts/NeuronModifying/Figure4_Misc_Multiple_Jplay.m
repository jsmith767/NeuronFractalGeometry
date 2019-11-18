% % % FileNames = {'masterN_W_1-9','masterN_P_1-9','masterN_LT_0.25','masterN_LT_0.50','masterN_LT_0.75','masterN_LT_1.00','masterN_LT_1.25','masterN_W_Natural'};
% % % Methods = {'W','P','LT','LT','LT','LT','LT','W'};
% % % nummasters = size(FileNames,2);
% % % BNumMods = zeros(1,size(FileNames,2));
% % % for i = 1:nummasters
% % %     mN(i) = load(['Z:\Keck\Programs\Healthy\' FileNames{1,i} '.mat']);
% % %     BNumMods(1,i) = size(mN(i).masterN(1).data.(matlab.lang.makeValidName(Methods{1,i})),2);
% % % end

PlotVForRho = 0; % 0 for rho or 1 for VF
PlotNaturalinRed = 0; % Only make 1 if multiple alphas exist
NNInd = 5; % Index corresponding to the natural neurons

clr = [[0 0 1];[0 0.5 1];[0 1 1];[0 1 1];[0 1 1];[0 1 1];[1 0 0]];
% clr = [[0 0 1];[0 0.5 1];[0 1 1];[0 1 1];[0 1 1];[0 1 1];[0 1 1];[1 0 0]];
lgdstr = {'\theta','\phi','L','N'};
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
HTDotSize = 4;
HTreeBinSize = 10;
SHIDotSize = 35;
NDotSize = [4 4 4 4 4 4 4 15];
NNDotSize = 15;
NDlims = [1.25 1.68];
XaxWidth = 2;
YaxWidth = 2;

binRange = [1.3 1.6];
Numbins = 9;
NatbinRange = [1.33 1.5];
NatNumbins = 5;

NP1loc = [0.13 0.78 0.82 0.17];
NP2loc = [0.13 0.56 0.82 0.17];
NP3loc = [0.13 0.34 0.82 0.17];
NP4loc = [0.13 0.12 0.82 0.17];
% NP1I = 'a';
% NP2I = 'b';
% NP3I = 'c';
% NP4I = 'd';
% NP1iloc = [0.1 0.86 0.1 0.1];
% NP2iloc = [0.1 0.66 0.1 0.1];
% NP3iloc = [0.1 0.46 0.1 0.1];
% NP4iloc = [0.1 0.26 0.1 0.1];

if Use0Case == 0
    FirstMod = 2;
else
    FirstMod = 1;
end

BDbyM = cell(1,nummasters);
BVbyM = cell(1,nummasters);
BPbyM = cell(1,nummasters);
% BBAbyM = cell(1,nummasters);
BMbyM = cell(1,nummasters);
BSAbyM = cell(1,nummasters);
BSABbyM = cell(1,nummasters);
BVMbyM = cell(1,nummasters);
BRbyM = cell(1,nummasters);
BLbyM = cell(1,nummasters);
D = cell(1,nummasters);
V = cell(1,nummasters);
P = cell(1,nummasters);
BA = cell(1,nummasters);
M = cell(1,nummasters);
SA = cell(1,nummasters);
SAB = cell(1,nummasters);
VM = cell(1,nummasters);
R = cell(1,nummasters);
L = cell(1,nummasters);

BPbyMAve = cell(1,nummasters);
BPbyMDev = cell(1,nummasters);
% BBAbyMAve = cell(1,nummasters);
% BBAbyMDev = cell(1,nummasters);
BDbyMAve = cell(1,nummasters);
BDbyMDev = cell(1,nummasters);
NDAve = cell(1,nummasters);
NDDev = cell(1,nummasters);
NAoAAve = cell(1,nummasters);
NAoADev = cell(1,nummasters);
NPoMAve = cell(1,nummasters);
NPoMDev = cell(1,nummasters);
NPoAAve = cell(1,nummasters);
NPoADev = cell(1,nummasters);
NPoBAAve = cell(1,nummasters);
NPoBADev = cell(1,nummasters);
NVFAve = cell(1,nummasters);
NVFDev = cell(1,nummasters);

for i = 1:nummasters
    
    [D{1,i},V{1,i},P{1,i},SA{1,i},SAB{1,i},VM{1,i},L{1,i},BDbyM{1,i},BVbyM{1,i},BPbyM{1,i},BSAbyM{1,i},BSABbyM{1,i},BVMbyM{1,i},BLbyM{1,i},~] = GetNData2_NoBA(mN(i).masterN,Methods{1,i});

    BPbyMAve{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    BPbyMDev{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    % BPBAbyMAve{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    % BPBAbyMDev{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    BDbyMAve{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    BDbyMDev{1,i} = zeros(1,BNumMods(1,i)-(FirstMod-1));
    for c = 1:BNumMods(1,i)-(FirstMod-1)
        BPbyMAve{1,i}(1,c) = mean(BPbyM{1,i}(c,:)./BSAbyM{1,i}(c,:));
        BPbyMDev{1,i}(1,c) = std(BPbyM{1,i}(c,:)./BSAbyM{1,i}(c,:));
    %     BPBAbyMAve{1,i}(1,c) = mean(BPbyM{1,i}(c,:)./BBAbyM{1,i}(c,:));
    %     BPBAbyMDev{1,i}(1,c) = std(BPbyM{1,i}(c,:)./BBAbyM{1,i}(c,:));
        BDbyMAve{1,i}(1,c) = mean(BDbyM{1,i}(c,:));
        BDbyMDev{1,i}(1,c) = std(BDbyM{1,i}(c,:));
    end
    [NDAve{1,i}, NDDev{1,i}, NAoAAve{1,i}, NAoADev{1,i}] = BinDatabyD(binRange,Numbins,D{1,i},SA{1,i}./SAB{1,i});
    [~, ~, NPoMAve{1,i}, NPoMDev{1,i}] = BinDatabyD(binRange,Numbins,D{1,i},P{1,i}./SA{1,i});
    [~, ~, NPoAAve{1,i}, NPoADev{1,i}] = BinDatabyD(binRange,Numbins,D{1,i},P{1,i}./SAB{1,i});
    % [~, ~, NPoBAAve{1,i}, NPoBADev{1,i}] = BinDatabyD(binRange,Numbins,D{1,i},P{1,i}./BA{1,i});
    [~, ~, NVFAve{1,i}, NVFDev{1,i}] = BinDatabyD(binRange,Numbins,D{1,i},VM{1,i}./V{1,i});

end

figure('Position',[20 80 1000 800]);

NP1 = axes('Position',NP1loc,'Color',BckClr);
%     NP1i = annotation('textbox',NP1iloc,'String',NP1I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
set(NP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
hold(NP1,'on');
for i = 1:nummasters
    PoSA(i) = scatter(D{1,i},P{1,i}./SA{1,i},NDotSize(i),'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:));
end
if PlotNaturalinRed == 1
    scatter(BDbyM{1,i}(NNInd,:),BPbyM{1,i}(NNInd,:)./BSAbyM{1,i}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
end
box(NP1,'on');
set(NP1,'xticklabel',[]);
set(NP1,'LineWidth',XaxWidth);
ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
NP1.FontSize = PlotFont;
ylbNP1.FontSize = LabelFont;
hold(NP1,'off');
% legend([PoSA(1) PoSA(2) PoSA(3) PoSA(8)],lgdstr);

NP2 = axes('Position',NP2loc,'Color',BckClr);
%     NP2i = annotation('textbox',NP2iloc,'String',NP2I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
set(NP2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
hold(NP2,'on');
for i = 1:nummasters
    scatter(D{1,i},SA{1,i}./SAB{1,i},NDotSize(i),'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
if PlotNaturalinRed == 1
    scatter(BDbyM{1,i}(NNInd,:),BSAbyM{1,i}(NNInd,:)./BSABbyM{1,i}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
end
box(NP2,'on');
set(NP2,'xticklabel',[]);
set(NP2,'LineWidth',XaxWidth);
ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
NP2.FontSize = PlotFont;
ylbNP2.FontSize = LabelFont;
hold(NP2,'off');

NP3 = axes('Position',NP3loc,'Color',BckClr);
%     NP3i = annotation('textbox',NP3iloc,'String',NP3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
hold(NP3,'on');
for i = 1:nummasters
    scatter(D{1,i},P{1,i}./SAB{1,i},NDotSize(i),'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
if PlotNaturalinRed == 1
    scatter(BDbyM{1,i}(NNInd,:),BPbyM{1,i}(NNInd,:)./BSABbyM{1,i}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
end
box(NP3,'on');
set(NP3,'xticklabel',[]);
set(NP3,'LineWidth',XaxWidth);
ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
NP3.FontSize = PlotFont;
ylbNP3.FontSize = LabelFont;
hold(NP3,'off');

NP4 = axes('Position',NP4loc,'Color',BckClr);
%     NP4i = annotation('textbox',NP4iloc,'String',NP4I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
if PlotVForRho == 1
    hold(NP4,'on');
    for i = 1:nummasters
        scatter(D{1,i},(V{1,i}-VM{1,i})./V{1,i},NDotSize(i),'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    end
    if PlotNaturalinRed == 1
        scatter(BDbyM{1,i}(NNInd,:),(BVbyM{1,i}(NNInd,:)-BVMbyM{1,i}(NNInd,:))./BVbyM{1,i}(NNInd,:),NNDotSize,'s','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    end
    ylbNP4 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
else
    hold(NP4,'on');
    for i = 1:nummasters
        scatter(D{1,i},VM{1,i}./V{1,i},NDotSize(i),'o','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
    end
    if PlotNaturalinRed == 1
        scatter(BDbyM{1,i}(NNInd,:),BVMbyM{1,i}(NNInd,:)./BVbyM{1,i}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    end
    ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
end
box(NP4,'on');
set(NP4,'LineWidth',XaxWidth);
xlbNP4 = xlabel('$D$','Interpreter','latex');
NP4.FontSize = PlotFont;
xlbNP4.FontSize = LabelFont;
ylbNP4.FontSize = LabelFont;
hold(NP4,'off');