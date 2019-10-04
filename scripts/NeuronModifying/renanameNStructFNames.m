function neuronStruct = renanameNStructFNames(neuronStruct)
    for j=1:length(neuronStruct(1).name)
    neuronStruct(1).name{j} = strrep(neuronStruct(1).name{j},'Full0','Full000');
    end
    for j=1:length(neuronStruct(2).name)
    neuronStruct(2).name{j} = strrep(neuronStruct(2).name{j},'Full25','Full025');
    end
    for j=1:length(neuronStruct(3).name)
    neuronStruct(3).name{j} = strrep(neuronStruct(3).name{j},'Full50','Full050');
    end
    for j=1:length(neuronStruct(4).name)
    neuronStruct(4).name{j} = strrep(neuronStruct(4).name{j},'Full75','Full075');
    end
end