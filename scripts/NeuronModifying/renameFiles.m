filesBin = dir('*.binvox');
filesOBJ = dir('*.obj');
filesR2 = dir('*R2.txt');
filesTXT = dir('*Full0.txt');

[~,cNAme] = fileparts(pwd);

for i=1:length(filesBin)
filesNewBin(i).name = strrep(filesBin(i).name,'Full0.binvox',['Full' cName '.binvox']);
filesNewOBJ(i).name = strrep(filesOBJ(i).name,'Full0.obj',['Full' cName '.obj']);
filesNewR2(i).name = strrep(filesR2(i).name,'Full0-R2.txt',['Full' cName '-R2.txt']);
filesNewTXT(i).name = strrep(filesTXT(i).name,'Full0.txt',['Full' cName '.txt']);

% movefile(filesBin(i).name,filesNewBin(i).name);
movefile(filesOBJ(i).name,filesNewOBJ(i).name);
movefile(filesR2(i).name,filesNewR2(i).name);
movefile(filesTXT(i).name,filesNewTXT(i).name);
end