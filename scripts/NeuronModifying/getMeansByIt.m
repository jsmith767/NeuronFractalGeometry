function means = getMeansByIt(IT,SLA)
    Ms = cell(max(cellfun('length', IT)),1);
    for i = 1:length(IT)
        for j = 1:length(IT{i})
            Ms{j} = [Ms{j};SLA{i}(IT{i}{j},1)];
        end
    end
    means = zeros(length(Ms),1);
    for i=1:length(Ms)
        means(i) = mean(Ms{i});
    end
end