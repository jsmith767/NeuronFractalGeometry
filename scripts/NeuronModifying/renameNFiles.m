[~,cName] = fileparts(pwd);
cNameOld = num2str(str2num(cName));

filesBin = dir(['*Full' cNameOld '.binvox']);
filesOBJ = dir(['*Full' cNameOld '.obj']);
filesR2 = dir(['*Full' cNameOld '-R2.txt']);
filesTXT = dir(['*Full' cNameOld '.txt']);

for i=1:length(filesBin)
filesNewBin(i).name = strrep(filesBin(i).name,['Full' cNameOld '.binvox'],['Full' cName '.binvox']);
filesNewOBJ(i).name = strrep(filesOBJ(i).name,['Full' cNameOld '.obj'],['Full' cName '.obj']);
filesNewR2(i).name = strrep(filesR2(i).name,['Full' cNameOld '-R2.txt'],['Full' cName '-R2.txt']);
filesNewTXT(i).name = strrep(filesTXT(i).name,['Full' cNameOld '.txt'],['Full' cName '.txt']);

movefile(filesBin(i).name,filesNewBin(i).name);
movefile(filesOBJ(i).name,filesNewOBJ(i).name);
movefile(filesR2(i).name,filesNewR2(i).name);
movefile(filesTXT(i).name,filesNewTXT(i).name);
end


% for j=1:length(ADataEnd(1).name)
% ADataEnd(1).name{j} = strrep(ADataEnd(1).name{j},'Full0','Full000');
% end
% for j=1:length(ADataEnd(2).name)
% ADataEnd(2).name{j} = strrep(ADataEnd(2).name{j},'Full25','Full025');
% end
% for j=1:length(ADataEnd(3).name)
% ADataEnd(3).name{j} = strrep(ADataEnd(3).name{j},'Full50','Full050');
% end
% for j=1:length(ADataEnd(4).name)
% ADataEnd(4).name{j} = strrep(ADataEnd(4).name{j},'Full75','Full075');
% end