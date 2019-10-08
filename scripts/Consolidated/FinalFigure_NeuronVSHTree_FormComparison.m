% Run FinalFigure_Paper_WandP_New.m before this script

MakePlotForAll = 0;
MakePlotForW = 0;
MakePlotForP = 0;
MakePlotForNaturals = 0;
MakePlotForPoverAs = 0;
MakePlotNeuronsAndHTrees = 1;
    ShowFullRange = 1;
    ShowNatRange = 0;
MakePlotForHTrees = 0;

if MakePlotForAll == 1
    figure;
    NP3 = axes('Position',[0.2 0.2 0.7 0.7],'Color',BckClr);
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter([D{1,1};D{1,2}],[P{1,1};P{1,2}]./[SAB{1,1};SAB{1,2}],NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    xlim(NDlims);
    ylim(plotrangeCoBA);
    ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP3,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP3 = xlabel('$D$','Interpreter','latex');
    NP3.FontSize = PlotFont;
    xlbNP3.FontSize = LabelFont;
    ylbNP3.FontSize = LabelFont;
    hold(NP3,'off');
    
    figure;
    NP4 = axes('Position',[0.15 0.2 0.75 0.7],'Color',BckClr);
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter([D{1,1};D{1,2}],[VM{1,1};VM{1,2}]./[V{1,1};V{1,2}],NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    ylim(plotrangeNrho);
    ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP4 = xlabel('$D$','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end
if MakePlotForW == 1
    figure;
    NP3 = axes('Position',[0.2 0.2 0.7 0.7],'Color',BckClr);
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,1},P{1,1}./SAB{1,1},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    xlim(NDlims);
    ylim(plotrangeCoBA);
    ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP3,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP3 = xlabel('$D$','Interpreter','latex');
    NP3.FontSize = PlotFont;
    xlbNP3.FontSize = LabelFont;
    ylbNP3.FontSize = LabelFont;
    hold(NP3,'off');
    
    figure;
    NP4 = axes('Position',[0.15 0.2 0.75 0.7],'Color',BckClr);
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,1},VM{1,1}./V{1,1},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    ylim(plotrangeNrho);
    ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP4 = xlabel('$D$','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end
if MakePlotForP == 1
    figure;
    NP3 = axes('Position',[0.2 0.2 0.7 0.7],'Color',BckClr);
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,2},P{1,2}./SAB{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    xlim(NDlims);
    ylim(plotrangeCoBA);
    ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP3,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP3 = xlabel('$D$','Interpreter','latex');
    NP3.FontSize = PlotFont;
    xlbNP3.FontSize = LabelFont;
    ylbNP3.FontSize = LabelFont;
    hold(NP3,'off');
    
    figure;
    NP4 = axes('Position',[0.15 0.2 0.75 0.7],'Color',BckClr);
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(D{1,2},VM{1,2}./V{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    ylim(plotrangeNrho);
    ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP4 = xlabel('$D$','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end
if MakePlotForNaturals == 1
    figure;
    NP3 = axes('Position',[0.2 0.2 0.7 0.7],'Color',BckClr);
    set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BDbyM{1,1}(5,:),BPbyM{1,1}(5,:)./BSABbyM{1,1}(5,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    xlim(NDlims);
    ylim(plotrangeCoBA);
    ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    set(NP3,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP3 = xlabel('$D$','Interpreter','latex');
    NP3.FontSize = PlotFont;
    xlbNP3.FontSize = LabelFont;
    ylbNP3.FontSize = LabelFont;
    hold(NP3,'off');
    
    figure;
    NP4 = axes('Position',[0.15 0.2 0.75 0.7],'Color',BckClr);
    set(NP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BDbyM{1,1}(5,:),BVMbyM{1,1}(5,:)./BVbyM{1,1}(5,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    ylim(plotrangeNrho);
    ylbNP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlim(NDlims);
    set(NP4,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbNP4 = xlabel('$D$','Interpreter','latex');
    NP4.FontSize = PlotFont;
    xlbNP4.FontSize = LabelFont;
    ylbNP4.FontSize = LabelFont;
    hold(NP4,'off');
end
if MakePlotNeuronsAndHTrees == 1
    NeurNumBins = 5;
    HTreeNatNumBins = 5;
    
    NatNeurDLims = [min(BDbyM{1,1}(5,:)) max(BDbyM{1,1}(5,:))];
    NeurD = BDbyM{1,1}(5,:);
    NeurP = BPbyM{1,1}(5,:);
    NeurVB = BVbyM{1,1}(5,:);
    NeurVM = BVMbyM{1,1}(5,:);
    NeurAS = BSAbyM{1,1}(5,:);
    NeurAB = BSABbyM{1,1}(5,:);
    NeurPoAS = (NeurP./NeurAS - min(NeurP./NeurAS))/max(NeurP./NeurAS - min(NeurP./NeurAS));
    NeurASoAB = (NeurAS./NeurAB - min(NeurAS./NeurAB))/max(NeurAS./NeurAB - min(NeurAS./NeurAB));
    NeurPoAB = (NeurP./NeurAB - min(NeurP./NeurAB))/max(NeurP./NeurAB - min(NeurP./NeurAB));
    NeurVMoVB = (NeurVM./NeurVB - min(NeurVM./NeurVB))/max(NeurVM./NeurVB - min(NeurVM./NeurVB));
    [NeurDBin, NeurDBinDev, NeurPoASBin, NeurPoASBinDev] = BinDatabyD(NatNeurDLims,NeurNumBins,NeurD,NeurPoAS);
    [~, ~, NeurASoABBin, NeurASoABBinDev] = BinDatabyD(NatNeurDLims,NeurNumBins,NeurD,NeurASoAB);
    [~, ~, NeurPoABBin, NeurPoABBinDev] = BinDatabyD(NatNeurDLims,NeurNumBins,NeurD,NeurPoAB);
    [~, ~, NeurVMoVBBin, NeurVMoVBBinDev] = BinDatabyD(NatNeurDLims,NeurNumBins,NeurD,NeurVMoVB);
    
    HTreeVM = MassV;
    HTreeAS = MassSA;
    HTreeInNatDLims = BCD >= NatNeurDLims(1) & BCD <= NatNeurDLims(2);
    HTreeNatD = BCD(1,HTreeInNatDLims);
    HTreeNatP = AveP(1,HTreeInNatDLims);
    HTreeNatVB = CHV(1,HTreeInNatDLims);
    HTreeNatAB = CHSA(1,HTreeInNatDLims);
    HTreeNatPoAS = (HTreeNatP./HTreeAS - min(HTreeNatP./HTreeAS))/max(HTreeNatP./HTreeAS - min(HTreeNatP./HTreeAS));
    HTreeNatASoAB = (HTreeAS./HTreeNatAB - min(HTreeAS./HTreeNatAB))/max(HTreeAS./HTreeNatAB - min(HTreeAS./HTreeNatAB));
    HTreeNatPoAB = (HTreeNatP./HTreeNatAB - min(HTreeNatP./HTreeNatAB))/max(HTreeNatP./HTreeNatAB - min(HTreeNatP./HTreeNatAB));
    HTreeNatVMoVB = (HTreeVM./HTreeNatVB - min(HTreeVM./HTreeNatVB))/max(HTreeVM./HTreeNatVB - min(HTreeVM./HTreeNatVB));
    [HTreeNatDBin, HTreeNatDBinDev, HTreeNatPoASBin, HTreeNatPoASBinDev] = BinDatabyD(NatNeurDLims,HTreeNatNumBins,HTreeNatD,HTreeNatPoAS);
    [~, ~, HTreeNatASoABBin, HTreeNatASoABBinDev] = BinDatabyD(NatNeurDLims,HTreeNatNumBins,HTreeNatD,HTreeNatASoAB);
    [~, ~, HTreeNatPoABBin, HTreeNatPoABBinDev] = BinDatabyD(NatNeurDLims,HTreeNatNumBins,HTreeNatD,HTreeNatPoAB);
    [~, ~, HTreeNatVMoVBBin, HTreeNatVMoVBBinDev] = BinDatabyD(NatNeurDLims,HTreeNatNumBins,HTreeNatD,HTreeNatVMoVB);
    
    FullDLims = [1.2 1.7];
    HTreeInDLims = BCD >= FullDLims(1) & BCD <= FullDLims(2);
    HTreeD = BCD(1,HTreeInDLims);
    HTreeP = AveP(1,HTreeInDLims);
    HTreeVB = CHV(1,HTreeInDLims);
    HTreeAB = CHSA(1,HTreeInDLims);
    HTreePoAS = (HTreeP./HTreeAS - min(HTreeNatP./HTreeAS))/max(HTreeNatP./HTreeAS - min(HTreeNatP./HTreeAS));
    HTreeASoAB = (HTreeAS./HTreeAB - min(HTreeAS./HTreeNatAB))/max(HTreeAS./HTreeNatAB - min(HTreeAS./HTreeNatAB));
    HTreePoAB = (HTreeP./HTreeAB - min(HTreeNatP./HTreeNatAB))/max(HTreeNatP./HTreeNatAB - min(HTreeNatP./HTreeNatAB));
    HTreeVMoVB = (HTreeVM./HTreeVB - min(HTreeVM./HTreeNatVB))/max(HTreeVM./HTreeNatVB - min(HTreeVM./HTreeNatVB));
    
    ShiftYPoAS = min([HTreePoAS NeurPoAS]);
    ShiftYASoAB = min([HTreeASoAB NeurASoAB]);
    ShiftYPoAB = min([HTreePoAB NeurPoAB]);
    ShiftYVMoVB = min([HTreeVMoVB NeurVMoVB]);
    ScaleYPoAS = max([HTreePoAS NeurPoAS])-ShiftYPoAS;
    ScaleYASoAB = max([HTreeASoAB NeurASoAB])-ShiftYASoAB;
    ScaleYPoAB = max([HTreePoAB NeurPoAB])-ShiftYPoAB;
    ScaleYVMoVB = max([HTreeVMoVB NeurVMoVB])-ShiftYVMoVB;
    if ShowFullRange == 1
        figure;
        NAH1 = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeD,(HTreePoAS-ShiftYPoAS)/ScaleYPoAS,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH1,'on');
        scatter(NeurD,(NeurPoAS-ShiftYPoAS)/ScaleYPoAS,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        xlim(FullDLims);
        set(NAH1,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH1 = xlabel('$D$','Interpreter','latex');
        NAH1.FontSize = PlotFont;
        xlbNAH1.FontSize = LabelFont;
        ylbNAH1.FontSize = LabelFont;
        hold(NAH1,'off');

        figure;
        NAH2 = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH2,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeD,(HTreeASoAB-ShiftYASoAB)/ScaleYASoAB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH2,'on');
        scatter(NeurD,(NeurASoAB-ShiftYASoAB)/ScaleYASoAB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        xlim(FullDLims);
        set(NAH2,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH2 = xlabel('$D$','Interpreter','latex');
        NAH2.FontSize = PlotFont;
        xlbNAH2.FontSize = LabelFont;
        ylbNAH2.FontSize = LabelFont;
        hold(NAH2,'off');

        figure;
        NAH3 = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeD,(HTreePoAB-ShiftYPoAB)/ScaleYPoAB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH3,'on');
        scatter(NeurD,(NeurPoAB-ShiftYPoAB)/ScaleYPoAB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        xlim(FullDLims);
        set(NAH3,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH3 = xlabel('$D$','Interpreter','latex');
        NAH3.FontSize = PlotFont;
        xlbNAH3.FontSize = LabelFont;
        ylbNAH3.FontSize = LabelFont;
        hold(NAH3,'off');

        figure;
        NAH4 = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeD,(HTreeVMoVB-ShiftYVMoVB)/ScaleYVMoVB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH4,'on');
        scatter(NeurD,(NeurVMoVB-ShiftYVMoVB)/ScaleYVMoVB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        xlim(FullDLims);
        set(NAH4,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH4 = xlabel('$D$','Interpreter','latex');
        NAH4.FontSize = PlotFont;
        xlbNAH4.FontSize = LabelFont;
        ylbNAH4.FontSize = LabelFont;
        hold(NAH4,'off');
    end
    if ShowNatRange == 1
        figure;
        NAH1Nat = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH1Nat,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeNatD,HTreeNatPoAS,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH1Nat,'on');
        scatter(NeurD,NeurPoAS,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        errorbar(HTreeNatDBin,HTreeNatPoASBin,HTreeNatPoASBinDev,HTreeNatPoASBinDev,HTreeNatDBinDev,HTreeNatDBinDev,'s','LineWidth',2.2,'Color',[50 110 255]/255)
        errorbar(NeurDBin,NeurPoASBin,NeurPoASBinDev,NeurPoASBinDev,NeurDBinDev,NeurDBinDev,'s','LineWidth',2.2,'Color',[255 110 50]/255)
        xlim(NatNeurDLims);
        set(NAH1Nat,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH1Nat = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH1Nat = xlabel('$D$','Interpreter','latex');
        NAH1Nat.FontSize = PlotFont;
        xlbNAH1Nat.FontSize = LabelFont;
        ylbNAH1Nat.FontSize = LabelFont;
        hold(NAH1Nat,'off');
        
        figure;
        NAH2Nat = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH2Nat,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeNatD,HTreeNatASoAB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH2Nat,'on');
        scatter(NeurD,NeurASoAB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        errorbar(HTreeNatDBin,HTreeNatASoABBin,HTreeNatASoABBinDev,HTreeNatASoABBinDev,HTreeNatDBinDev,HTreeNatDBinDev,'s','LineWidth',2.2,'Color',[50 110 255]/255)
        errorbar(NeurDBin,NeurASoABBin,NeurASoABBinDev,NeurASoABBinDev,NeurDBinDev,NeurDBinDev,'s','LineWidth',2.2,'Color',[255 110 50]/255)
        xlim(NatNeurDLims);
        set(NAH2Nat,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH2Nat = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH2Nat = xlabel('$D$','Interpreter','latex');
        NAH2Nat.FontSize = PlotFont;
        xlbNAH2Nat.FontSize = LabelFont;
        ylbNAH2Nat.FontSize = LabelFont;
        hold(NAH2Nat,'off');
        
        figure;
        NAH3Nat = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH3Nat,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeNatD,HTreeNatPoAB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH3Nat,'on');
        scatter(NeurD,NeurPoAB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        errorbar(HTreeNatDBin,HTreeNatPoABBin,HTreeNatPoABBinDev,HTreeNatPoABBinDev,HTreeNatDBinDev,HTreeNatDBinDev,'s','LineWidth',2.2,'Color',[50 110 255]/255)
        errorbar(NeurDBin,NeurPoABBin,NeurPoABBinDev,NeurPoABBinDev,NeurDBinDev,NeurDBinDev,'s','LineWidth',2.2,'Color',[255 110 50]/255)
        xlim(NatNeurDLims);
        set(NAH3Nat,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH3Nat = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH3Nat = xlabel('$D$','Interpreter','latex');
        NAH3Nat.FontSize = PlotFont;
        xlbNAH3Nat.FontSize = LabelFont;
        ylbNAH3Nat.FontSize = LabelFont;
        hold(NAH3Nat,'off');
        
        figure;
        NAH4Nat = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
        set(NAH4Nat,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
        scatter(HTreeNatD,HTreeNatVMoVB,NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
        hold(NAH4Nat,'on');
        scatter(NeurD,NeurVMoVB,NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
        errorbar(HTreeNatDBin,HTreeNatVMoVBBin,HTreeNatVMoVBBinDev,HTreeNatVMoVBBinDev,HTreeNatDBinDev,HTreeNatDBinDev,'s','LineWidth',2.2,'Color',[50 110 255]/255)
        errorbar(NeurDBin,NeurVMoVBBin,NeurVMoVBBinDev,NeurVMoVBBinDev,NeurDBinDev,NeurDBinDev,'s','LineWidth',2.2,'Color',[255 110 50]/255)
        xlim(NatNeurDLims);
        set(NAH4Nat,'xtick',Dticks,'xticklabel',DtickLabels);
        ylbNAH4Nat = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNAH4Nat = xlabel('$D$','Interpreter','latex');
        NAH4Nat.FontSize = PlotFont;
        xlbNAH4Nat.FontSize = LabelFont;
        ylbNAH4Nat.FontSize = LabelFont;
        hold(NAH4Nat,'off');
    end
end
if MakePlotForPoverAs == 1
    figure;
    NP1 = axes('Position',[0.2 0.2 0.7 0.7],'Box','on','Color',BckClr);
    set(NP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter([D{1,1};D{1,2}],[P{1,1};P{1,2}]./[SA{1,1};SA{1,2}],NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
    hold(NP1,'on');
    scatter(BDbyM{1,1}(NNInd,:),BPbyM{1,1}(NNInd,:)./BSAbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    xlim(NDlims);
    set(NP1,'xtick',Dticks,'xticklabel',DtickLabels);
    ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    NP1.FontSize = PlotFont;
    xlbNP1.FontSize = LabelFont;
    ylbNP1.FontSize = LabelFont;
    hold(NP1,'off');
end
if MakePlotForHTrees == 1
    figure;
    HTP3 = axes('Position',[0.2 0.2 0.7 0.7],'Color',BckClr);
    set(HTP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BCD(1,NDvalInd),AveP(1,NDvalInd)./CHSA(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP3,'on');
    xlim(NDlims);
    set(HTP3,'xtick',Dticks,'xticklabel',DtickLabels);
    ylim(plotrangeHCoBA);
    ylbHTP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    HTP3.FontSize = PlotFont;
    ylbHTP3.FontSize = LabelFont;
    hold(HTP3,'off');

    figure;
    HTP4 = axes('Position',[0.15 0.2 0.75 0.7],'Color',BckClr);
    set(HTP4,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
    scatter(BCD(1,NDvalInd),MassV./CHV(1,NDvalInd),HTDotSize,'o','MarkerFaceColor', HTClr, 'MarkerEdgeColor', HTClr)
    hold(HTP4,'on');
    ylbHTP4 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlim(NDlims);
    set(HTP4,'xtick',Dticks,'xticklabel',DtickLabels);
    xlbHTP4 = xlabel('$D$','Interpreter','latex');
    HTP4.FontSize = PlotFont;
    xlbHTP4.FontSize = LabelFont;
    ylbHTP4.FontSize = LabelFont;
    hold(HTP4,'off');
end