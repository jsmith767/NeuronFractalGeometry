%Get's the mass of a neuron and writes it to the struct. 
%Saves the struct when done running.  name is the name of the struct and
%the save name is appended to a .mat file
function dataStruct=getMass(dataStruct,name)
    for i=1:size(dataStruct,2)%for the curvatures
        disp(num2str(i));
        massNeuron = zeros(size(dataStruct(i).VAll,2),1);
        for j=1:size(dataStruct(i).VAll,2)%for the neuron number
            massGroup = zeros(size(dataStruct(i).VAll{j},2),1);
            for k=1:size(dataStruct(i).VAll{j},2)%for the group
                massBranch = zeros(size(dataStruct(i).SLA{j}{k},1),1);
                for m=1:size(dataStruct(i).SLA{j}{k},1)%for the number of branches
                    if m == 1
                        vStart = 1;
                    else
                        vStart = dataStruct(i).SLA{j}{k}(m-1,2)*16+1;
                    end
                    vEnd = (dataStruct(i).SLA{j}{k}(m,2)-2)*16; %-2 because last two are replicas
                    vBranch = dataStruct(i).VAll{j}{k}(vStart:vEnd,:);
                    massSeg = zeros(32,1);
                    for n=1:size(vBranch,1)/16-1%for the number of segments in a branch (-1 because one less branch than rings)
                        branchStart = ((n-1)*16+1);
                        branchEnd = (n+1)*16;
                        vSeg = vBranch(branchStart:branchEnd,:);
                        [~,massSeg(n)] = convhull(vSeg);
                    end
                    massBranch(m) = sum(massSeg);
                end
                massGroup(k) = sum(massBranch);
            end
            massNeuron(j) = sum(massGroup);
            dataStruct(i).Mass{j} = massNeuron(j);
        end  
    end
%     try
%         eval([name '=dataStruct;']);
%         save([name '.mat'],name,'-v7.3');
%     catch
%         disp('Struct was not saved');
%     end
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