% Groups = extractfield(plottingN,'Group');
% Groups = unique(Groups);
% 
% for i = 1:232
%     
% end

clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr2 = [[255 20 20];[30 30 180]]/255;
NClr = clr2(2,:);
NNClr = clr2(1,:);
BckClr = [255 255 255]/255;
NDotSize = 5;
NNDotSize = 12;
NNInd = 5;
NDlims = [1.3 1.53];
% NYlims = [0.6 1.2];
PlotFont = 18;
LabelFont = 30;

% figure;
% NP1 = axes('Box','on','Color',BckClr);
% scatter(D,P./SA,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
% hold(NP1,'on');
% % scatter(BDbyM(NNInd,:),BPbyM(NNInd,:)./BSAbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
% xlim(NDlims);
% ylim(NYlims);
% ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
% xlbNP1 = xlabel('D','Interpreter','latex');
% scatter(pD,pP./pSA,NDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
% % scatter(pBDbyM(NNInd,:),pBPbyM(NNInd,:)./pBSAbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
% NP1.FontSize = PlotFont;
% xlbNP1.FontSize = LabelFont;
% ylbNP1.FontSize = LabelFont;

figure;
NP1 = axes('Box','on','Color',BckClr);
hold(NP1,'on');
for g = 4:size(Groups,2)
%     scatter(D,P./SA,NDotSize,'o','MarkerFaceColor', NClr, 'MarkerEdgeColor', NClr)
    if strcmp(GInfo{3,g},'filled')
        scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSAbyM(NNInd,GInfo{1,g}),75,GInfo{4,g},'MarkerFaceColor', GInfo{2,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BSAbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor', GInfo{2,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor', GInfo{2,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BVMbyM(NNInd,GInfo{1,g})./BVbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor', GInfo{2,g},'MarkerEdgeColor', GInfo{2,g})
    else
        scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSAbyM(NNInd,GInfo{1,g}),75,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BSAbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g})
%         scatter(BDbyM(NNInd,GInfo{1,g}),BVMbyM(NNInd,GInfo{1,g})./BVbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g})
        
    end
    xlim(NDlims);
%     ylim(NYlims);
    ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
%     ylbNP1 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
%     ylbNP1 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
%     ylbNP1 = ylabel('$\frac{V_b-V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
%     ylbNP1 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
    xlbNP1 = xlabel('D','Interpreter','latex');
%     scatter(pD,pP./pSA,NDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
%     scatter(pBDbyM(NNInd,:),pBPbyM(NNInd,:)./pBSAbyM(NNInd,:),NNDotSize,'o','MarkerFaceColor', NNClr, 'MarkerEdgeColor', NNClr)
    NP1.FontSize = PlotFont;
    xlbNP1.FontSize = LabelFont;
    ylbNP1.FontSize = LabelFont;
end
legend({Groups{1,4} Groups{1,5} Groups{1,6}})

% latlonview = [1.8;122.9];
% 
% HModel = cell(1,its);
% HMview = cell(1,its);
% for i = 1:its
%     HModel{1,i} = HTreeM(HTreeM(:,4)==i,1:3);
%     HMview{1,i} = HModel{1,i};
%     for d = 1:size(HMview{1,i},1)
%         HMview{1,i}(d,1:3) = rotationmat3D(-latlonview(1,1),[cos(pi/2+latlonview(2,1)) sin(pi/2+latlonview(2,1)) 0])*HMview{1,i}(d,:)';
%     end
% end
% figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
% ax1 = axes('Position',ax1loc,'Box','on','Color',BckClr);
% % treeim = imread('K:\Keck\Programs\Profiles\FinalFigures_4-25-19\HTreeOutline - Copy.png');
% % imshow(treeim);
% axis equal;
% axis off;
% grid off;
% set(gca,'CameraViewAngleMode','Manual','color','none');
% hold;
% for i = 1:its
%     scatter3(HMview{1,i}(:,1),HMview{1,i}(:,2),HMview{1,i}(:,3),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
% end