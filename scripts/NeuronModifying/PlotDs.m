%this Function plots D values after grabbing them for all the folders by
%means of getDs.m

function y = PlotDs(Ds,type)
    for i=1:length(Ds)
    Ms(i) = mean(Ds{i});
    end
    %Standard deviations
    for i=1:length(Ds)
    stds(i) = std(Ds{i});
    end
    %Assign appropriate curvatures
    Xs = 0:25:200;
    %Plot
    scatter(Xs,Ms)
    errorbar(Xs,Ms,stds,'.k')
    xlabel('% curved');
    ylabel('D');
    title(['Variation in D vs curvature (' type ')'])
    ylabel('D');
end