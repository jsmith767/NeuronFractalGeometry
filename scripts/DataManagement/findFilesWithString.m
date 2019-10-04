%Finds the files with a particular string.  Example '*CNT.csv' or '*Si.csv'

function list = findFilesWithString(String)
    [~,list] = system(['dir /S/B ' String]);
    list = textscan(list, '%s', 'Delimiter', '\n');
    list = list{1};
end