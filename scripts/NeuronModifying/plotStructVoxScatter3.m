function plotStructVoxScatter3(s,N,G)
if iscell(s(N).voxCoords)
    if G == 0
        V = vertcat(s(N).voxCoords{:,:});
        X = V(:,1);
        Y = V(:,2);
        Z = V(:,3);
    else
    X = s(N).voxCoords{G}(:,1);
    Y = s(N).voxCoords{G}(:,2);
    Z = s(N).voxCoords{G}(:,3);
    end
else
    X = s(N).voxCoords(:,1);
    Y = s(N).voxCoords(:,2);
    Z = s(N).voxCoords(:,3);
end
scatter3(X,Y,Z,'.')
end