%clca is short for "Cell List to Cell Array"
%take a cell of cells and makes an array of it
%commonly used for Ds and files from getDs.m
function cArray = clca(cellList)
cList = vertcat(cellList{:});
cArray= reshape(cList,length(cellList{1}),length(cellList));
end

% f=cellfun(@(x) x(1:end-6),cList,'UniformOutput',false);