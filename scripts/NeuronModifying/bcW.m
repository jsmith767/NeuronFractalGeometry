%boxCountWrapper that explictely looks for a folder in the function.  Then
%just loops through all the files in that folder.
function bc = bcW(curvatureFolder)
    mF = 'binaries'; 
    cf = ['m' curvatureFolder];
    files = dir(fullfile(mF,cf,'*.mat')); % looks for all files
    %     filesDone = dir(fullfile(mF,['bc' extractAfter(folders(m).name,'m')],'*.mat')); %sees which files are already done
    if exist(fullfile(mF,['bc' extractAfter(cf,"m")]), 'dir')
        disp(['Folder ' 'bc' curvatureFolder ' already exists']);
    else
        mkdir(fullfile(mF,['bc' extractAfter(cf,"m")]));
    end
    filesDone = dir(fullfile(mF,['bc' curvatureFolder],'*.mat'));
    FD = extractfield(filesDone,'name');
    F = extractfield(files,'name');
    FD = extractBefore(FD,'-BC');
    F = extractBefore(F,'Full');
    files = files(~ismember(F,FD));
    for n=1:length(files)
        x = load(fullfile(mF,cf,files(n).name));
        bc.name = char(extractBefore(files(n).name,"Full"));
        bc.Curvature = str2double(extractAfter(cf,"m"));
        ns = boxCount(x.s,4);  %'L-0_25'->4
        bc.res = extractfield(ns,'res');
        bc.L = extractfield(ns,'L');
        bc.N = extractfield(ns,'N');
        save(fullfile(mF,['bc' extractAfter(cf,"m")],[bc.name '-BC.mat']),'bc');
    %         parsave(fullfile(mF,['bc' extractAfter(folders(m).name,"m")],[bc.name '-BC.mat']),bc(n));
    end
end