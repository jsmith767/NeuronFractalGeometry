for i = 1:30
    load(['D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both-New\MATs\masterH-' num2str(i) '.mat']);
    NumHs = size(masterH,2);
    for j = 1:NumHs
        ArbR = ArborRadius_HTree(masterH(j).ptCloud);
        masterH(j).ArbR = ArbR;
        
        [Hull, CHV] = convhull(masterH(j).ptCloud(:,1:3));
        CHSA = getTriangleAreas(masterH(j).ptCloud(:,1:3),Hull);
        masterH(j).CHV = CHV;
        masterH(j).CHSA = CHSA;
    end
    save(['D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both-New\MATs\new\masterH-' num2str(i) '.mat'],'masterH');
end