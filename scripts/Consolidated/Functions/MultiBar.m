function [] = MultiBar(Data,numbins)

    DataRange = [min(Data{1,1}) max(Data{1,1})];
    for i = 1:size(Data,1)
        limtemp = [min(Data{i,1}) max(Data{i,1})];
        DataRange = [min([DataRange(1,1) limtemp]) max([DataRange(1,2) limtemp])];
    end
    
    BinWidth = (DataRange(1,2)-DataRange(1,1))/numbins;
    BinEdges = DataRange(1,1):BinWidth:DataRange(1,2);
    
    BarLims = [min(BinEdges) max(BinEdges)];
    BinMids = (BinEdges(1,1:numbins)+BinEdges(2:numbins+1))/2;
    
    N = zeros(numbins,size(Data,1));
    for i = 1:size(Data,1)
        [N(:,i),~,~] = histcounts(Data{i,1},numbins,'BinLimits',BarLims);
    end
    
    figure;
    BarAx = axes('Position',[0.075 0.1 0.8 0.8]);
    bar(BinMids,N,'BarWidth',1);
    
    set(BarAx,'xtick',BinMids,'xticklabel',round(BinMids,3,'significant'));
    BarAx.FontSize = 22;
end