for i=1:length(masterN)
    for j=1:9
        Vpt = masterN(i).data.allangles(j).ptCloud;
        Vv = vertcat(masterN(i).data.allangles(j).VAll{:});
        masterN(i).data.allangles(j).Xscaling = (max(Vpt(:,1))-min(Vpt(:,1)))/(max(Vv(:,1))-min(Vv(:,1)));
        masterN(i).data.allangles(j).Yscaling = (max(Vpt(:,2))-min(Vpt(:,2)))/(max(Vv(:,2))-min(Vv(:,2)));
        masterN(i).data.allangles(j).Zscaling = (max(Vpt(:,3))-min(Vpt(:,3)))/(max(Vv(:,3))-min(Vv(:,3)));
    end
end