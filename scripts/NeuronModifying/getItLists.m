function IL = getItLists(PL)
    IL = cell(length(PL),1);
    for i=1:length(PL)
        IL{i} = getItList(PL{i});
    end
end