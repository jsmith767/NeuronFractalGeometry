function [] = PlotColorBar(MinData,MaxData,Colors,MakeNewFigure,HighToLow)
    Range = MinData:(MaxData-MinData)/509:MaxData;
    if MakeNewFigure == 1
        figure;
    end
    if HighToLow == 1
        Range = fliplr(Range);
    end
    imagesc(Range);
    colormap(Colors);
    axis off;
end