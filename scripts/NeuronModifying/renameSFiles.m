files = dir('*.png');



for i=1:length(files)
    rep = regexp(files(i).name,'\d*.png','match');
    num = rep{1}(1:end-4);
    newNum = num2str(str2double(num),'%03d');
    filesNew(i).name = strrep(files(i).name,rep,[newNum '.png']);
    filesNew(i).name = filesNew(i).name{1}; 
    if ~exist(filesNew(i).name,'file')
        movefile(files(i).name,filesNew(i).name);
    end
end
