function y = writeOBJFulltest(V,F,G,num,folderName)
%     mkdir([pwd() '\Objs'], '/time'); % Use this when on a new computer
%     with a different path.
%     path = 'C:\Users\jsmit\Google Drive\Research\Matlab\AnalyzeNeurons\Data\Objs\';
%     if exist([path folderName],'dir') == 0 
%         mkdir(path, folderName)
%     end
%     format long;
%%%%%%% Basal path %%%%
%     path = ['C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\' num2str(100*num,'%3.0f') '\'];
%%%%%%%%%%%%%%%%%%%
%%%%%%% Apical path %%%%
%     path = ['C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Apical\' num2str(100*num,'%3.0f') '\'];
%%%%%%%%%%%%%%%%%%%
%%%%%%% Test path %%%%%%
%     path = ['C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\FileTesting\' num2str(100*num,'%3.0f') '\'];
%%%%%%%
%%%%%%% SSD path %%%%%%
%     path = ['N:\NeuronOBJsEnd\Apical\' num2str(100*num,'%3.0f') '\'];
%     path = ['N:\NeuronInitChange\Basal\' num2str(100*num,'%03.0f') '\'];
    path = ['E:\Julian\Original\Basal\' num2str(100*num,'%03.0f') '\'];
%     path = 'N:\NeuronInitChange\Apical\1_0004\OBJsEnd'; 
%     path = ['C:\Users\jsmit\Google Drive\Research\Comp\NeuronVizualization\Basal\' num2str(100*num,'%03.0f') '\'];
 
%%%%%%%
    if exist(path,'dir') == 0 
        mkdir(path)
    end
    extension = '.obj';
    name =  folderName;
    name = [name num2str(100*num,'%03.0f') extension];
    
%     if length(G) > 1
%        sansoma = true; 
%     else 
%        sansoma = false;
% %     end
%     if sansoma
%         k = 2;
%         somaVertNum = (G(2)-G(1));
%         G = G - somaVertNum;
%     else
%         k = 1;
%     end
    fileID = fopen(name, 'wt');
    for k=1:length(G)
        Vnew = V{k};
        Fnew = F{k};
%         Vnew( ~any(Vnew,2), : ) = [];  %rows with zero values are removed!!! none of the neurons should have a problem with this.
%         Fnew( ~any(Fnew,2), : ) = [];
%         if sansoma
%             Fnew = Fnew - somaVertNum;
%         end
%         for j=1:length(G)
            for i=1:length(Vnew)
                fprintf(fileID,'v %.4f %.4f %.4f\n',Vnew(i,:));
            end
            fprintf(fileID, '\n');
        %     for i=1:length(VN)
        %         fprintf(fileID,'vn %.4f %.4f %.4f\n',VN(i,:));
        %     end
            gNum = num2str(G(k)); %writes the faces.  Comment this out if using writeOBJSegsTest for debugging.
            fprintf(fileID, ['\n' 'g grp' gNum '\n']);
            for i=1:length(Fnew)
                fprintf(fileID,'f %d//%d %d//%d %d//%d \n',Fnew(i,1),Fnew(i,1), Fnew(i,2), Fnew(i,2), Fnew(i,3), Fnew(i,3));
            end   
%     end
%         k = k + 1;
    end
    fclose(fileID);
%     folderName = [path folderName]; %This is used to separate the files into folders of the filename
%     movefile(name,folderName,'f');
%     path = [path num2str(100*num,'%3.0f')]
    movefile(name,path,'f'); %used for batch processing into one big folder.
end