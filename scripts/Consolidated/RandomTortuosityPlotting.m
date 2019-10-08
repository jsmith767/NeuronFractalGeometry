FirstMod = 1;
binRange = [1.3 1.6];
Numbins = 9;
% NatbinRange = [1.33 1.5];
% NatNumbins = 5;
BNumMods = size(plottingN(1).data.W,2);

BDbyM = cell(1,2);
BVbyM = cell(1,2);
BPbyM = cell(1,2);
BMbyM = cell(1,2);
BSAbyM = cell(1,2);
BSABbyM = cell(1,2);
BVMbyM = cell(1,2);
BRbyM = cell(1,2);
BLbyM = cell(1,2);
D = cell(1,2);
V = cell(1,2);
P = cell(1,2);
M = cell(1,2);
SA = cell(1,2);
SAB = cell(1,2);
VM = cell(1,2);
R = cell(1,2);
L = cell(1,2);
[D{1,1},V{1,1},P{1,1},M{1,1},SA{1,1},SAB{1,1},VM{1,1},R{1,1},L{1,1},BDbyM{1,1},BVbyM{1,1},BPbyM{1,1},BMbyM{1,1},BSAbyM{1,1},BSABbyM{1,1},BVMbyM{1,1},BRbyM{1,1},BLbyM{1,1},~] = GetNData_W(plottingN);
[D{1,2},V{1,2},P{1,2},M{1,2},SA{1,2},SAB{1,2},VM{1,2},R{1,2},L{1,2},BDbyM{1,2},BVbyM{1,2},BPbyM{1,2},BMbyM{1,2},BSAbyM{1,2},BSABbyM{1,2},BVMbyM{1,2},BRbyM{1,2},BLbyM{1,2},~] = GetNData_P(plottingN);

BPbyMAve = cell(1,2);
BPbyMDev = cell(1,2);
BDbyMAve = cell(1,2);
BDbyMDev = cell(1,2);
NDAve = cell(1,2);
NDDev = cell(1,2);
NAoAAve = cell(1,2);
NAoADev = cell(1,2);
NPoMAve = cell(1,2);
NPoMDev = cell(1,2);
NPoAAve = cell(1,2);
NPoADev = cell(1,2);
NVFAve = cell(1,2);
NVFDev = cell(1,2);
BPbyMAve{1,1} = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev{1,1} = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve{1,1} = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev{1,1} = zeros(1,BNumMods-(FirstMod-1));
BPbyMAve{1,2} = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev{1,2} = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve{1,2} = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev{1,2} = zeros(1,BNumMods-(FirstMod-1));
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve{1,1}(1,i) = mean(BPbyM{1,1}(i,:)./BSAbyM{1,1}(i,:));
    BPbyMDev{1,1}(1,i) = std(BPbyM{1,1}(i,:)./BSAbyM{1,1}(i,:));
    BDbyMAve{1,1}(1,i) = mean(BDbyM{1,1}(i,:));
    BDbyMDev{1,1}(1,i) = std(BDbyM{1,1}(i,:));
end
[NDAve{1,1}, NDDev{1,1}, NAoAAve{1,1}, NAoADev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},SA{1,1}./SAB{1,1});
[~, ~, NPoMAve{1,1}, NPoMDev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},P{1,1}./SA{1,1});
[~, ~, NPoAAve{1,1}, NPoADev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},P{1,1}./SAB{1,1});
[~, ~, NVFAve{1,1}, NVFDev{1,1}] = BinDatabyD(binRange,Numbins,D{1,1},VM{1,1}./V{1,1});
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve{1,2}(1,i) = mean(BPbyM{1,2}(i,:)./BSAbyM{1,2}(i,:));
    BPbyMDev{1,2}(1,i) = std(BPbyM{1,2}(i,:)./BSAbyM{1,2}(i,:));
    BDbyMAve{1,2}(1,i) = mean(BDbyM{1,2}(i,:));
    BDbyMDev{1,2}(1,i) = std(BDbyM{1,2}(i,:));
end
[NDAve{1,2}, NDDev{1,2}, NAoAAve{1,2}, NAoADev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},SA{1,2}./SAB{1,2});
[~, ~, NPoMAve{1,2}, NPoMDev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},P{1,2}./SA{1,2});
[~, ~, NPoAAve{1,2}, NPoADev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},P{1,2}./SAB{1,2});
[~, ~, NVFAve{1,2}, NVFDev{1,2}] = BinDatabyD(binRange,Numbins,D{1,2},VM{1,2}./V{1,2});

Lmax = zeros(1,size(plottingN,2));
for n = 1:size(plottingN,2)
    Lmax(1,n) = 0;
    for b = 1:size(plottingN(n).SLA,2)
        if Lmax(1,n) < max(plottingN(n).SLA{1,b}(:,1))
            Lmax(1,n) = max(plottingN(n).SLA{1,b}(:,1));
        end
    end
end
figure;scatter(BDbyM{1,2}(5,:),BLbyM{1,2}(5,:)./Lmax,'r','filled');xlabel('D');ylabel('L/L_{max}');

Tave = zeros(BNumMods-(FirstMod-1),size(plottingN,2));
for n = 1:size(plottingN,2)
    for i = 1:BNumMods-(FirstMod-1)
        Tave(i,n) = mean((plottingN(n).data.W(i).L)./(plottingN(n).data.W(i).R));
    end
end


figure;
hold on;
for i = 1:BNumMods-(FirstMod-1)
    scatter(Tave(i,:),BPbyM{1,1}(i,:)./BSAbyM{1,1}(i,:),'b','filled');
end
scatter(Tave(5,:),BPbyM{1,1}(5,:)./BSAbyM{1,1}(5,:),'r','filled');
xlabel('Tave');ylabel('P/A_s');
figure;
hold on;
for i = 1:BNumMods-(FirstMod-1)
    scatter(Tave(i,:),BPbyM{1,1}(i,:)./BSABbyM{1,1}(i,:),'b','filled');
end
scatter(Tave(5,:),BPbyM{1,1}(5,:)./BSABbyM{1,1}(5,:),'r','filled');
xlabel('Tave');ylabel('P/A_b');
figure;
hold on;
for i = 1:BNumMods-(FirstMod-1)
    scatter(Tave(i,:),BSAbyM{1,1}(i,:)./BSABbyM{1,1}(i,:),'b','filled');
end
scatter(Tave(5,:),BSAbyM{1,1}(5,:)./BSABbyM{1,1}(5,:),'r','filled');
xlabel('Tave');ylabel('A_s/A_b');
figure;
hold on;
for i = 1:BNumMods-(FirstMod-1)
    scatter(Tave(i,:),BVMbyM{1,1}(i,:)./BVbyM{1,1}(i,:),'b','filled');
end
scatter(Tave(5,:),BVMbyM{1,1}(5,:)./BVbyM{1,1}(5,:),'r','filled');
xlabel('Tave');ylabel('V_m/V_b');