function s = setItLists(s)
    for i=1:length(s)
        for j=1:length(s(i).PL)
        s(i).IL{j}=getItLists(s(i).PL{j});
        end
    end
end