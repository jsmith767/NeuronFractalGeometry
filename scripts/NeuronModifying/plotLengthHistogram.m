function h = plotLengthHistogram(s,Nnum)
    SLA = vertcat(s(5).SLA{Nnum}{:});
    IL = vertcat(s(5).IL{Nnum}{:});
    t = [SLA(:,1) IL];
    h = cell(max(t(:,2)),1);
    xbins = linspace(min(t(:,1)),max(t(:,1)),10);
    for i=1:max(t(:,2))
%         index = find(t(:,2)==i);
        h{i} = hist(t(t(:,2)==i,1),xbins);
    end
    ht = vertcat(h{:});
    bar(xbins,ht','stacked');
    legend(string(1:max(t(:,2))));
    xlabel('Length(um)');
    ylabel('Number');
end