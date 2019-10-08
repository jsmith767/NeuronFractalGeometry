clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr2 = [[255 20 20];[30 30 180]]/255;
NClr = clr2(2,:);
NNClr = clr2(1,:);
BckClr = [255 255 255]/255;
NDotSize = 5;
NNDotSize = 12;
NNInd = 5;
NDlims = [1.3 1.53];
Drange = NDlims(1):0.01:NDlims(2);
% NYlims = [0.6 1.2];
PlotFont = 18;
LabelFont = 30;
Plot11 = 0; % All Groups
Plot12 = 0;
Plot13 = 0;
Plot14 = 0;
Plot21 = 0; % Healthy vs Unhealthy
Plot22 = 0;
Plot23 = 0;
Plot24 = 0;
Plot31 = 0; % Trained vs Pseudotrained
Plot32 = 0;
Plot33 = 0;
Plot34 = 0;
Plot41 = 0; % Enriched Housing vs Standard Housing
Plot42 = 0;
Plot43 = 0;
Plot44 = 0;
PlotH1 = 1; % Left Hemisphere vs Right Hemisphere
PlotH2 = 1;
PlotH3 = 1;
PlotH4 = 1;

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

if Plot11 == 1
    figure;
    NP1 = axes('Box','on','Color',BckClr);
    np1 = cell(1,size(Groups,2));
    hold(NP1,'on');
    for g = 1:size(Groups,2)
        if strcmp(GInfo{3,g},'filled')
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSAbyM(NNInd,GInfo{1,g}),75,GInfo{4,g},'MarkerFaceColor', GInfo{2,g},'MarkerEdgeColor', GInfo{2,g});
        else
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSAbyM(NNInd,GInfo{1,g}),75,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g});
        end
        xlim(NDlims);
        ylbNP1 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP1 = xlabel('$D$','Interpreter','latex');
        NP1.FontSize = PlotFont;
        xlbNP1.FontSize = LabelFont;
        ylbNP1.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSAbyM(NNInd,GInfo{1,g}),1);
        plot(NP1,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',GInfo{2,g},'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np1{1,1} np1{1,2} np1{1,3} np1{1,4} np1{1,5} np1{1,6}],{Groups{1,1} Groups{1,2} Groups{1,3} Groups{1,4} Groups{1,5} Groups{1,6}});
end
if Plot12 == 1
    figure;
    NP1 = axes('Box','on','Color',BckClr);
    np1 = cell(1,size(Groups,2));
    hold(NP1,'on');
    for g = 1:size(Groups,2)
        if strcmp(GInfo{3,g},'filled')
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BSAbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor',GInfo{2,g},'MarkerEdgeColor', GInfo{2,g});
        else
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BSAbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g});

        end
        xlim(NDlims);
        ylbNP1 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP1 = xlabel('$D$','Interpreter','latex');
        NP1.FontSize = PlotFont;
        xlbNP1.FontSize = LabelFont;
        ylbNP1.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,GInfo{1,g}),BSAbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),1);
        plot(NP1,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',GInfo{2,g},'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np1{1,1} np1{1,2} np1{1,3} np1{1,4} np1{1,5} np1{1,6}],{Groups{1,1} Groups{1,2} Groups{1,3} Groups{1,4} Groups{1,5} Groups{1,6}});
end
if Plot13 == 1
    figure;
    NP1 = axes('Box','on','Color',BckClr);
    np1 = cell(1,size(Groups,2));
    hold(NP1,'on');
    for g = 1:size(Groups,2)
        if strcmp(GInfo{3,g},'filled')
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor',GInfo{2,g},'MarkerEdgeColor', GInfo{2,g});
        else
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g});
        end
        xlim(NDlims);
        ylbNP1 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP1 = xlabel('$D$','Interpreter','latex');
        NP1.FontSize = PlotFont;
        xlbNP1.FontSize = LabelFont;
        ylbNP1.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,GInfo{1,g}),BPbyM(NNInd,GInfo{1,g})./BSABbyM(NNInd,GInfo{1,g}),1);
        plot(NP1,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',GInfo{2,g},'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np1{1,1} np1{1,2} np1{1,3} np1{1,4} np1{1,5} np1{1,6}],{Groups{1,1} Groups{1,2} Groups{1,3} Groups{1,4} Groups{1,5} Groups{1,6}});
end
if Plot14 == 1
    figure;
    NP1 = axes('Box','on','Color',BckClr);
    np1 = cell(1,size(Groups,2));
    hold(NP1,'on');
    for g = 1:size(Groups,2)
        if strcmp(GInfo{3,g},'filled')
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BVMbyM(NNInd,GInfo{1,g})./BVbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerFaceColor',GInfo{2,g},'MarkerEdgeColor', GInfo{2,g});
        else
            np1{1,g} = scatter(BDbyM(NNInd,GInfo{1,g}),BVMbyM(NNInd,GInfo{1,g})./BVbyM(NNInd,GInfo{1,g}),50,GInfo{4,g},'MarkerEdgeColor', GInfo{2,g});
        end
        xlim(NDlims);
        ylbNP1 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP1 = xlabel('$D$','Interpreter','latex');
        NP1.FontSize = PlotFont;
        xlbNP1.FontSize = LabelFont;
        ylbNP1.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,GInfo{1,g}),BVMbyM(NNInd,GInfo{1,g})./BVbyM(NNInd,GInfo{1,g}),1);
        plot(NP1,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',GInfo{2,g},'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np1{1,1} np1{1,2} np1{1,3} np1{1,4} np1{1,5} np1{1,6}],{Groups{1,1} Groups{1,2} Groups{1,3} Groups{1,4} Groups{1,5} Groups{1,6}});
end

