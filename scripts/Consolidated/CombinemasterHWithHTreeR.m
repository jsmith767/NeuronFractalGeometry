plottingH(4141) = struct;
count = 0;
for i = 1:30
    load(['D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\NoExpand\masterH-' num2str(i) '.mat']);
    load(['D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\HTreeR-' num2str(i) '.mat']);
    NumHs = size(masterH,2);
    for j = 1:NumHs
        plottingH(count + j).LDD = masterH(j).D.LD;
        plottingH(count + j).BCD = HTreeR(j).r.D;
        plottingH(count + j).AveP = masterH(j).AveP;
        plottingH(count + j).CHV = masterH(j).CHV;
        plottingH(count + j).CHSA = masterH(j).CHSA;
        plottingH(count + j).ArbR = masterH(j).ArbR;
    end
    count = count + NumHs;
end
save('D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Both\MATs\plottingH_4-18-19_NoExpand.mat','plottingH');