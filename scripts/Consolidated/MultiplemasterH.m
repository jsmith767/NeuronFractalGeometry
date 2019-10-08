Dim = '3';
iterations = '7';
straight = '-Both';
TotalLen = 2900;
[Paths, Files] = subdir(fullfile(['D:\Conor\Research\Mathematica\HTree-Models\' Dim 'D-' iterations 'It' straight]));

for p = 2:2
    NumFiles = size(Files{1,2},2);
    NumMasters = 7;
    NumInMaster = floor(NumFiles/NumMasters);
    for m = 1:NumMasters-1
        masterH = struct();
        for f = 1:NumInMaster
            n = (m-1)*NumInMaster + f;
            HTree = ImportTxt_HTree(fullfile(Paths{1,p}, Files{1,p}{1,n}));
            masterH(f).name = Files{1,p}{1,n}(1:end-4);
            DStr = strsplit(masterH(f).name,'D');
            masterH(f).D.LD = str2double(DStr{1,2}(1:4));
            masterH(f).ptCloud = HTree(:,:);
            masterH(f).ArbR = ArborRadius_HTree(HTree);
            [Hull,CHV] = convhull(HTree(:,1:3));
            CHSA = getTriangleAreas(HTree(:,1:3),Hull);
            masterH(f).CHV = CHV;
            masterH(f).CHSA = CHSA;
        end
        save(['D:\Conor\Research\Mathematica\HTree-Models\' Dim 'D-' iterations 'It' straight '\masterH-' num2str(m) '.mat'],'masterH','-v7.3');
    end
    m = NumMasters;
    masterH = struct();
    for f = 1:NumFiles-(NumMasters-1)*NumInMaster
        n = (m-1)*NumInMaster + f;
        HTree = ImportTxt_HTree(fullfile(Paths{1,p}, Files{1,p}{1,n}));
        masterH(f).name = Files{1,p}{1,n}(1:end-4);
        DStr = strsplit(masterH(f).name,'D');
        masterH(f).D.LD = str2double(DStr{1,2}(1:4));
        masterH(f).ptCloud = HTree(:,:);
        masterH(f).ArbR = ArborRadius_HTree(HTree);
        [Hull,CHV] = convhull(HTree(:,1:3));
        CHSA = getTriangleAreas(HTree(:,1:3),Hull);
        masterH(f).CHV = CHV;
        masterH(f).CHSA = CHSA;
    end
    save(['D:\Conor\Research\Mathematica\HTree-Models\' Dim 'D-' iterations 'It' straight '\masterH-' num2str(m) '.mat'],'masterH','-v7.3');
end