if Plot21 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,4} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,2} | GInfo{1,3}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Healthy' 'Unhealthy'});
end
if Plot22 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,4} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,2} | GInfo{1,3}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Healthy' 'Unhealthy'});
end
if Plot23 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,4} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,2} | GInfo{1,3}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Healthy' 'Unhealthy'});
end
if Plot24 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,4} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,2} | GInfo{1,3}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Healthy' 'Unhealthy'});
end

if Plot31 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,2} | GInfo{1,3} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,4}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Trained' 'Pseudotrained'});
end
if Plot32 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,2} | GInfo{1,3} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,4}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Trained' 'Pseudotrained'});
end
if Plot33 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,2} | GInfo{1,3} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,4}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Trained' 'Pseudotrained'});
end
if Plot34 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,2} | GInfo{1,3} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,4}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Trained' 'Pseudotrained'});
end

if Plot41 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,1} | GInfo{1,2} | GInfo{1,4} | GInfo{1,5} GInfo{1,3} | GInfo{1,6}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSAbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Enriched' 'Standard'});
end
if Plot42 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,1} | GInfo{1,2} | GInfo{1,4} | GInfo{1,5} GInfo{1,3} | GInfo{1,6}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BSAbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Enriched' 'Standard'});
end
if Plot43 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,1} | GInfo{1,2} | GInfo{1,4} | GInfo{1,5} GInfo{1,3} | GInfo{1,6}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BPbyM(NNInd,pltgrp{1,g})./BSABbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Enriched' 'Standard'});
end
if Plot44 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Groups,2));
    hold(NP2,'on');
    pltgrp = {GInfo{1,1} | GInfo{1,2} | GInfo{1,4} | GInfo{1,5} GInfo{1,3} | GInfo{1,6}};
    for g = 1:2
        if strcmp(GInfo{3,g},'filled')
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerFaceColor', clr2(g,:),'MarkerEdgeColor', clr2(g,:));
        else
            np2{1,g} = scatter(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),75,GInfo{4,g},'MarkerEdgeColor', clr2(g,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,pltgrp{1,g}),BVMbyM(NNInd,pltgrp{1,g})./BVbyM(NNInd,pltgrp{1,g}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(g,:),'LineWidth',2);
    end
    % legend([np1{1,4} np1{1,5} np1{1,6}],{'SH-ENR-PS' 'SH-ENR-TR' 'SH-STD-TR'});
    legend([np2{1,1} np2{1,2}],{'Enriched' 'Standard'});
end

if PlotH1 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Hemis,2));
    hold(NP2,'on');
    plthem = {HInfo{1,1} HInfo{1,2}};
    for h = 1:2
        if strcmp(HInfo{3,h},'filled')
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSAbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerFaceColor', clr2(h,:),'MarkerEdgeColor', clr2(h,:));
        else
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSAbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerEdgeColor', clr2(h,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_s}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSAbyM(NNInd,plthem{1,h}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(h,:),'LineWidth',2);
    end
    legend([np2{1,1} np2{1,2}],{'Left' 'Right'});
end
if PlotH2 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Hemis,2));
    hold(NP2,'on');
    plthem = {HInfo{1,1} HInfo{1,2}};
    for h = 1:2
        if strcmp(HInfo{3,h},'filled')
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BSAbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerFaceColor', clr2(h,:),'MarkerEdgeColor', clr2(h,:));
        else
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BSAbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerEdgeColor', clr2(h,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{A_s}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,plthem{1,h}),BSAbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(h,:),'LineWidth',2);
    end
    legend([np2{1,1} np2{1,2}],{'Left' 'Right'});
end
if PlotH3 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Hemis,2));
    hold(NP2,'on');
    plthem = {HInfo{1,1} HInfo{1,2}};
    for h = 1:2
        if strcmp(HInfo{3,h},'filled')
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerFaceColor', clr2(h,:),'MarkerEdgeColor', clr2(h,:));
        else
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerEdgeColor', clr2(h,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{P}{A_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,plthem{1,h}),BPbyM(NNInd,plthem{1,h})./BSABbyM(NNInd,plthem{1,h}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(h,:),'LineWidth',2);
    end
    legend([np2{1,1} np2{1,2}],{'Left' 'Right'});
end
if PlotH4 == 1
    figure;
    NP2 = axes('Box','on','Color',BckClr);
    np2 = cell(1,size(Hemis,2));
    hold(NP2,'on');
    plthem = {HInfo{1,1} HInfo{1,2}};
    for h = 1:2
        if strcmp(HInfo{3,h},'filled')
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BVMbyM(NNInd,plthem{1,h})./BVbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerFaceColor', clr2(h,:),'MarkerEdgeColor', clr2(h,:));
        else
            np2{1,h} = scatter(BDbyM(NNInd,plthem{1,h}),BVMbyM(NNInd,plthem{1,h})./BVbyM(NNInd,plthem{1,h}),75,HInfo{4,h},'MarkerEdgeColor', clr2(h,:));
        end
        xlim(NDlims);
        ylbNP2 = ylabel('$\frac{V_m}{V_b}$','Interpreter','latex','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle');
        xlbNP2 = xlabel('$D$','Interpreter','latex');
        NP2.FontSize = PlotFont;
        xlbNP2.FontSize = LabelFont;
        ylbNP2.FontSize = LabelFont;

        Groupfit = polyfit(BDbyM(NNInd,plthem{1,h}),BVMbyM(NNInd,plthem{1,h})./BVbyM(NNInd,plthem{1,h}),1);
        plot(NP2,Drange,(Groupfit(1)*Drange)+Groupfit(2),'-','Color',clr2(h,:),'LineWidth',2);
    end
    legend([np2{1,1} np2{1,2}],{'Left' 'Right'});
end