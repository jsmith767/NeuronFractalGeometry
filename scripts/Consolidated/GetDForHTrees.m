% RS = load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Straight\HTreeR_S12It.mat');
% MS = load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It-Straight\masterH_S12It.mat');
% RC = load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It\HTreeR_C12It.mat');
% MC = load('D:\Conor\Research\Mathematica\HTree-Models\3D-12It\masterH_C12It.mat');

Dvals = {'1.05','1.10','1.15','1.20','1.25','1.30','1.35','1.40','1.45','1.50','1.55','1.60','1.65','1.70','1.75','1.80','1.85','1.90','1.95','2.00'};
% Nvals = {'01'};
Nvals = {'01','02','03','04','05','06','07','08','09','10'};

% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
clr = flipud(clr);
interpdiv = 3;
interpclr = zeros(size(clr,1)+((interpdiv-1)*(size(clr,1)-1)),3);
for i = 1:size(clr,1)-1
    for j = 1:interpdiv
        interpclr((i-1)*interpdiv+j,:) = clr(i,:) + ((clr(i+1,:)-clr(i,:))./interpdiv)*(j-1);
    end
end
interpclr(end,:) = clr(end,:);

Dval = cell(size(Nvals,2),size(Dvals,2));
Nval = cell(size(Nvals,2),size(Dvals,2));
for i = 1:size(Dvals,2)
    for j = 1:size(Nvals,2)
        Dval{j,i} = Dvals{1,i};
        Nval{j,i} = Nvals{1,j};
    end
end

CHTreeD = cell(size(Nvals,2),size(Dvals,2));
CHTreeC = cell(size(Nvals,2),size(Dvals,2));
SHTreeD = zeros(1,size(Dvals,2));
SHTreeC = zeros(1,size(Dvals,2));
for i = 1:size(Dvals,2)
    for j = 1:size(Nvals,2)
        CHTreeD{j,i} = RC.HTreeR{j,i}.R.D;
        CHTreeC{j,i} = MC.masterH(1,(i-1)*size(Nvals,2)+j).NormP;
    end
    SHTreeD(1,i) = RS.HTreeR(1,i).R.D;
    SHTreeC(1,i) = MS.masterH(1,i).NormP;
end
CplotC = zeros(2,size(Nvals,2)*size(Dvals,2));
figure
hold on;
for i = 1:size(Dvals,2)
    for j = 1:size(Nvals,2)
        CplotC(:,(i-1)*size(Nvals,2)+j) = [CHTreeD{j,i} CHTreeC{j,i}];
    end
    scatter(CplotC(1,(i-1)*size(Nvals,2)+1:i*size(Nvals,2)),CplotC(2,(i-1)*size(Nvals,2)+1:i*size(Nvals,2)),25,'MarkerFaceColor', interpclr(i+3,:), 'MarkerEdgeColor', interpclr(i+3,:));
end
legend(Dvals,'AutoUpdate','off');
for i = 1:size(Dvals,2)
    scatter(SHTreeD(1,i),SHTreeC(1,i),121,'s','MarkerFaceColor', interpclr(i+3,:), 'MarkerEdgeColor', interpclr(i+3,:));
end
hold off;