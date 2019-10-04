%reads the slopeData. if mat ==1 then exports just the values as a matrix.
%Otherwise outputs a cell with filenames and corresponding values.
function slopeData = readSlopes(fileName,filePath,mat)
    Q = readtable(fileName);
    Q = table2cell(Q);
    slopeData = Q;
    if mat == 1
        slopeData = cell2mat({slopeData{:,2}});
    end
end
