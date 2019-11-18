%Get's the mass of a neuron and writes it to the struct. 
%Saves the struct when done running.  name is the name of the struct and
%the save name is appended to a .mat file.  Does this for file structure
%'masterN'
function dataStruct=getMassBySeg2(dataStruct,method,varargin)
p= inputParser;
addParameter(p,'name','test',@ischar);
addParameter(p,'save',false,@islogical);
parse(p,varargin{:});
    for i=1:size(dataStruct,2)%for the Neuron number
%         disp(num2str(i));        
        for j=1:size(dataStruct(i).data.(genvarname(method)),2)%for the curvature
            massGroup = zeros(size(dataStruct(i).data.(genvarname(method))(j).VAll,2),1);
            for k=1:size(dataStruct(i).data.(genvarname(method))(j).VAll,2)%for the group
                massBranch = zeros(size(dataStruct(i).SLA{k},1),1);
                for m=1:size(dataStruct(i).SLA{k},1)%for the number of branches
                    if m == 1
                        vStart = 1;
                    else
                        vStart = dataStruct(i).SLA{k}(m-1,2)*16+1;
                    end
                    vEnd = (dataStruct(i).SLA{k}(m,2)-2)*16; %-2 because last two are replicas
                    vBranch = dataStruct(i).data.(genvarname(method))(j).VAll{k}(vStart:vEnd,:);
                    massSeg = zeros(size(vBranch,1)/16-1,1);
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
            dataStruct(i).data.(genvarname(method))(j).volMass = sum(massGroup);
        end  
    end
    if p.Results.save
        try
            eval([p.Results.name '=dataStruct;']);
            save([p.Results.name '.mat'],p.Results.name,'-v7.3');
        catch
            disp('Struct was not saved');
        end
    end
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