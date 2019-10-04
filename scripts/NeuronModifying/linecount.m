function n = linecount(fid)
    n = 0;
    while ~feof(fid)
    fgetl(fid);
    n = n+1;
    end
end