%{

%}
function [LAve,LDev,YAve,YDev] = BinDatabyL(LRange, NumBins, LData, YData)

BinSize = (LRange(2)-LRange(1))/NumBins;
BinnedLs = zeros(NumBins,1);
for i = 1:NumBins
    BinnedLs(i) = LRange(1) + (i-1/2)*BinSize;
end

LBinnedData = cell(NumBins,1);
YBinnedData = cell(NumBins,1);
for i = 1:NumBins-1
    LBinnedData{i} = LData(LData >= BinnedLs(i)-(1/2)*BinSize & LData < BinnedLs(i)+(1/2)*BinSize);
    YBinnedData{i} = YData(LData >= BinnedLs(i)-(1/2)*BinSize & LData < BinnedLs(i)+(1/2)*BinSize);
end
LBinnedData{NumBins} = LData(LData >= BinnedLs(NumBins)-(1/2)*BinSize & LData <= BinnedLs(NumBins)+(1/2)*BinSize);
YBinnedData{NumBins} = YData(LData >= BinnedLs(NumBins)-(1/2)*BinSize & LData <= BinnedLs(NumBins)+(1/2)*BinSize);

LAve = zeros(NumBins,1);
LDev = zeros(NumBins,1);
YAve = zeros(NumBins,1);
YDev = zeros(NumBins,1);
for i = 1:NumBins
    LAve(i) = mean(LBinnedData{i});
    LDev(i) = std(LBinnedData{i});
    YAve(i) = mean(YBinnedData{i});
    YDev(i) = std(YBinnedData{i});
end
end