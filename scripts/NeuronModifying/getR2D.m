% Finds the r-squared dimension of a neuron.  Input should be of file type
% 'R2.txt'

function [naiveD,R2D,regNPts,regR2] = getR2D(fileName, filePath)
    fid = fopen(fullfile(filePath,fileName));
    for n=1:8
        tline = fgetl(fid);
        switch n
            case 2
                naiveD = str2double(tline);
            case 4
                R2D = str2double(tline);
                if R2D > 2
                  fileName
                end   
            case 6
                regNPts = uint16(str2double(tline));
            case 8
                regR2 = str2double(tline);                
        end
    end
    fclose(fid);

%     R2D = str2double(tline); 

end