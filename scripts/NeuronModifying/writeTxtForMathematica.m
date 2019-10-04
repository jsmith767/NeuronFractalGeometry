%load('3_0001Full100_L-0_25.mat') should load a matlab struct that has
%coordinates of a boxCount.  Typically a fairly fine one.
%accepts a struct with fields 'x','y', and 'z' coordinates and writes a
%text file that mathematica can read.

function writeTxtForMathematica(s,fileName)
    v = [extractfield(s,'x');extractfield(s,'y');extractfield(s,'z')];
%     fileName = '3_0001.txt';
    formatSpec = ['{%d,%d,%d}' newline];
    fileID = fopen(fileName,'w');
    fprintf(fileID,formatSpec,v);
    fclose(fileID);
end