CumMassD = zeros(9,105);
CumMassReg = cell(9,105);
for i = 1:105
    for j = 1:9
        CumMassReg{j,i} = fitwrapperBounds_Mass(Radius,Mass{j,i},4,15,11);
        CumMassD(j,i) = CumMassReg{j,i}.D;
    end
end

DMcell = zeros(BNumMods,size(plottingN,2));
for c = 1:BNumMods
    for n = 1:size(plottingN,2)
        DMcell(c,n) = CumMassD(c,n);
    end
end
DM = zeros((BNumMods)*size(plottingN,2),1);

count = 0;
for i = 1:BNumMods
    jsub = 0;
    if i > 0
        for j = 1:size(plottingN,2)
                count = count + 1;
                DM(count,1) = DMcell(i,j-jsub);
        end
    end
end

NP1 = axes('Position',[0.15 0.15 0.8 0.8],'Box','on','Color',BckClr);
yyaxis right;
set(NP1,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
yyaxis left;
set(NP1,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
scatter(DM,P{1,1}./SA{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
hold(NP1,'on');
scatter(DMcell(NNInd,:),BPbyM{1,1}(NNInd,:)./BSAbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
NP1.XRuler.Axle.LineWidth = XaxWidth;
%     ylbNP1 = ylabel('$\frac{P}{A_S}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
NP1.FontSize = PlotFont;
xlbNP1.FontSize = LabelFont;
ylbNP1.FontSize = LabelFont;
hold(NP1,'off');