%compare cells
function same = compareCellArrays( cellArray )
shouldBeOne = 1;
for j=1:length(cellArray)
    for i=1:length(cellArray{j})
        N = strcmp(cellArray{1}{i}(1:6),cellArray{j}{i}(1:6));
        shouldBeOne = shouldBeOne*N;
    end
end

same = shouldBeOne;
end
    