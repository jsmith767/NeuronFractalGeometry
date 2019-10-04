infile = fileread('a28_0001_M.obj');

newfile = regexp(infile, '^[v]\s.*$', 'match', 'lineanchors', 'dotexceptnewline');

fid = fopen('a28_0001_Mtest.obj', 'wt');
fprintf(fid, '%s\n', newfile{:});
fclose(fid);
