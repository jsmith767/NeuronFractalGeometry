function bc = boxCountWrapper(curvatureFolder)
mF = 'binaries';
folders = dir(fullfile(mF,'m*'));
for m=1:length(folders)
    files = dir(fullfile(mF,folders(m).name,'*.mat')); % looks for all files
%     filesDone = dir(fullfile(mF,['bc' extractAfter(folders(m).name,"m")],'*.mat')); %sees which files are already done
    mkdir(fullfile(mF,['bc' extractAfter(folders(m).name,"m")]));
    for n=1:length(files)
        x = load(fullfile(mF,folders(m).name,files(n).name));
        bc.name = char(extractBefore(files(n).name,"Full"));
        bc.Curvature = str2double(extractAfter(folders(m).name,"m"));
        ns = boxCount(x.s,4);  %'L-0_25'->4
        bc.res = extractfield(ns,'res');
        bc.L = extractfield(ns,'L');
        bc.N = extractfield(ns,'N');
        save(fullfile(mF,['bc' extractAfter(folders(m).name,"m")],[bc.name '-BC.mat']),'bc');
%         parsave(fullfile(mF,['bc' extractAfter(folders(m).name,"m")],[bc.name '-BC.mat']),bc(n));
    end
end
end