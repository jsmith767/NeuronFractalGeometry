function y = printVforBoxCount(V,num,folderName)
    if exist(['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\boxCount\' folderName],'dir') == 0 
        mkdir('C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\boxCount\', folderName)
    end
    extension = '.txt';
    name =  folderName;
    name = [name num2str(num) extension];
    fileID = fopen(name, 'w');
    for i=1:length(V)
        fprintf(fileID,'{%.4f, %.4f, %.4f }\n',V(i,:));
    end
    fclose(fileID);
    folderName = ['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\boxCount\' folderName]; 
    movefile(name,folderName);
    
end