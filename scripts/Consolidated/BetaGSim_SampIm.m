UseMask = 5;
MultCellNum = 0;
UseGauss = 0;
MakeEucMask = 0;
ShowIms = 1;
CellRad = 39; %39 (~25um) or 31 (~20um) for 77 pix width (~25um) rows
NumSamps = 1;
QuarterGlia = floor(pi*CellRad^2/4);

if MakeEucMask == 0
    if UseMask == 1
        mask = im2uint8(imread('K:\Keck\Programs\Matlab_Julian_10-30-2018\Templates\D1_1-I4-W25-FL2163.tif'));%for D = 1.1
    elseif UseMask == 2
        mask = im2uint8(imread('K:\Keck\Programs\Matlab_Julian_10-30-2018\Templates\D1_5-I4-W25-FL1855.tif'));%for D = 1.5
    elseif UseMask == 3
        mask = im2uint8(imread('K:\Keck\Programs\Matlab_Julian_10-30-2018\Templates\D2-I4-W25-FL1664.tif'));%for D = 2, I = 4
    elseif UseMask == 4
        mask = im2uint8(imread('K:\Keck\Programs\Matlab_Julian_10-30-2018\Templates\D2-I5-W25-FL1611.tif'));%for D = 2, I = 5
    elseif UseMask == 5
        mask = im2uint8(imread('K:\Keck\Programs\Matlab_Julian_10-30-2018\Templates\D2-I6-W25-FL1585.tif'));%for D = 2, I = 6
    end
end

if MultCellNum == 1
    NumCells = [20 50 100 200 500];
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
    RowWidth = 25*m;
    NumRows = round((sampsize - 2*Ybuf)/(2*RowWidth-1));
    NumGaps = NumRows - 1;
%     mask = zeros(4000,8000,3,'uint8');
%     mask(:,:,:) = 255;
%     NumRows = 80;
%     NumGaps = NumRows - 1;
%     Xlims = size(mask,1);
%     Xbuf = round(Xlims/20);
%     Ylims = size(mask,2);
%     Ybuf = round(Ylims/20);
%     RowWidth = round((Xlims-(2*Xbuf))/(NumRows+NumGaps));
    for r = 1:NumRows
        mask(Xbuf+(r-1)*(2*RowWidth)+1:Xbuf+(r-1)*(2*RowWidth)+RowWidth,1+Ybuf:Ylims-Ybuf,:) = 0;
    end
    NumZeros = size(find(~mask(:,:,1)),1);
else
    Xlims = size(mask,1);
    Ylims = size(mask,2);
    NumZeros = size(find(~mask(:,:,1)),1);
end
clear MaskLocs;
[MaskLocs(:,1),MaskLocs(:,2),~] = find(~mask);
MaskBin = true(Xlims,Ylims);
for m = 1:NumZeros
    Loc = [MaskLocs(m,1) MaskLocs(m,2)];
    MaskBin(Loc(1,1),Loc(1,2)) = 0;
end


Cells = cell(NumNums,NumSamps);
CellLocs = cell(NumNums,NumSamps);
if UseGauss == 1
    for m = 1:NumNums
        for n = 1:NumSamps
            Cells{m,n} = false(Xlims,Ylims);
            BiggestDim = max([Xlims Ylims]);
            CellLocs{m,n} = zeros(2,NumCells(1,m));
            CellLocs{m,n}(1,:) = round(normrnd(Xlims/2,BiggestDim/8,[1,NumCells(1,m)]));
            CellLocs{m,n}(2,:) = round(normrnd(Ylims/2,BiggestDim/8,[1,NumCells(1,m)]));
            CellLocs{m,n}(1,CellLocs{m,n}(1,:)<=0) = 1;
            CellLocs{m,n}(2,CellLocs{m,n}(2,:)<=0) = 1;
            CellLocs{m,n}(1,CellLocs{m,n}(1,:)>=Xlims) = Xlims;
            CellLocs{m,n}(2,CellLocs{m,n}(2,:)>=Ylims) = Ylims;
        end
    end
else
    for m = 1:NumNums
        for n = 1:NumSamps
            Cells{m,n} = false(Xlims,Ylims);
            CellLocs{m,n} = zeros(2,NumCells(1,m));
            CellLocs{m,n}(1,:) = round(rand(1,NumCells(1,m))*Xlims);
            CellLocs{m,n}(2,:) = round(rand(1,NumCells(1,m))*Ylims);
            CellLocs{m,n}(1,CellLocs{m,n}(1,:)==0) = 1;
            CellLocs{m,n}(2,CellLocs{m,n}(2,:)==0) = 1;
        end
    end
