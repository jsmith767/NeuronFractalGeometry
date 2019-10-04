%Grabs all the r-squared values from the mathematica output file *R2.txt
%Make sure you're in the fold with all of the output files.
%[NDs,Ds,N,R2] = getR2Ds(dir('*R2.txt'),pwd);

function [NDs,Ds,regNPts,regR2s,f] = getR2Ds(path)
%     
    parentD = pwd;
    cd(path);
    files = dir('*R2.txt');
    NDs = zeros(length(files),1);
    Ds = zeros(length(files),1);
    regNPts = zeros(length(files),1);
    regR2s = zeros(length(files),1);
    f=cell(length(files),1);
    for i=1:length(files)
       [NDs(i),Ds(i),regNPts(i),regR2s(i)] = getR2D(files(i).name,path);
       f{i}=files(i).name;
    end
    cd(parentD);
end

%output file list too?