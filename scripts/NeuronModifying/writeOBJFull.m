function y = writeOBJFull(V,F,num,folderName)
%     mkdir([pwd() '\Objs'], '/time'); % Use this when on a new computer
%     with a different path.
    if exist(['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\' folderName],'dir') == 0 
        mkdir('C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\', folderName)
    end
    extension = '.obj';
    name =  folderName;
    name = [name num2str(num) extension];
    fileID = fopen(name, 'wt');

    for i=1:length(V)
        fprintf(fileID,'v %.4f %.4f %.4f\n',V(i,:));
    end
    fprintf(fileID, '\n');
%     for i=1:length(VN)
%         fprintf(fileID,'vn %.4f %.4f %.4f\n',VN(i,:));
%     end
    fprintf(fileID, ['\n' 'g grp1\n']);
    for i=1:length(F)
        fprintf(fileID,'f %d//%d %d//%d %d//%d \n',F(i,1),F(i,1), F(i,2), F(i,2), F(i,3), F(i,3));
    end   

    fclose(fileID);
    folderName = ['C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\' folderName]; 
    movefile(name,folderName);
end