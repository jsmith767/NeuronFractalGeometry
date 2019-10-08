% load('MATs\plottingH_4-18-19.mat');

% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120]]/255;
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;

LDD = zeros(1,size(masterH,2));
P = zeros(1,size(masterH,2));
PbyIt = zeros(size(masterH(1).ItData,2),size(masterH,2));

for h = 1:size(masterH,2)
    P(1,h) = masterH(h).NormP;
    LDD(1,h) = masterH(h).D.LD;
    for i = 1:size(masterH(1).ItData,2)
        PbyIt(i,h) = masterH(h).ItData(i).AveP/size(masterH(h).ptCloud,1);
    end
end

figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax1P = subplot(1,1,1);
scatter(LDD,P,'ko','filled');
xlim([min(LDD)-0.05 max(LDD)+0.05])
xlb1P = xlabel('Fractal Dimension (D)');
ylb1P = ylabel('Potential Connectivity (C)');
ax1P.FontSize = 18;
ax1PL.FontSize = 22;
ay1PL.FontSize = 22;
ttl1 = title('Curvy HTrees');
ttl1.FontSize = 26;

figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
ax2P = subplot(1,1,1);
hold(ax2P,'on')
count = 1;
for i = 1:size(masterH(1).ItData,2)
    scatter(i.*ones(1,size(masterH,2)),PbyIt(i,:),'.','filled','MarkerFaceColor', clr(count,:), 'MarkerEdgeColor', clr(count,:))
    if count == 9
        count = 1;
    else
        count = count + 1;
    end
end
scatter(1:size(masterH(1).ItData,2),mean(PbyIt,2),64,'ks','filled')
xlim([0.5 size(masterH(1).ItData,2)+0.5])
xlb2P = xlabel('Iteration (I)');
ylb2P = ylabel('Potential Connectivity (C)');
ax2P.FontSize = 18;
ax2PL.FontSize = 22;
ay2PL.FontSize = 22;
ttl2 = title('Curvy HTrees');
ttl2.FontSize = 26;
hold(ax2P,'off')