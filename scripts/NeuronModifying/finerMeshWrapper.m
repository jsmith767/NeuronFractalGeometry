%needs to be sped up so it doesn't keep re-writing the whole v vector.
function [v,f] = finerMeshWrapper(V,F)
%     tic
    f = cell(4*size(F,1),1);
    v = cell(3*size(F,1),1);
%     v = [V;v]; 
    for i=1:size(F,1)
        [v{i},f{i}] = finerMeshSingle(V,F,i,size(V,1)+(i-1)*3);
    end
    f = vertcat(f{:});
    v = vertcat(v{:});
    v = [V;v];
%     toc
end