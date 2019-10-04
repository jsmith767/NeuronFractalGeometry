%Get's the mass of a neuron and writes it to the struct. 
%Saves the struct when done running.  name is the name of the struct and
%the save name is appended to a .mat file
function dataStruct=getLength(dataStruct)
    for i=1:size(dataStruct,2)%for the curvatures
        lengthNeuron = zeros(size(dataStruct(i).VAll,2),1);
        for j=1:size(dataStruct(i).VAll,2)%for the neuron number
            lengthGroup = zeros(size(dataStruct(i).VAll{j},2),1);
            for k=1:size(dataStruct(i).VAll{j},2)%for the group
%                 disp(num2str(i));
%                 disp(num2str(j));
%                 disp(num2str(k));
                try
                    lengthGroup(k) = sum(dataStruct(i).SLA{j}{k}(:,1));
                catch
                    lengthGroup(k) = NaN;
                end
            end
            try
                lengthNeuron(j) = sum(lengthGroup);
                dataStruct(i).Length{j} = lengthNeuron(j);
            catch
                lengthNeuron(j) = NaN;
                dataStruct(i).Length{j} = NaN;
            end
        end  
    end
%     eval([name '=dataStruct;']);
%     save([name '.mat'],name,'-v7.3');
end
% %%
% clear tt
% for i=1:length(Vtest)
% for k=1:length(Vtest{i})/16-1
% [~,tt{i}(k)] = convhull(Vtest{i}((k-1)*16+1:(k+1)*16,1),Vtest{i}((k-1)*16+1:(k+1)*16,2),Vtest{i}((k-1)*16+1:(k+1)*16,3));
% end
% end

% expression = ['save(''', name, ''',''a*'',''b*'')'];
% evalin('base',expression);