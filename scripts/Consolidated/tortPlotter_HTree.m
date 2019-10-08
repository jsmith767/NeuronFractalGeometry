HTR = 26:66;

% load('D:\Conor\Research\Mathematica\HTree-Models\3D\masterH.mat');
[Paths, Files] = subdir('D:\Conor\Research\Mathematica\HTree-Models\3D');
% Ls = cell(size(masterH,2),1);
% Rs = cell(size(masterH,2),1);
% TortLs = cell(size(masterH,2),1);
% LRanges = cell(size(masterH,2),1);
% BinLs = cell(size(masterH,2),2);
% BinRs = cell(size(masterH,2),2);
% BinTs = cell(size(masterH,2),2);

% for i = HTR%1:size(masterH,2)
%     [L, R, tortlens, lrange] = tortuosity_HTree(masterH(i).ptCloud,25);
%     Ls{i,1} = L;
%     Rs{i,1} = R;
%     TortLs{i,1} = tortlens;
%     LRanges{i,1} = lrange;
%     [BinLs{i,1}, BinLs{i,2}, BinRs{i,1}, BinRs{i,2}] = BinDatabyL(lrange, size(tortlens,2), L, R);
%     [~, ~, BinTs{i,1}, BinTs{i,2}] = BinDatabyL(lrange, size(tortlens,2), L, L./R);
% end

BinAllLs = cell(1,4);
BinAllRs = cell(1,4);
BinAllTs = cell(1,4);
for i = 1:4
    BinAllLs{1,i} = cell(1,2);
    BinAllRs{1,i} = cell(1,2);
    BinAllTs{1,i} = cell(1,2);
    [BinAllLs{1,i}{1,1}, BinAllLs{1,i}{1,2}, BinAllRs{1,i}{1,1}, BinAllRs{1,i}{1,2}] = BinDatabyL(lrange, size(tortlens,2), vertcat(Ls{(i-1)*10+26:i*10+25,1}), vertcat(Rs{(i-1)*10+26:i*10+25,1}));
    [~, ~, BinAllTs{1,i}{1,1}, BinAllTs{1,i}{1,2}] = BinDatabyL(lrange, size(tortlens,2), vertcat(Ls{(i-1)*10+26:i*10+25,1}), vertcat(Ls{(i-1)*10+26:i*10+25,1})./vertcat(Rs{(i-1)*10+26:i*10+25,1}));
end

figure
ax1 = subplot(3,1,1);
xlabel('Path Length (L)');
ylabel('Euclidean Distance (R)');
ax2 = subplot(3,1,[2,3]);
xlabel('Path Length (L)');
ylabel('Tortuosity (T)');
hold(ax1,'on')
hold(ax2,'on')
for i = HTR%1:size(masterH,2)
    plot(ax1,BinLs{i,1},BinRs{i,1},'--','LineWidth',1);
    plot(ax2,BinLs{i,1},BinTs{i,1},'--','LineWidth',1);
%     errorbar(ax1,BinLs{i,1},BinRs{i,1},BinRs{i,2},BinRs{i,2},BinLs{i,2},BinLs{i,2});
%     errorbar(ax2,BinLs{i,1},BinTs{i,1},BinTs{i,2},BinTs{i,2},BinLs{i,2},BinLs{i,2});
end

for i = 1:4
    plot(ax1,BinAllLs{1,i}{1,1},BinAllRs{1,i}{1,1},'k','LineWidth',2)
    plot(ax2,BinAllLs{1,i}{1,1},BinAllTs{1,i}{1,1},'k','LineWidth',2)
%     errorbar(ax1,BinAllLs{1,1},BinAllRs{1,1},BinAllRs{1,2},BinAllRs{1,2},BinAllLs{1,2},BinAllLs{1,2},'k','LineWidth',2);
%     errorbar(ax2,BinAllLs{1,1},BinAllTs{1,1},BinAllTs{1,2},BinAllTs{1,2},BinAllLs{1,2},BinAllLs{1,2},'k','LineWidth',2);
end

hold(ax1,'off');
hold(ax2,'off');