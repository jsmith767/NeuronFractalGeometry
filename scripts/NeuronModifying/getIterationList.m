function iterationList = getIterationList(PL)
    IT = cell(length(PL),1); %Make sure there is an iteration list for each group of objs
    for i=1:length(PL) 
        IT{i} = cell(length(PL{i}),1); %each iteration list will never be longer than the number of branches in that list
    end
    for k=1:length(PL)  %accesses each consecutive branch group
        IT{k}{1} = find(PL{k}==0); %finds the parent branch(s) and sets them to the first iteration.
        for i=1:length(PL{k})-1 %runs through the list of parents
            for j=1:length(IT{k}{i}) %runs through multiple parents for an iteration
                IT{k}{i+1} = [IT{k}{i+1};find(PL{k}==IT{k}{i}(j))]; %Takes the parents from the current iteration, sees if they exist on the parent list, and adds there children to the next iteration.
            end
        end
    end
    for i=1:length(IT)
        IT{i} = IT{i}(~cellfun(@isempty, IT{i}));
    end
    iterationList = IT;
end