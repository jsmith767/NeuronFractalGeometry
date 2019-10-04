function plotStructScatter3(s,N,G)
if iscell(s(N).vertices)
    if G == 0
        V = vertcat(s(N).vertices{:,:});
        X = V(:,1);
        Y = V(:,2);
        Z = V(:,3);
    else
    X = s(N).vertices{G}(:,1);
    Y = s(N).vertices{G}(:,2);
    Z = s(N).vertices{G}(:,3);
    end
else
    X = s(N).vertices(:,1);
    Y = s(N).vertices(:,2);
    Z = s(N).vertices(:,3);
end
scatter3(X,Y,Z,'.')    
end