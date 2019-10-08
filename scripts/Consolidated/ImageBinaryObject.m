BinaryMod = RGMod;

rI = cell(1,size(BinaryMod,3));
cI = cell(1,size(BinaryMod,3));
tI = cell(1,size(BinaryMod,3));
for z = 1:size(BinaryMod,3)
    [rI{1,z},cI{1,z}] = find(BinaryMod(:,:,z));
    tI{1,z} = zeros(size(rI{1,z},1),1);
    tI{1,z}(:,1) = z;
end

count = 0;
for z = 1:size(BinaryMod,3)
    count = count + size(tI{1,z},1);
end
UBModel = zeros(count,3);
count1 = 0;
count2 = 0;
for z = 1:size(BinaryMod,3)
    count1 = count2 + 1;
    count2 = count2 + size(tI{1,z},1);
    UBModel(count1:count2,1:3) = [rI{1,z} cI{1,z} tI{1,z}];
end

figure;
scatter3(UBModel(:,1),UBModel(:,2),UBModel(:,3),'k.');
axis equal;axis off;grid off;set(gca,'CameraViewAngleMode','Manual','color','none');

% % figure;
% % NP3 = axes('Position',[0.1 0.1 0.85 0.85],'Color',BckClr);
% % % NP3i = annotation('textbox',NP3iloc,'String',NP3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
% % yyaxis right;
% % set(NP3,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
% % yyaxis left;
% % set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
% % scatter(D{1,1},P{1,1}./BA{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
% % hold(NP3,'on');
% % scatter(D{1,2},P{1,2}./BA{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
% % scatter(BDbyM{1,1}(NNInd,:),BPbyM{1,1}(NNInd,:)./BBAbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
% % xlim(NDlims);
% % % ylim(plotrangeCoBA)
% % set(NP3,'xtick',[],'xticklabel',[]);
% % NP3.XRuler.Axle.LineWidth = XaxWidth;
% % ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
% % % set(NP3,'ytick',Ny3Ticks,'yticklabel',Ny3TickLabels);
% % NP3.FontSize = PlotFont;
% % xlbNP3.FontSize = LabelFont;
% % ylbNP3.FontSize = LabelFont;
% % hold(NP3,'off');
% % 
% % figure;
% % NP3 = axes('Position',[0.1 0.1 0.85 0.85],'Color',BckClr);
% % % NP3i = annotation('textbox',NP3iloc,'String',NP3I,'LineStyle','none','Color',[0 0 0]/255,'FontSize',LabelFont);
% % yyaxis right;
% % set(NP3,'ytick',[],'yticklabel',[],'ycolor',[0 0 0]/255)
% % yyaxis left;
% % set(NP3,'ycolor',[0 0 0]/255,'LineWidth',YaxWidth);
% % scatter(D{1,1},P{1,1}./SAB{1,1},NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
% % hold(NP3,'on');
% % scatter(D{1,2},P{1,2}./SAB{1,2},NDotSize,'o','MarkerFaceColor', NPClr, 'MarkerEdgeColor', NPClr)
% % scatter(BDbyM{1,1}(NNInd,:),BPbyM{1,1}(NNInd,:)./BSABbyM{1,1}(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
% % xlim(NDlims);
% % % ylim(plotrangeCoBA)
% % set(NP3,'xtick',[],'xticklabel',[]);
% % NP3.XRuler.Axle.LineWidth = XaxWidth;
% % ylbNP3 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
% % % set(NP3,'ytick',Ny3Ticks,'yticklabel',Ny3TickLabels);
% % NP3.FontSize = PlotFont;
% % xlbNP3.FontSize = LabelFont;
% % ylbNP3.FontSize = LabelFont;
% % hold(NP3,'off');