function batchOBJtoTXT(path)
    F = dir(fullfile(path,'*.obj'));
    for i=1:length(F)
        OBJtoTXTA(3,F(i).name,F(i).folder);
    end
end