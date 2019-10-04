function s = profileWrapper(s)
    [P,F] = subdir();
    for i=1:length(s)
        for j=1:length(s(i).name)
            Index = cellfun(@(x) strcmp([s(i).name{j} '.txt'], x), F, 'UniformOutput', 0);
            Index = cellfun(@(x) ismember(1,x),Index);
            path = P{Index};
            V = importHTreefile(fullfile(path,[s(i).name{j} '.txt']));
            s(i).PM{j}=profile(V,100);
        end
    end
    save('s.mat','s');
end