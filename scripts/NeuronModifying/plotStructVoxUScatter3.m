function plotStructVoxUScatter3(s,N,G)
if iscell(s(N).voxUnique)
    if G == 0
        V = vertcat(s(N).voxUnique{:,:});
        X = V(:,1);
        Y = V(:,2);
        Z = V(:,3);
    else
    X = s(N).voxUnique{G}(:,1);
    Y = s(N).voxUnique{G}(:,2);
    Z = s(N).voxUnique{G}(:,3);
    end
else
    X = s(N).voxUnique(:,1);
    Y = s(N).voxUnique(:,2);
    Z = s(N).voxUnique(:,3);
end
scatter3(X,Y,Z,'.')
end