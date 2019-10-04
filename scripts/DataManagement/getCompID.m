function ID = getCompID()
    [~, out] = dos('vol');
    sc = strsplit(out,'\n');
    VolLbl = sc{2}(end-9:end);
    ID = VolLbl;
end