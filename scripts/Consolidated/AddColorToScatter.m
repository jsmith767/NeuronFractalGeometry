% G1 = normrnd(-10,10,[2,1000]);
% G2 = normrnd(10,10,[2,1000]);
E17 = false(1,148);
for i = 1:104
    if GNRecalMicron(i).DIV == 17
        E17(1,i) = 1;
    end
end
G1 = [extractfield(GNRecalMicron(E17),'alphaG');extractfield(GNRecalMicron(E17),'betaN')];
G2 = [extractfield(GNRecalMicron(105:148),'alphaG');extractfield(GNRecalMicron(105:148),'betaN')];
% G1 = [extractfield(GN(E17),'RhoGS');extractfield(GN(E17),'RhoNC')];
% G2 = [extractfield(GN(105:148),'RhoGS');extractfield(GN(105:148),'RhoNC')];
% G1 = [extractfield(GN(E17),'alphaN');extractfield(GN(E17),'betaN')];
% G2 = [extractfield(GN(105:148),'alphaN');extractfield(GN(105:148),'betaN')];
G12 = [G1 G2];
numbins = 100;
CircleR = 9;
coloralpha = 0.5;
colorrange = [-2 2];

NormFactor = size(G1,2)/size(G2,2);
BinEdges = cell(2,1);
Xmin = min(G12(1,:));
Xmax = max(G12(1,:));
Ymin = min(G12(2,:));
Ymax = max(G12(2,:));
BinEdges{1,1} = Xmin:(Xmax-Xmin)/numbins:Xmax;
BinEdges{2,1} = Ymin:(Ymax-Ymin)/numbins:Ymax;
% BinEdges{1,1} = Xmin-(Xmax-Xmin)/numbins:(Xmax-Xmin)/numbins:Xmax+(Xmax-Xmin)/numbins;
% BinEdges{2,1} = Ymin-(Ymax-Ymin)/numbins:(Ymax-Ymin)/numbins:Ymax+(Ymax-Ymin)/numbins;
G1S = [(G1(1,:)-Xmin)./(Xmax-Xmin);(G1(2,:)-Ymin)./(Ymax-Ymin)].*numbins;
G2S = [(G2(1,:)-Xmin)./(Xmax-Xmin);(G2(2,:)-Ymin)./(Ymax-Ymin)].*numbins;
% G1S = [(G1(1,:)-Xmin)./(Xmax-Xmin);(G1(2,:)-Ymin)./(Ymax-Ymin)].*(numbins+2);
% G2S = [(G2(1,:)-Xmin)./(Xmax-Xmin);(G2(2,:)-Ymin)./(Ymax-Ymin)].*(numbins+2);
G1H = hist3(G1','Edges',BinEdges);
G2H = hist3(G2','Edges',BinEdges);
G12H = (G2H.*NormFactor) - G1H;

% figure;
% PCM = subplot(1,1,1);
% PC = pcolor(0:numbins,0:numbins,G12H');
% % PC.FaceColor = 'interp';
% PC.FaceAlpha = coloralpha;
% PC.EdgeColor = 'none';
% colormap(ClrMp);
% caxis(PCM,colorrange)
% % GCM = gray(PCM);
% % set(gca,'XTick',0:50,'YTick',0:50);
% colorbar;
% hold on;
% scatter(G1S(1,:),G1S(2,:),'r.');
% scatter(G2S(1,:),G2S(2,:),'b.');

G12HS = zeros(size(G12H,1),size(G12H,2));
for x = 1:size(G12HS,1)
    for y = 1:size(G12HS,2)
        ptot = 0;
        for xb = -CircleR:CircleR
            for yb = -CircleR:CircleR
                if x+xb>0 && x+xb<numbins+2 && y+yb>0 && y+yb<numbins+2 && sqrt(xb^2+yb^2) <= CircleR
                    ptot = ptot + G12H(x+xb,y+yb);
                end
            end
        end
        G12HS(x,y) = ptot;
    end
end

% figure;
% PCM1 = subplot(2,2,1);
% PC1 = pcolor(0:numbins,0:numbins,G12H');
% PC1.EdgeColor = 'none';
% PC1.FaceAlpha = coloralpha;
% colormap(ClrMp);
% caxis(PCM1,colorrange)
% PCM2 = subplot(2,2,2);
% PC2 = pcolor(0:numbins,0:numbins,G12HS');
% PC2.EdgeColor = 'none';
% PC2.FaceAlpha = coloralpha;
% colormap(ClrMp);
% caxis(PCM2,colorrange)
% PCM3 = subplot(2,2,3);
% PC3 = pcolor(0:numbins,0:numbins,G12H');
% PC3.EdgeColor = 'none';
% PC3.FaceAlpha = coloralpha;
% colormap(ClrMp);
% caxis(PCM3,colorrange)
% hold on;
% scatter(G1S(1,:),G1S(2,:),'r.');
% scatter(G2S(1,:),G2S(2,:),'b.');
% PCM4 = subplot(2,2,4);
% PC4 = pcolor(0:numbins,0:numbins,G12HS');
% PC4.EdgeColor = 'none';
% PC4.FaceAlpha = coloralpha;
% colormap(ClrMp);
% caxis(PCM4,colorrange)
% hold on;
% scatter(G1S(1,:),G1S(2,:),'r.');
% scatter(G2S(1,:),G2S(2,:),'b.');

figure;
PCM5 = subplot(1,2,1);
PC5 = pcolor(0:numbins,0:numbins,G12HS');
PC5.EdgeColor = 'none';
PC5.FaceAlpha = coloralpha;
colormap(ClrMp);
caxis(PCM5,colorrange)
set(PCM5,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[])
% xlabel('\alphaN','FontSize',24);
% ylabel('\betaN','FontSize',24);
% xlabel('\rhoG','FontSize',24);
% ylabel('\rhoN','FontSize',24);
xlabel('\alphaG','FontSize',24);
ylabel('\betaN','FontSize',24);
PCM6 = subplot(1,2,2);
PC6 = pcolor(0:numbins,0:numbins,G12HS');
PC6.EdgeColor = 'none';
PC6.FaceAlpha = coloralpha;
colormap(ClrMp);
caxis(PCM6,colorrange)
hold on;
scatter(G1S(1,:),G1S(2,:),50,'rp','filled');
scatter(G2S(1,:),G2S(2,:),50,'bd','filled');
set(PCM6,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[])
% set(PCM6,'xlabel','/alphaN','ylabel','/betaN')
% xlabel('\alphaN','FontSize',24);
% ylabel('\betaN','FontSize',24);
% xlabel('\rhoG','FontSize',24);
% ylabel('\rhoN','FontSize',24);
xlabel('\alphaG','FontSize',24);
ylabel('\betaN','FontSize',24);