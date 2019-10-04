function ht = batchAvgLengthHists(s)
%     path = pwd;
        ht = zeros(50,10); %buffer of 30 for iterations, 10 because # of bars in histogram
    for i=1:length(s(5).PL)
        h = AvgLengthHistogram(s,i);
%         ht = ht(1:size(h,1),1:size(h,2))+h;      
        [p,q] = size(h); 
        ht(1:p,1:q) = ht(1:p,1:q)+h; 
%         saveas(gcf,fullfile(path,[s(5).name{i} '.png']));
    end
    ht( ~any(ht,2), : ) = [];  %rows
    ht=ht./length(s(5).PL);
%     xbins = linspace(min(t(:,1)),max(t(:,1)),10);
%     bar(xbins,ht','stacked');
end