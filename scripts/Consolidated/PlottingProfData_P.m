% load('D:\SharedProjects\Consolidated\plottingN.mat');

BNumMods = size(plottingN(1).data.P,2);
Fcell = extractfield(plottingN,'name');
for i = 1:BNumMods
    for j = 1:size(Fcell,2)
        Fcell{i,j} = Fcell{1,j};
    end
end
Dcell = cell(BNumMods,size(plottingN,2));
Vcell = cell(BNumMods,size(plottingN,2));
Pcell = cell(BNumMods,size(plottingN,2));
Mcell = cell(BNumMods,size(plottingN,2));
Lcell = cell(1,size(plottingN,2));
for c = 1:BNumMods
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.P(c).Ddata)
                Dcell{c,n} = plottingN(n).data.P(c).Ddata.reg.D;
                Vcell{c,n} = plottingN(n).data.P(c).volume;
                Pcell{c,n} = plottingN(n).data.P(c).AveP;
                Mcell{c,n} = plottingN(n).data.P(c).mass;
            end
        end
    end
end
for n = 1:size(plottingN,2)
    if ~isempty(plottingN(n).data)
        Lcell{1,n} = plottingN(n).TL;
    end
end
IF = ~cellfun(@isempty,Fcell);
ID = ~cellfun(@isempty,Dcell);
IV = ~cellfun(@isempty,Vcell);
IP = ~cellfun(@isempty,Pcell);
IM = ~cellfun(@isempty,Mcell);
IL = ~cellfun(@isempty,Lcell);
Index = and(IF,ID);
Index = and(Index,IV);
Index = and(Index,IP);
Index = and(Index,IM);
UseIndex = 1;
checknum = sum(Index(UseIndex,:));
for i = 1:BNumMods
    if checknum > sum(Index(i,:))
        checknum = sum(Index(i,:));
        UseIndex = i;
    end
end
BFbyM = cell(1,sum(Index(UseIndex,:)));
BDbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
D = zeros(BNumMods*sum(Index(UseIndex,:)),1);
BVbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
V = zeros(BNumMods*sum(Index(UseIndex,:)),1);
BPbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
P = zeros(BNumMods*sum(Index(UseIndex,:)),1);
BMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
M = zeros(BNumMods*sum(Index(UseIndex,:)),1);
BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
L = zeros(BNumMods*sum(Index(UseIndex,:)),1);
count = 0;
BAveNatVol = mean(vertcat(Vcell{5,Index(UseIndex,:)}));
for i = 1:BNumMods
    BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
    BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)})./BAveNatVol;
    BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
    BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
    BLbyM(i,:) = vertcat(Lcell{1,Index(UseIndex,:)});
    
    jsub = 0;
    for j = 1:size(plottingN,2)
        if Index(UseIndex,j)
            count = count + 1;
            D(count,1) = BDbyM(i,j-jsub);
            V(count,1) = BVbyM(i,j-jsub);
            P(count,1) = BPbyM(i,j-jsub);
            M(count,1) = BMbyM(i,j-jsub);
            L(count,1) = BLbyM(i,j-jsub);
        else
            jsub = jsub+1;
        end
    end
end
jsub = 0;
for j = 1:size(plottingN,2)
    if Index(UseIndex,j)
        BFbyM{1,j-jsub} = plottingN(j).name;
    else
        jsub = jsub+1;
    end
end

