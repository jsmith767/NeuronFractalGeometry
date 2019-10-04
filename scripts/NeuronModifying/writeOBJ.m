function y = writeOBJ(V,num,folderName)
%     mkdir([pwd() '\Objs'], '/time'); % Use this when on a new computer
%     with a different path.
    if exist(['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\' folderName],'dir') == 0 
        mkdir('C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\', folderName)
    end
    extension = '.obj';
    name =  folderName;
    name = [name num2str(num) extension];
    fileID = fopen(name, 'w');
    for i=1:length(V)
        fprintf(fileID,'v %.4f %.4f %.4f\n',V(i,:));
    end
    fclose(fileID);
    folderName = ['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\' folderName];
    movefile(name,folderName); %cannot be in the folder in which you are moving to 
end