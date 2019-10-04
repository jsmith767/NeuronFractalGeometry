function [v,f] = finerMeshWrapperCell(V,F,iterations)
    if iscell(V)
        v = vertcat(V{:});
    else
        v = V;
    end
    if iscell(F)
        f = vertcat(F{:});
    else
        f = F;
    end
    f = [f,cumsum(ones(size(f,1),1))];    
%     v = cell(length(V),1);
%     f = cell(length(V),1);
%     for i=1:length(v)
    for i=1:iterations
        [v,f] = finerMeshWrapper(v,f);
    end        
end