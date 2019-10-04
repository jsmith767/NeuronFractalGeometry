%input the familes variable.  
%this function writes the profiles in the area file to the given struct
%with corrseponding names.
%'families' should be imported as a cell array of strings
%'area' should be imported as a numerical matrix
%dataStruct should be a structure that already contains similar string
%names as those in afamilies
function dataStruct = setProfiles(families,area,dataStruct)
%first convert the cell array of strings to cell array of chars
    a = cell(size(families));
    for i=1:size(families,1)%neurons
    for j=1:size(families,2)%curvatures
        a{i,j} = char(families{i,j});
        [~,a{i,j},~]=fileparts(a{i,j});
    end
    end
    %next we need to find the index of where the current neuron from our struct
    %is stored in the array we got from afamilies
    for i=1:length(dataStruct)
        for j=1:length(dataStruct(i).name)
            Index = strcmp(a,dataStruct(i).name{j});
            dataStruct(i).P{j} = area(Index);%aArea should have the same index as afamilies
        end
    end
end