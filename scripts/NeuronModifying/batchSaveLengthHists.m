function y = batchSaveLengthHists(s)
    path = pwd;
    y=0;
    for i=1:length(s(5).PL)
        try
        plotLengthHistogram(s,i);
        saveas(gcf,fullfile(path,[s(5).name{i} '.png']));
        catch
            y = y+1;
            %for some reason we have lots of SLA matrices not the same size
            %as our PL
        end
    end
end