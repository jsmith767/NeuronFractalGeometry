% load('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_A_Basal_SA_4-25-19.mat');

clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
NumNeurs = size(masterN,2);
NumCs = size(masterN(1).data.allangles,2);

figure();
for C = 1:NumCs

    AllLs = cell(NumNeurs,1);
    AllRs = cell(NumNeurs,1);
    Torts = cell(NumNeurs,1);
%     LRanges = cell(NumNeurs,1);
    BinLs = cell(NumNeurs,2);
    BinRs = cell(NumNeurs,2);
    BinTs = cell(NumNeurs,2);

    for i = 1:NumNeurs
        [Ls,Rs] = tortuosity_Neuron(masterN(i).data.allangles(NumCs+1-C).V,masterN(i).SLA);
        AllLs{i,1} = Ls;
        AllRs{i,1} = Rs;
        Torts{i,1} = Ls./Rs;
        
        [BinLs{i,1}, BinLs{i,2}, BinRs{i,1}, BinRs{i,2}] = BinDatabyL([0 100], 25, AllLs{i,1}, AllRs{i,1});
        [~, ~, BinTs{i,1}, BinTs{i,2}] = BinDatabyL([0 100], 25, AllLs{i,1}, AllLs{i,1}./AllRs{i,1});
    end
    AveL = mean(cellfun(@mean,AllLs));
    AveR = mean(cellfun(@mean,AllRs));

    BinAllLs = cell(1,2);
    BinAllRs = cell(1,2);
    BinAllTs = cell(1,2);
    [BinAllLs{1,1}, BinAllLs{1,2}, BinAllRs{1,1}, BinAllRs{1,2}] = BinDatabyL([0 100], 25, vertcat(AllLs{:,1}), vertcat(AllRs{:,1}));
    [~, ~, BinAllTs{1,1}, BinAllTs{1,2}] = BinDatabyL([0 100], 25, vertcat(AllLs{:,1}), vertcat(AllLs{:,1})./vertcat(AllRs{:,1}));

    ax1 = subplot(3,1,1);
    ax1L = xlabel('Path Length (L)');
    ay1L = ylabel('R');
    ax1.FontSize = 24;
    ax1L.FontSize = 28;
    ay1L.FontSize = 28;
    ax2 = subplot(3,1,[2 3]);
    ax2L = xlabel('Path Length (L)');
    ay2L = ylabel('Tortuosity (T)');
    ax2.FontSize = 24;
    ax2L.FontSize = 28;
    ay2L.FontSize = 28;
    hold(ax1,'on')
    hold(ax2,'on')

    % These lines help plot every neuron in a set of some given curvature.
%     for i = 1:NumNeurs
%         plot(ax1,BinLs{i,1},BinRs{i,1},'--','LineWidth',1);
%         plot(ax2,BinLs{i,1},BinTs{i,1},'--','LineWidth',1);
%     %     errorbar(ax1,BinLs{i,1},BinRs{i,1},BinRs{i,2},BinRs{i,2},BinLs{i,2},BinLs{i,2});
%     %     errorbar(ax2,BinLs{i,1},BinTs{i,1},BinTs{i,2},BinTs{i,2},BinLs{i,2},BinLs{i,2});
%     end

    % % These lines give error bar plots for the resulting R and T data versus l
    % errorbar(ax1,BinAllLs{1,1},BinAllRs{1,1},BinAllRs{1,2},BinAllRs{1,2},BinAllLs{1,2},BinAllLs{1,2},'LineWidth',2);
    % xlim(ax1,lrange + [-0.5 0.5]);
    % errorbar(ax2,BinAllLs{1,1},BinAllTs{1,1},BinAllTs{1,2},BinAllTs{1,2},BinAllLs{1,2},BinAllLs{1,2},'LineWidth',2);
    % xlim(ax2,lrange + [-0.5 0.5]);
    % ylim(ax2,[0.9 max(BinAllTs{1,1})+max(BinAllTs{1,2})]);

    % These lines give R and T plots versus l in units of average l
    plot(ax1,BinAllLs{1,1},BinAllRs{1,1},'LineWidth',2,'color',clr(C,:));
%     xlim(ax1,[-0.1 3.1]); %Upper xlim for BasalEnd is 3.1
    plot(ax2,BinAllLs{1,1},BinAllTs{1,1},'LineWidth',2,'color',clr(C,:));
%     xlim(ax2,[-0.1 3.1]);
    ylim(ax2,[0.95 1.5]); %Upper ylim for BasalEnd is 1.53

end

legend(["0.00" "0.25" "0.50" "0.75" "1.00" "1.25" "1.50" "1.75" "2.00"]);
legendEntries = get(ax2,'legend');
plotHandles = get(ax2,'children');
legendEntries = legendEntries.String;
newOrder = [9,8,7,6,5,4,3,2,1];
legend(ax2,legendEntries{newOrder});