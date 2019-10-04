%Fixing Scaling Plot

%load the scaling plot '3_0001ScalingPlotLargeClean.fig'

%get x and y data if you want to see
% h = findobj(gca,'Type','scatter');
% x=get(h,'Xdata');
% y=get(h,'Ydata');


% %get the longest Branch from the desired neuron
% SLA = extractfield(masterN(71),'SLA');
% SLA = vertcat(SLA{:});
% SLA = SLA'; %added for some masters
% SLA = vertcat(SLA{:}); %added for some masters
% L = SLA(:,1);
% Lmax = max(L);

% xn = -x-log10(Lmax);

%or just load '3_0001data.mat'
fs = 30;
fsl = 36;
figure('units','normalized','outerposition',[0 0 1 1])
hold
scatter(xn,y,'filled')
yticks([0 2 4 6])
xticks([-3 -2 -1 0])
set(gca,'fontsize',fs+3);
xlabel('$log(L_{box}/L_{max})$','interpreter','latex','Units', 'Normalized', 'Position', [0.5, -0.07, 0],'FontSize',fsl);
ylabel('$log(N_{box})$','interpreter','latex','Rotation',0,'Units', 'Normalized', 'Position', [-0.07, 0.5, 0],'FontSize',fsl);



dim1 = [0.302626050420167,0.72882472224753,0.069384597021049,0.052279634388747];
str1 = '$D=2$';
annotation('textbox',dim1,'String',str1,'FitBoxToText','on','FontSize',fsl,'EdgeColor',[1,1,1],'interpreter','latex');
dim2 = [0.528886554621847,0.493627153858469,0.083545858790655,0.052279634388747];
str2 = '$D=1.4$';
annotation('textbox',dim2,'String',str2,'FitBoxToText','on','FontSize',fsl,'EdgeColor',[1,1,1],'interpreter','latex');
dim3 = [0.760281512605041,0.155876393980049,0.069384597021049,0.052279634388747];
str3 = '$D=3$';
annotation('textbox',dim3,'String',str3,'FitBoxToText','on','FontSize',fsl,'EdgeColor',[1,1,1],'interpreter','latex');

xA1 = [0.406,0.406];   % adjust length and location of arrow 
yA1 = [0.615+0.05,0.615];
annotation('textarrow',xA1,yA1,'FontSize',fs,'Linewidth',2)

xA2 = [0.7,0.7];   % adjust length and location of arrow 
yA2 = [0.275,0.275+0.05];
annotation('textarrow',xA2,yA2,'FontSize',fs,'Linewidth',2)

p1 = polyfit(xn(1:7),y(1:7),1);
x1 = linspace(xn(7),xn(1));
y1 = polyval(p1,x1);
plot(x1,y1,'Linewidth',2,'color','r')

p2 = polyfit(xn(70:97),y(70:97),1);
x1 = linspace(xn(70),xn(97));
y1 = polyval(p2,x1);
plot(x1,y1,'Linewidth',2,'color','r')

p3 = polyfit(xn(30:63),y(30:63),1);
x1 = linspace(xn(30),xn(63));
y1 = polyval(p3,x1);
plot(x1,y1,'Linewidth',2,'color','r')

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
% linkaxes([a c])
export_fig 3_0001ScalingPlot-Aug-22.png -m3

%where do new ticks lie
% xtnew = [0 1 2 3];
% xt = xtnew-log10(Lmax);
% xticks(xt)
% xticklabels({'0','1','2','3'})
% yticks([0 2 4 6])
% xlabel('log($L_{max}/L_{b}$)','interpreter','latex','Units', 'Normalized', 'Position', [0.5, -0.07, 0])
% ylabel('log($N$)','interpreter','latex','Rotation',0,'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
% set(gcf, 'Color', 'w');
% set(gca,'box','on')
% % set(gca,'box','off')
% a = gca;
% % set box property to off and remove background color
% set(a,'box','off','color','none')
% % create new, empty axes with box but without ticks
% c = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[],'LineWidth',2);
% % set original axes as active
% axes(a)
% % link axes in case of zooming
% linkaxes([a c])
% export_fig 3_0001ScalingPlot-June.png -m3