% The following plots Potential Connectivity (\sigma) vs Fractal Dimension
% (D) as well as Volume (V) vs D using data from all the different
% modifications
binRange = [1.33 1.57];
Numbins = 9;
fit1end = 4;
[DAve, DDev, PAve, PDev] = BinDatabyD(binRange,Numbins,D,P./M);
[~, ~, RPAve, RPDev] = BinDatabyD(binRange,Numbins,D,P);
[~, ~, VAve, VDev] = BinDatabyD(binRange,Numbins,D,1./V);
[~, ~, MAve, MDev] = BinDatabyD(binRange,Numbins,D,M);
% Pfit1 = polyfit(DAve(1:1:fit1end),PAve(1:1:fit1end),1);
% Pfit2 = polyfit(DAve(fit1end+1:1:Numbins),PAve(fit1end+1:1:Numbins),1);
% Drange1 = 1.35:0.01:1.47;
% Drange2 = 1.44:0.01:1.65;
figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
subplot(2,1,1)
ax1P = gca;
ax1P.FontSize = 18;
ax1PL.FontSize = 22;
ay1PL.FontSize = 22;
hold(ax1P,'on');
ttl1 = title('Basal (Original)');
ttl1.FontSize = 26;
% plot(Drange1,(Pfit1(1)*Drange1)+Pfit1(2),'k--','LineWidth',2);
% plot(Drange2,(Pfit2(1)*Drange2)+Pfit2(2),'k--','LineWidth',2);
xlabel('Fractal Dimension (D)')
ylb1P = ylabel('Potential Connectivity (\sigma)');
set(ylb1P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
xlim([1.33 1.58])
ylim([0.19 0.36])
errorbar(DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
subplot(2,1,2)
errorbar(DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
ax1V = gca;
ax1V.FontSize = 18;
ax1VL.FontSize = 22;
ay1VL.FontSize = 22;
xlabel('Fractal Dimension (D)')
ylb1V = ylabel('Volume^-^1 (1/V)');
set(ylb1V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
xlim([1.33 1.58])
ylim([0 6])
hold(ax1P,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);

% The following creates scatter plots of \sigma vs D and V vs D with the
% different modifications having different colors
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120]]/255;
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
clr2 = [[161 30 34]/255;[232 166 49]/255];
% order = [2,3,4,5,6,7,8,9];
% Corder = ["0.25" "0.50" "0.75" "1.00" "1.25" "1.50" "1.75" "2.00"];
order = [1,2,3,4,5,6,7,8,9];
Corder = ["0.00" "0.25" "0.50" "0.75" "1.00" "1.25" "1.50" "1.75" "2.00"];
plotrangex = [1.33 1.58];
plotrangepro = [0.19 0.36];
plotrangevol = [0 6];
figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax2P = subplot(2,1,1);
hold(ax2P,'on');
% set(ax2P,'FontSize',12);
% plot(ax2P,Drange1,(Pfit1(1)*Drange1)+Pfit1(2),'k--','LineWidth',2);
% plot(ax2P,Drange2,(Pfit2(1)*Drange2)+Pfit2(2),'k--','LineWidth',2);
xlb2P = xlabel('Fractal Dimension (D)');
ylb2P = ylabel('Potential Connectivity (\sigma)');
set(ylb2P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax2P.FontSize = 18;
ax2PL.FontSize = 22;
ay2PL.FontSize = 22;
ttl2 = title('Basal (Original)');
ttl2.FontSize = 26;
for i = 1:BNumMods
    scatter(ax2P,BDbyM(order(i),:),BPbyM(order(i),:)./BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax2P,DAve,PAve,PDev,PDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
ylim(plotrangepro)
lgd2 = legend(Corder);
lgd2.FontSize = 16;
hold(ax2P,'off');
ax2V = subplot(2,1,2);
hold(ax2V,'on');
xlb2V = xlabel('Fractal Dimension (D)');
ylb2V = ylabel('Volume^-^1 (1/V)');
set(ylb2V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax2V.FontSize = 18;
ax2VL.FontSize = 22;
ay2VL.FontSize = 22;
for i = 1:BNumMods
    scatter(ax2V,BDbyM(order(i),:),1./BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax2V,DAve,VAve,VDev,VDev,DDev,DDev,'ks','LineWidth',2)
xlim(plotrangex)
ylim(plotrangevol)
hold(ax2V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);

% The following section creates figures showing the raw profile area and
% mass values versus the fractal dimension.
plotrangex = [1.33 1.58];
plotrangepro = [0.16 0.4];
plotrangemass = [0 6];
figure('Name','4','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax4P = subplot(2,1,1);
hold(ax4P,'on');
xlb4P = xlabel('Fractal Dimension (D)');
ylb4P = ylabel('Average Profile Area');
set(ylb4P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4P.FontSize = 18;
ax4PL.FontSize = 22;
ay4PL.FontSize = 22;
ttl4 = title('Basal (Original)');
ttl4.FontSize = 26;
for i = 1:BNumMods
    scatter(ax4P,BDbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax4P,DAve,RPAve,RPDev,RPDev,DDev,DDev,'ks','LineWidth',2);
xlim(plotrangex)
lgd4 = legend(Corder);
lgd4.FontSize = 16;
hold(ax4P,'off');
ax4V = subplot(2,1,2);
hold(ax4V,'on');
xlb4V = xlabel('Fractal Dimension (D)');
ylb4V = ylabel('Mass (M)');
set(ylb4V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax4V.FontSize = 18;
ax4VL.FontSize = 22;
ay4VL.FontSize = 22;
for i = 1:BNumMods
    scatter(ax4V,BDbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
errorbar(ax4V,DAve,MAve,MDev,MDev,DDev,DDev,'ks','LineWidth',2)
xlim(plotrangex)
hold(ax4V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);

% The following section creates figures showing the raw profile area and
% volume versus mass.
figure('Name','5','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax5P = subplot(2,1,1);
hold(ax5P,'on');
plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
xlb5P = xlabel('Mass (M)');
ylb5P = ylabel('Average Profile Area');
set(ylb5P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5P.FontSize = 18;
ax5PL.FontSize = 22;
ay5PL.FontSize = 22;
ttl5 = title('Basal (Original)');
ttl5.FontSize = 26;
for i = 1:BNumMods
    scatter(ax5P,BMbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
lgd5 = legend(Corder);
lgd5.FontSize = 16;
hold(ax5P,'off');
ax5V = subplot(2,1,2);
hold(ax5V,'on');
xlb5V = xlabel('Mass (M)');
ylb5V = ylabel('Volume (V)');
set(ylb5V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax5V.FontSize = 18;
ax5VL.FontSize = 22;
ay5VL.FontSize = 22;
for i = 1:BNumMods
    scatter(ax5V,BMbyM(order(i),:),BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
xlim(plotrangeM)
hold(ax5V,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);

% The following section creates plots of Average Profile Area, Volume, and
% Mass versus the total length of the neuron
figure('Name','9','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax9P = subplot(3,1,1);
hold(ax9P,'on');
xlb9P = xlabel('Total Length (L_T)');
ylb9P = ylabel('Average Profile Area');
set(ylb9P, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9P.FontSize = 18;
ax9PL.FontSize = 22;
ay9PL.FontSize = 22;
ttl9 = title('Basal (Original)');
ttl9.FontSize = 26;
for i = 1:BNumMods
    scatter(ax9P,BLbyM(order(i),:),BPbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
hold(ax9P,'off');
ax9V = subplot(3,1,2);
hold(ax9V,'on');
xlb9V = xlabel('Total Length (L_T)');
ylb9V = ylabel('Volume (V)');
set(ylb9V, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9V.FontSize = 18;
ax9VL.FontSize = 22;
ay9VL.FontSize = 22;
for i = 1:BNumMods
    scatter(ax9V,BLbyM(order(i),:),BVbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
hold(ax9V,'off');
ax9M = subplot(3,1,3);
hold(ax9M,'on');
xlb9M = xlabel('Total Length (L_T)');
ylb9M = ylabel('Mass (M)');
set(ylb9M, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
ax9M.FontSize = 18;
ax9ML.FontSize = 22;
ay9ML.FontSize = 22;
for i = 1:BNumMods
    scatter(ax9M,BLbyM(order(i),:),BMbyM(order(i),:),'.','MarkerFaceColor', clr(i,:), 'MarkerEdgeColor', clr(i,:))
end
hold(ax9M,'off');
samexaxis('abc','xmt','on','ytac','join','yld',1);