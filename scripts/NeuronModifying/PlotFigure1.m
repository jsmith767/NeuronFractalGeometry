
% figure('Position',[0,0,600,1000])
figure('Position',[0,0,1800,1200])
%% get Lengths
% numBins = 10;
% % 
% % t = extractfield(masterN,'SLA')';
% t = extractfield(plottingN,'SLA')';
% N = zeros(length(t),numBins);
% SLA = cell(size(t));
% L = cell(size(t));
% Ln = cell(size(t));
% for i=1:length(t)
%         SLA{i,1} = vertcat(t{i}{:});
%         L{i,1} = SLA{i,1}(:,1);
%         Ln{i,1} = L{i}/max(L{i});
%         N(i,:) = histcounts(Ln{i},numBins);
% end
% Nave = mean(N,1);
% normLengths = vertcat(Ln{:});
% 
% figure
% axLength = axes('Position',[0.1,0.1,0.4,0.3]);

%%
fs = 50;
fsl = fs+10;
fsLegend = fsl+10;


axLength = axes('Position',[0.11,0.3,0.4,0.6]);

c3 = [0 125 0]/255;
b = bar(0:0.1:0.9,Nave,'histc');
b.FaceColor = c3;
b.FaceAlpha = 1;
b.LineWidth = 2;
ylim([0 max(Nave)+2]);
% bar(0:0.1:0.9,Nave,'FaceColor',c3,'FaceAlpha',1,'histc')
% histogram(normLengths,10,'FaceColor',c3,'FaceAlpha',1)
% set(axLength,'ytick',[],'yticklabel',[],'ycolor','black');
% set(axLength,'xtick',[],'xticklabel',[],'xcolor','black');
% xticklabels({0,[],[],[],[],0.5,[],[],[],1})
xticks([0.3  0.7])
yticks([0 4 8 12])
% xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'})
% yticklabels({})
axLength.FontSize = fs;
ylabel('$N_a$','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize', fsl,'Interpreter','latex');
xlabel('$L/L_{max}$','FontSize', fsl,'Interpreter','latex');
yyaxis right
set(axLength,'ytick',[],'yticklabel',[],'ycolor','black');
set(axLength,'TickDir','out');
set(axLength,'LineWidth',2,'TickLength',[0.02 0.02]);
% set(axLength,'XAxisLocation','top', 'XTick', []);
% set(gca,'box','off')
a = gca;
% set box property to off and remove background color
set(a,'box','off','color','none')
% create new, empty axes with box but without ticks
c = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[],'LineWidth',2);
% set original axes as active
axes(a)
% link axes in case of zooming
linkaxes([a c])

%%
% figure
blue = [0,0.3,1];
red = [0.8,0,0];
bothColors = [0.5 0 0.5];
axD = axes('Position',[0.5,0.3,0.4,0.6],'YAxisLocation','right');

yyaxis right
% yyaxis(axD,'right')
[NA,EA] = histcounts(ApicalD,7);
% bA = bar(NA,'histc');
% bA.FaceColor = blue;
% bA.FaceAlpha = 0.5;
% histogram(ApicalD,EA,'FaceColor',blue,'LineWidth',2,'FaceAlpha',1)
hold
yyaxis right
yticks([0 20 40 60])
[NB,EB] = histcounts(BasalD,EA);
% bB = bar(NB,'histc');
% bB.FaceColor = red;
% bB.FaceAlpha = 0.5;
% histogram(BasalD,EB,'FaceColor',red,'LineWidth',2,'FaceAlpha',1)
both = zeros(length(NB),1);
for i=1:length(NB)
    both(i) = min([NB(i) NA(i)]);
end
% bar(both,EA(2:end-1));
% histogram('BinCounts',both,'BinEdges',EA,'FaceColor',bothColors,'FaceAlpha',1,'LineWidth',2)
% histogram(1.4:1.5,'FaceColor',red)
% histogram([],'FaceColor',red)

b = bar(mEA,[NA;NB]','barwidth',1);
b(1).FaceColor = blue;
b(2).FaceColor = red;

set(gca,'ycolor','black');
yyaxis left
set(gca,'ytick',[]);
set(gca,'ycolor','black');

xticks([1.4 1.5])
% set(axD,'ycolor','black');
% set(axD,'xtick',[],'xticklabel',[],'xcolor','black');
yyaxis right
set(axD,'FontSize', fs);
% set(axD,'box','off');
% yyaxis right
% set(axD,'ytick',[],'yticklabel',[],'ycolor','black');
% set(axD,'ycolor','black');
ylabel('$N$','Rotation',0,'HorizontalAlignment','left','VerticalAlignment','middle','FontSize', fsl,'Interpreter','latex');
% set(gca,'ytick',[]);
xlabel('$D$','FontSize', fsl,'Interpreter','latex');
set(axD,'TickDir','out');
set(axD,'LineWidth',2,'TickLength',[0.02 0.02]);

% yticklabels({})
legend({'Apical','Basal','Overlap'},'fontsize',fsLegend)
legend boxoff     
% yyaxis left
% % set(axD,'ytick',[],'yticklabel',[],'ycolor','black');

% d = gca;
% % set box property to off and remove background color
set(axD,'box','off','color','none')
% % create new, empty axes with box but without ticks
e = axes('Position',get(axD,'Position'),'box','on','xtick',[],'ytick',[],'LineWidth',2);
% % set original axes as active
axes(axD)
% % link axes in case of zooming
% linkaxes([axD e])
set(gcf, 'Color', 'w');
export_fig Hist.png -m3


%%
figure
% figure('Position',[1000,0,800,700])
%Polar histogram
% [D,A,IA,WA,SA] = AvgAngleVsD(masterN);
% wa = vertcat(WA{5}{:});
% sa = vertcat(SA{5}{:});

% c1 = [0.4940 0.1840 0.5560];
% c2 = [0.5569 0.5255 0.1843];
% axAngle = axes('Position',[0.1,0.37,0.25,0.25]);
axAngle = axes('Position',[.2,0.3,0.6,0.5]);
c2 = [0 0 1];
% c1 = [247 138 35]/255;
c1 = [1 0 0];

polarhistogram(sa,40,'normalization','probability','FaceColor',c1,'FaceAlpha',0.85)
hold
polarhistogram(wa,100,'normalization','probability','FaceColor',c2,'FaceAlpha',0.85)
pax = gca;
set(gca,'LineWidth',2,'GridAlpha',0.5);
% pax.ThetaAxisUnits = 'radians';
% pax.ThetaLim = [0 pi/2];
pax.ThetaLim = [0 90];
thetaticklabels({['0' char(176)],['30' char(176)],['60' char(176)],['90' char(176)]})
% thetaticklabels({'0^0','30^0','60^0','90^0'})
pax.FontSize = 26;
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
% pax.TickLabelInterpreter = 'latex';
% pax.RAxis.Label.String = texlabel('N_{n}');
% pax.rcolor = 'black';
rticklabels({})
rl = rlim;
r = [rl(2) rl(2)-.005];
th1 = [median(sa) median(sa)] ;
th2 = [median(wa) median(wa)];
tickwidth = 6;
% polarplot(th1,r,'-','color',c1,'MarkerSize',10,'LineWidth', tickwidth)
% polarplot(th2,r,'-','color',c2,'MarkerSize',10,'LineWidth', tickwidth)
set(gcf, 'Color', 'w');
export_fig Angle.png -m3