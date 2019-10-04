%Fixing Scaling Plot

%load the scaling plot '3_0001ScalingPlotLargeClean.fig'

%get x and y data if you want to see
% h = findobj(gca,'Type','scatter');
% x=get(h,'Xdata');
% y=get(h,'Ydata');

% let's work with the tick data instead.
% xt = xticks;

% %get the longest Branch from the desired neuron
% SLA = extractfield(masterN(71),'SLA');
% SLA = vertcat(SLA{:});
% L = SLA(:,1);
% Lmax = max(L);

% xt = log10(1/L)

%if we want Lnew = log10(Lmax/L)
%then xt = xtnew-log10(Lmax)

%where do new ticks lie
xtnew = [0 1 2 3];
xt = xtnew-log10(Lmax);
xticks(xt)
xticklabels({'0','1','2','3'})
yticks([0 2 4 6])
xlabel('log($L_{max}/L_{b}$)','interpreter','latex','Units', 'Normalized', 'Position', [0.5, -0.07, 0])
ylabel('log($N$)','interpreter','latex','Rotation',0,'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gcf, 'Color', 'w');
set(gca,'box','on')
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
export_fig 3_0001ScalingPlot-June.png -m3