[P F] = subdir(pwd);
files = dir;
currentDirectory = pwd;
Xs = zeros(1,size(P,2));
for i=1:size(P,2)
    [~,folderName,~] = fileparts(P{i});
    cd(P{i});
    Xs(i) = str2num(folderName);
    [~,Ds{i},~,~] = getR2Ds(dir('*R2.txt'),pwd);
end
cd(currentDirectory);
for i=1:length(Ds)
Ms(i) = mean(Ds{i});
stds(i) = std(Ds{i});
end
scatter(Xs,Ms);
errorbar(Xs,Ms,stds,'.k');
xlabel('% curved');
ylabel('D');
[~,type,~] = fileparts(currentDirectory);
title(['Variation in D vs curvature (' type ')']);