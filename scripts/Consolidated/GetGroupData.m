% Get group data

binRange = [1.3 1.6];
Numbins = 9;
NatbinRange = [1.33 1.5];
NatNumbins = 5;
Use0Case = 1;
if Use0Case == 0
    FirstMod = 2;
else
    FirstMod = 1;
end
BNumMods = size(plottingN(1).data.W,2);
NumNeurs = size(plottingN,2);

[D,V,P,M,SA,SAB,VM,R,L,BDbyM,BVbyM,BPbyM,BMbyM,BSAbyM,BSABbyM,BVMbyM,BRbyM,BLbyM,BFbyM] = GetNData_W(plottingN);

plotrangeM = [min(min(BMbyM))-100 max(max(BMbyM))+100];
plotrangeL = [min(min(BLbyM))-100 max(max(BLbyM))+100];
BPbyMAve = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev = zeros(1,BNumMods-(FirstMod-1));
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve(1,i) = mean(BPbyM(i,:)./BSAbyM(i,:));
    BPbyMDev(1,i) = std(BPbyM(i,:)./BSAbyM(i,:));
    BDbyMAve(1,i) = mean(BDbyM(i,:));
    BDbyMDev(1,i) = std(BDbyM(i,:));
end

[NDAve, NDDev, NAoAAve, NAoADev] = BinDatabyD(binRange,Numbins,D,SA./SAB);
[~, ~, NPoMAve, NPoMDev] = BinDatabyD(binRange,Numbins,D,P./SA);
[~, ~, NPoAAve, NPoADev] = BinDatabyD(binRange,Numbins,D,P./SAB);
[~, ~, NVFAve, NVFDev] = BinDatabyD(binRange,Numbins,D,VM./V);

Groups = extractfield(plottingN,'Group');
Groups = unique(Groups);
Hemis = extractfield(plottingN,'Hemis');
Hemis = unique(Hemis);
GInfo = cell(4,size(Groups,2));
HInfo = cell(4,size(Hemis,2));
for g = 1:size(Groups,2)
    GInfo{1,g} = false(1,NumNeurs);
    for i = 1:NumNeurs
        if plottingN(i).Group == Groups{1,g}
            GInfo{1,g}(1,i) = 1;
        end
    end
end
for h = 1:size(Hemis,2)
    HInfo{1,h} = false(1,NumNeurs);
    for i = 1:NumNeurs
        if plottingN(i).Hemis == Hemis{1,h}
            HInfo{1,h}(1,i) = 1;
        end
    end
end
GInfo{2,1} = [0 255 255]/255;%'k';
GInfo{3,1} = 'filled';
GInfo{4,1} = 'o';
GInfo{2,2} = [255 0 255]/255;%'k';
GInfo{3,2} = 'filled';
GInfo{4,2} = '^';
GInfo{2,3} = [255 255 0]/255;%'k';
GInfo{3,3} = 'filled';
GInfo{4,3} = 's';
GInfo{2,4} = 'r';
GInfo{3,4} = 'filled';
GInfo{4,4} = 'o';
GInfo{2,5} = 'g';
GInfo{3,5} = 'filled';
GInfo{4,5} = '^';
GInfo{2,6} = 'b';
GInfo{3,6} = 'filled';
GInfo{4,6} = 's';

HInfo{2,1} = 'r';
HInfo{3,1} = 'filled';
HInfo{4,1} = 'o';
HInfo{2,2} = 'b';
HInfo{3,2} = 'filled';
HInfo{4,2} = '^';