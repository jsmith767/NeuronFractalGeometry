Path = 'D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\';

for i = 1:30
    load([Path 'masterH-' num2str(i) '.mat'])
    SmallestBox = 5;
    HTreeR(size(masterH,2)) = struct();
    for n = 1:size(masterH,2)
        ptC = masterH(n).ptCloud;
        ptC = makePtsLarger(round(ptC(:,1:3)),5);
%         ptR.x = round(ptC(:,1));
%         ptR.y = round(ptC(:,2));
%         ptR.z = round(ptC(:,3));
        ptR.x = ptC(:,1);
        ptR.y = ptC(:,2);
        ptR.z = ptC(:,3);
        ns = boxCount(ptR,1);
        bc.res = extractfield(ns,'res');
        bc.L = extractfield(ns,'L');
        bc.N = extractfield(ns,'N');
        [r] = fitwrapperBounds(bc.L,bc.N,bc.res,0.25,SmallestBox,1.0);
        HTreeR(n).r = r;
    end
    save([Path 'HTreeR-' num2str(i) 'E.mat'],'HTreeR')
    
    clearvars -except Path
end