%{
This function takes in data that relates fractal dimension (DData) to some
value (YData) and bins the data within a specified range of D (DRange),
given as a 2-vector, for a specified number of bins (NumBins). DData and
YData are expected to be vectors of the same length. The function outputs
the average fractal dimension (DAve) and average value (YAve) as well as
the standard deviation of the fractal dimension (DDev) and value (YDev)
within each bin.
%}
function [DAve,DDev,YAve,YDev] = BinDatabyD_Median(DRange, NumBins, DData, YData)

BinSize = (DRange(2)-DRange(1))/NumBins;
BinnedDs = zeros(NumBins,1);
for i = 1:NumBins
    BinnedDs(i) = DRange(1) + (i-1/2)*BinSize;
end

DBinnedData = cell(NumBins,1);
YBinnedData = cell(NumBins,1);
for i = 1:NumBins-1
    DBinnedData{i} = DData(DData >= BinnedDs(i)-(1/2)*BinSize & DData < BinnedDs(i)+(1/2)*BinSize);
    YBinnedData{i} = YData(DData >= BinnedDs(i)-(1/2)*BinSize & DData < BinnedDs(i)+(1/2)*BinSize);
end
DBinnedData{NumBins} = DData(DData >= BinnedDs(NumBins)-(1/2)*BinSize & DData <= BinnedDs(NumBins)+(1/2)*BinSize);
YBinnedData{NumBins} = YData(DData >= BinnedDs(NumBins)-(1/2)*BinSize & DData <= BinnedDs(NumBins)+(1/2)*BinSize);

DAve = zeros(NumBins,1);
DDev = zeros(NumBins,1);
YAve = zeros(NumBins,1);
YDev = zeros(NumBins,1);
for i = 1:NumBins
    DAve(i) = median(DBinnedData{i});
    DDev(i) = std(DBinnedData{i});
    YAve(i) = median(YBinnedData{i});
    YDev(i) = std(YBinnedData{i});
end
end