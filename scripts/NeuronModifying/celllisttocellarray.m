
function cArray = celllisttocellarray(cellList)
cList = vertcat(cellList{:});
cArray= reshape(cList,length(cellList{1}),length(cellList));
end

% f=cellfun(@(x) x(1:end-6),cList,'UniformOutput',false);