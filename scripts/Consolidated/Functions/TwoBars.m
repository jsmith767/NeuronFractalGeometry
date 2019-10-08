function [] = TwoBars(Data,numbins)

    lim1 = [min(Data{1,1}) max(Data{1,1})];
    lim2 = [min(Data{2,1}) max(Data{2,1})];

    DataRange = [min([lim1 lim2]) max([lim1 lim2])];
    BinWidth = (DataRange(1,2)-DataRange(1,1))/numbins;
    BinEdges = DataRange(1,1):BinWidth:DataRange(1,2);

    Data1LHBV = min(abs(BinEdges(1,1)-lim1(1,1)));
    Data2LHBV = min(abs(BinEdges(1,1)-lim2(1,1)));
    Data1RHBV = min(abs(BinEdges(1,1)-lim1(1,2)));
    Data2RHBV = min(abs(BinEdges(1,1)-lim2(1,2)));
%     Data1LBE = BinEdges(1,1);
%     Data2LBE = BinEdges(1,1);
%     Data1RBE = BinEdges(1,1);
%     Data2RBE = BinEdges(1,1);

    for n = 2:length(BinEdges)
        Data1LHB = min(abs(BinEdges(1,n)-lim1(1,1)));
        Data2LHB = min(abs(BinEdges(1,n)-lim2(1,1)));
        Data1RHB = min(abs(BinEdges(1,n)-lim1(1,2)));
        Data2RHB = min(abs(BinEdges(1,n)-lim2(1,2)));

        if Data1LHB < Data1LHBV
            Data1LHBV = Data1LHB;
%             Data1LBE = BinEdges(1,n);
        end
        if Data2LHB < Data2LHBV
            Data2LHBV = Data2LHB;
%             Data2LBE = BinEdges(1,n);
        end
        if Data1RHB < Data1RHBV
            Data1RHBV = Data1RHB;
%             Data1RBE = BinEdges(1,n);
        end
        if Data2RHB < Data2RHBV
            Data2RHBV = Data2RHB;
%             Data2RBE = BinEdges(1,n);
        end
    end
%     if Data1LBE > lim1(1,1)
%         Data1LBE = Data1LBE - BinWidth;
%     end
%     if Data2LBE > lim2(1,1)
%         Data2LBE = Data2LBE - BinWidth;
%     end
%     if Data1RBE < lim1(1,2)
%         Data1RBE = Data1RBE + BinWidth;
%     end
%     if Data2RBE < lim2(1,2)
%         Data2RBE = Data2RBE + BinWidth;
%     end
    
    BarLims = [min(BinEdges) max(BinEdges)];
    BinMids = (BinEdges(1,1:numbins)+BinEdges(2:numbins+1))/2;
    [N1,~,~] = histcounts(Data{1,1},numbins,'BinLimits',BarLims);
    [N2,~,~] = histcounts(Data{2,1},numbins,'BinLimits',BarLims);
    
    figure;
    BarAx = axes('Position',[0.075 0.1 0.8 0.8]);
    bar(BinMids,[N1' N2'],'BarWidth',1);
    set(BarAx,'xtick',BinMids,'xticklabel',round(BinMids,3,'significant'));
    BarAx.FontSize = 22;
end