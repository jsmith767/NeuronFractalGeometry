%Goes into the subdirectories of all folders, grabs images and puts them
%together into one thumbnail and names that thumbnail based off the parent
%folder.

%must have image magick installed on your computer for this to work
function y = ThumbnailMakerF(fileType,subdirs,currentdir)

    [P,F] = subdir(pwd);

%     subdirs = true;
%     currentdir = false;

%     fileType = '*merged.tif';

    resolutionX = 300;
    resolutionY = 300;
    resolution = ['-geometry ' num2str(resolutionX) 'x' num2str(resolutionY)];

    command = 'magick montage';

    label = '-label ''%f''';

    border = '-border 1x1';

    sp = ' ';


    currentDirectory = pwd;
    if subdirs
        [~,~,E] = fileparts(fileType);
        distinctNumbers = F;
        tileNums = zeros(1,size(F,2)); % gets the number of array sizes we need
        for i=1:size(F,2)
        tNums = ' ';
        for j =1:size(F{i},2) %loops over files in a path
            tempNums = F{i}(j); % grabs a file
            tempNums = tempNums{1}; % converts it to a string
            [~,~,ext] = fileparts(tempNums);
            if(strcmp(ext,E))
                tNums =[tNums tempNums(end-length(E))]; % get's the last digit before the path
            end
        end
        tNums = tNums(2:end);
        tileNums(i) = length(unique(tNums));%the length of the unique array tells us the tiles we need
        if(tileNums(i) > 4 || tileNums(i) < 3)
            tileNums(i) = 4;
        end
        end

        for i=1:size(P,2)
        cd(P{i});
        [~,fileName,~] = fileparts(P{i});
        fileName = [fileName '.pdf'];
        tiles = ['-tile ' num2str(tileNums(i)) 'x' num2str(tileNums(i))];
        cmd = [command sp label sp fileType sp tiles sp resolution sp border sp fileName];
        %     cmmd = [command sp '-contrast-stretch 10%' sp label sp fileType sp tiles sp resolution sp border sp 'test.pdf'];
        system(cmd);
        end
    end
    cd(currentDirectory);
    %Writes the files in the current directory to a montage
    if currentdir
        F = dir(fileType);
        tNums = ' ';
        for j =1:length(F) %loops over files in a path
            tempNums = F(j).name; % grabs a file
            tNums =[tNums tempNums(end-4)]; % get's the last digit before the path
        end
        tNums = tNums(2:end);
        tileNumsP = length(unique(tNums));%the length of the unique array tells us the tiles we need
        if(tileNumsP > 4 || tileNumsP < 3)
            tileNumsP = 4;
        end

        [~,fileName,~] = fileparts(pwd);
        fileName = [fileName '.pdf'];
        tiles = ['-tile ' num2str(tileNumsP) 'x' num2str(tileNumsP)];
        cmd = [command sp label sp fileType sp tiles sp resolution sp border sp fileName];
        %     cmmd = [command sp '-contrast-stretch 10%' sp label sp fileType sp tiles sp resolution sp border sp 'test.pdf'];
        system(cmd);
    end
end