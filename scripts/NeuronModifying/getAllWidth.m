function W = getAllWidth(VAll)
   W = cell(1,length(VAll));
   for i=1:length(VAll)
       W{i} = getWidth(VAll{i});
   end
end