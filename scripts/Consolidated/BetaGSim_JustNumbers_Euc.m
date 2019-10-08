for w = 1:8

% UseMask = masknum;
MultCellNum = 1;
UseGauss = 0;
MakeEucMask = 1;
CellRad = 15;
NumSamps = 1000;
QuarterGlia = floor(pi*CellRad^2/4);

% if UseMask == 1
%     mask = imread('K:\Keck\MicroscopeImages\BP1\Pluth\BP1_20x_CNT\FullImage\mask.tif');%for D = 1.1
%     savefilename = strcat('D1.1I4-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad),'-Take2');
% elseif UseMask == 2
%     mask = imread('K:\Keck\MicroscopeImages\BP10\Pluth\BP10_20x_CNT\FullImage\mask.tif');%for D = 1.5
%     savefilename = strcat('D1.5I4-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad),'-Take2');
% elseif UseMask == 3
%     mask = imread('K:\Keck\MicroscopeImages\BO1-1\Pluth\BO1-1_20x_CNT\FullSample\mask.tif');%for D = 2, I = 4
%     savefilename = strcat('D2.0I4-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad),'-Take2');
% elseif UseMask == 4
%     mask = imread('K:\Keck\MicroscopeImages\BK1-1\Pluth\BK1-1_20x_CNT\FullSample\mask.tif');%for D = 2, I = 5
%     savefilename = strcat('D2.0I5-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad),'-Take2');
% elseif UseMask == 5
%     mask = imread('K:\Keck\MicroscopeImages\BP11\Pluth\BP11_20x_CNT\FullImage\mask.tif');%for D = 2, I = 6
%     savefilename = strcat('D2.0I6-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad),'-Take2');
% end

if MultCellNum == 1
%     NumCells = [20 50 100 200 500];
    NumCells = [5 10 20 50 100];
%     NumCells = [100 200];
else
    NumCells = 100;
end
NumNums = size(NumCells,2);

CircleInds = [];
for i = -CellRad:CellRad
    for j = -CellRad:CellRad
        if sqrt((i)^2+(j)^2) <= CellRad
            CircleInds = [CircleInds;[i j]];
        end
    end
end

%~500 pixels is 10 25um CNT rows and 9 25um Si Gaps
if MakeEucMask == 1
    sampsize = 10000;
    mask = zeros(sampsize,sampsize,3,'uint8');
    mask(:,:,:) = 255;
    Xlims = size(mask,1);
    Xbuf = round(Xlims/20);
    Ylims = size(mask,2);
    Ybuf = round(Ylims/20);
%     RowWidth = round((Xlims-(2*Xbuf))/(NumRows+NumGaps));
    RowWidth = 25*w;
    NumRows = round((sampsize - 2*Ybuf)/(2*RowWidth-1));
    NumGaps = NumRows - 1;
    for r = 1:NumRows
        mask(Xbuf+(r-1)*(2*RowWidth)+1:Xbuf+(r-1)*(2*RowWidth)+RowWidth,1+Ybuf:Ylims-Ybuf,:) = 0;
    end
    NumZeros = size(find(~mask(:,:,1)),1);
    savefilename = strcat('W',num2str(RowWidth),'-BetaGSim-',num2str(NumSamps),'Samples-R',num2str(CellRad));
else
    Xlims = size(mask,1);
    Ylims = size(mask,2);
    NumZeros = size(find(~mask(:,:,1)),1);
end
BiggestDim = max([Xlims Ylims]);
clear MaskLocs;
[MaskLocs(:,1),MaskLocs(:,2),~] = find(~mask);
MaskBin = true(Xlims,Ylims);
for m = 1:NumZeros
    Loc = [MaskLocs(m,1) MaskLocs(m,2)];
    MaskBin(Loc(1,1),Loc(1,2)) = 0;
end
SampIm = zeros(Xlims,Ylims,3,'uint8');
SampIm(:,:,:) = 255;
for z = 1:NumZeros
    SampIm(MaskLocs(z,1),MaskLocs(z,2),:) = [0 0 0];
end
if MakeEucMask == 1
    SampClip = MaskBin(Xbuf:Xlims-Xbuf,Ybuf:Ylims-Ybuf);
else
    SampClip = MaskBin;
end


BetaG = zeros(NumNums,NumSamps);
AlphaG = zeros(NumNums,NumSamps);
for m = 1:NumNums
    for n = 1:NumSamps
        if UseGauss == 1
            Cells = false(Xlims,Ylims);
            CellLocs = zeros(2,NumCells(1,m));
            CellLocs(1,:) = round(normrnd(Xlims/2,BiggestDim/8,[1,NumCells(1,m)]));
            CellLocs(2,:) = round(normrnd(Ylims/2,BiggestDim/8,[1,NumCells(1,m)]));
            CellLocs(1,CellLocs(1,:)<=0) = 1;
            CellLocs(2,CellLocs(2,:)<=0) = 1;
            CellLocs(1,CellLocs(1,:)>=Xlims) = Xlims;
            CellLocs(2,CellLocs(2,:)>=Ylims) = Ylims;
        else
            Cells = false(Xlims,Ylims);
            CellLocs = zeros(2,NumCells(1,m));
            CellLocs(1,:) = round(rand(1,NumCells(1,m))*Xlims);
            CellLocs(2,:) = round(rand(1,NumCells(1,m))*Ylims);
            CellLocs(1,CellLocs(1,:)==0) = 1;
            CellLocs(2,CellLocs(2,:)==0) = 1;
        end
        for c = 1:NumCells(1,m)
            Loc = [CellLocs(1,c) CellLocs(2,c)];
            Cells(Loc(1,1),Loc(1,2)) = 1;
        end

        CNTCells = Cells & ~MaskBin;
        if sum(sum(CNTCells)) == 0
            CNTCellLocs = [];
        else
            [CNTCellLocs(:,1),CNTCellLocs(:,2),~] = find(CNTCells);
            for c = 1:size(CNTCellLocs,1)
                Loc = [CNTCellLocs(c,1) CNTCellLocs(c,2)];
                if Loc(1,1) >= 1+CellRad && Loc(1,1) <= Xlims-CellRad && Loc(1,2) >= 1+CellRad && Loc(1,2) <= Ylims-CellRad
                    for p = 1:size(CircleInds,1)
                        CNTCells(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                    end
                else
                    for p = 1:size(CircleInds,1)
                        if Loc(1,1)+CircleInds(p,1)<=Xlims && Loc(1,2)+CircleInds(p,2)<=Ylims && Loc(1,1)+CircleInds(p,1)>=1 && Loc(1,2)+CircleInds(p,2)>=1
                            CNTCells(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                        end
                    end
                end
            end
            CNTCells = ~MaskBin & CNTCells;
            CNTCells = bwareaopen(CNTCells,QuarterGlia);
            [CNTGreens(:,1),CNTGreens(:,2),~] = find(CNTCells);
            for g = 1:size(CNTGreens,1)
                SampIm(CNTGreens(g,1),CNTGreens(g,2),:) = [0 255 0];
            end
        end
        SiCells = Cells & MaskBin;
        if sum(sum(SiCells)) == 0
            SiCellLocs = [];
        else
            [SiCellLocs(:,1),SiCellLocs(:,2),~] = find(SiCells);
            for c = 1:size(SiCellLocs,1)
                Loc = [SiCellLocs(c,1) SiCellLocs(c,2)];
                if Loc(1,1) >= 1+CellRad && Loc(1,1) <= Xlims-CellRad && Loc(1,2) >= 1+CellRad && Loc(1,2) <= Ylims-CellRad
                    for p = 1:size(CircleInds,1)
                        SiCells(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                    end
                else
                    for p = 1:size(CircleInds,1)
                        if Loc(1,1)+CircleInds(p,1)<=Xlims && Loc(1,2)+CircleInds(p,2)<=Ylims && Loc(1,1)+CircleInds(p,1)>=1 && Loc(1,2)+CircleInds(p,2)>=1
                            SiCells(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                        end
                    end
                end
            end
            SiCells = MaskBin & SiCells;
            SiCells = bwareaopen(SiCells,QuarterGlia);
            [SiGreens(:,1),SiGreens(:,2),~] = find(SiCells);
            for g = 1:size(SiGreens,1)
                SampIm(SiGreens(g,1),SiGreens(g,2),:) = [0 255 0];
            end
        end

        if MakeEucMask == 1
            CNTCellsClip = CNTCells(Xbuf:Xlims-Xbuf,Ybuf:Ylims-Ybuf);
            SiCellsClip = SiCells(Xbuf:Xlims-Xbuf,Ybuf:Ylims-Ybuf);
        else
            CNTCellsClip = CNTCells;
            SiCellsClip = SiCells;
        end
        BetaG(m,n) = sum(sum(CNTCellsClip))/sum(sum(~SampClip));
        AlphaG(m,n) = sum(sum(SiCellsClip))/sum(sum(SampClip));
        
        clear CNTCellLocs SiCellLocs CNTCells SiCells CNTGreens SiGreens CNTCellsClip SiCellsClip
    end
end

save(strcat('MATs\',savefilename,'.mat'),'AlphaG','BetaG','SampClip');

clearvars -except plottingN plottingH masterN masterH HTreeM mNVox

end