end
for m = 1:NumNums
    for n = 1:NumSamps
        for c = 1:NumCells(1,m)
            Loc = [CellLocs{m,n}(1,c) CellLocs{m,n}(2,c)];
            Cells{m,n}(Loc(1,1),Loc(1,2)) = 1;
        end
    end
end
CNTCells = cell(NumNums,NumSamps);
CNTCellLocs = cell(NumNums,NumSamps);
SiCells = cell(NumNums,NumSamps);
SiCellLocs = cell(NumNums,NumSamps);
for m = 1:NumNums
    for n = 1:NumSamps
        CNTCells{m,n} = Cells{m,n} & ~MaskBin;
        [CNTCellLocs{m,n}(:,1),CNTCellLocs{m,n}(:,2),~] = find(CNTCells{m,n});
        SiCells{m,n} = Cells{m,n} & MaskBin;
        [SiCellLocs{m,n}(:,1),SiCellLocs{m,n}(:,2),~] = find(SiCells{m,n});
    end
end

for m = 1:NumNums
    for n = 1:NumSamps
        for c = 1:size(CNTCellLocs{m,n},1)
            Loc = [CNTCellLocs{m,n}(c,1) CNTCellLocs{m,n}(c,2)];
            if Loc(1,1) >= 1+CellRad && Loc(1,1) <= Xlims-CellRad && Loc(1,2) >= 1+CellRad && Loc(1,2) <= Ylims-CellRad
                for p = 1:size(CircleInds,1)
                    CNTCells{m,n}(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                end
            else
                for p = 1:size(CircleInds,1)
                    if Loc(1,1)+CircleInds(p,1)<=Xlims && Loc(1,2)+CircleInds(p,2)<=Ylims && Loc(1,1)+CircleInds(p,1)>=1 && Loc(1,2)+CircleInds(p,2)>=1
                        CNTCells{m,n}(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                    end
                end
            end
        end
        for c = 1:size(SiCellLocs{m,n},1)
            Loc = [SiCellLocs{m,n}(c,1) SiCellLocs{m,n}(c,2)];
            if Loc(1,1) >= 1+CellRad && Loc(1,1) <= Xlims-CellRad && Loc(1,2) >= 1+CellRad && Loc(1,2) <= Ylims-CellRad
                for p = 1:size(CircleInds,1)
                    SiCells{m,n}(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                end
            else
                for p = 1:size(CircleInds,1)
                    if Loc(1,1)+CircleInds(p,1)<=Xlims && Loc(1,2)+CircleInds(p,2)<=Ylims && Loc(1,1)+CircleInds(p,1)>=1 && Loc(1,2)+CircleInds(p,2)>=1
                        SiCells{m,n}(Loc(1,1)+CircleInds(p,1),Loc(1,2)+CircleInds(p,2)) = 1;
                    end
                end
            end
        end

        CNTCells{m,n} = ~MaskBin & CNTCells{m,n};
        CNTCells{m,n} = bwareaopen(CNTCells{m,n},QuarterGlia);
        SiCells{m,n} = MaskBin & SiCells{m,n};
        SiCells{m,n} = bwareaopen(SiCells{m,n},QuarterGlia);
    end
end


SampIm = cell(NumNums,NumSamps);
SampIm{1,1} = zeros(Xlims,Ylims,3,'uint8');
SampIm{1,1}(:,:,:) = 255;
for z = 1:NumZeros
    SampIm{1,1}(MaskLocs(z,1),MaskLocs(z,2),:) = [0 0 0];
end
for m = 1:NumNums
    for n = 1:NumSamps
        SampIm{m,n} = SampIm{1,1};
    end
end
if MakeEucMask == 0
    SampClip = MaskBin;
else
    SampClip = MaskBin(Xbuf:Xlims-Xbuf,Ybuf:Ylims-Ybuf);
end
CNTGreens = cell(NumNums,NumSamps);
SiGreens = cell(NumNums,NumSamps);
for m = 1:NumNums
    for n = 1:NumSamps
        [CNTGreens{m,n}(:,1),CNTGreens{m,n}(:,2),~] = find(CNTCells{m,n});
        [SiGreens{m,n}(:,1),SiGreens{m,n}(:,2),~] = find(SiCells{m,n});
        for g = 1:size(CNTGreens{m,n},1)
            SampIm{m,n}(CNTGreens{m,n}(g,1),CNTGreens{m,n}(g,2),:) = [0 255 0];
        end
        for g = 1:size(SiGreens{m,n},1)
            SampIm{m,n}(SiGreens{m,n}(g,1),SiGreens{m,n}(g,2),:) = [0 255 0];
        end
    end
end

if ShowIms == 1
    for m = 1:NumNums
        for n = 1:NumSamps
            figure;imshow(SampIm{m,n});
        end
    end
end