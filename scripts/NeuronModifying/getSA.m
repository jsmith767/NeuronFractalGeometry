%Get's the mass of a neuron and writes it to the struct. 
%Saves the struct when done running.  name is the name of the struct and
%the save name is appended to a .mat file
function dataStruct=getSA(dataStruct,name,method)
    for i=1:size(dataStruct,2)%for the Neuron number
        disp(num2str(i));        
        for j=5%1:size(dataStruct(i).data.(genvarname(method)),2)%for the curvature
%             in = cell(size(dataStruct(i).data.(genvarname(method))(j).VAll,2),1);
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
                    %find the faces of the branches in the branch
                    fBranch = dataStruct(i).data.(genvarname(method))(j).F{k};
                    fB1 =(fBranch(:,1) >= vStart & fBranch(:,1) <= vEnd);
                    fB2 =(fBranch(:,2) >= vStart & fBranch(:,2) <= vEnd);
                    fB3 =(fBranch(:,3) >= vStart & fBranch(:,3) <= vEnd);
                    fBI = (fB1 & fB2 & fB3);
                    fB = fBranch(fBI,:);
                    massSeg = zeros(size(vBranch,1)/16-1,1);
                    for n=1:size(vBranch,1)/16-1%for the number of segments in a branch (-1 because one less branch than rings)
                        branchStart = ((n-1)*16+1);
                        branchEnd = (n+1)*16;
                        vSeg = vBranch(branchStart:branchEnd,:);
                        
                        
                        
                        [C,massSeg(n)] = convhull(vSeg);
%                         TRI = delaunay(vSeg(:,1),vSeg(:,2),vSeg(:,3));
                        [v,f] = finerMeshWrapperCell(dataStruct(i).data.(genvarname(method))(j).VAll, ...
                            dataStruct(i).data.(genvarname(method))(j).F,3);
%                         t = tsearchn(vSeg,TRI,v);
%                         for t=1:size(in,1)
                         in = inhull(v,vSeg,C);
%                         end
                    end
                    massBranch(m) = sum(massSeg);
                end
                massGroup(k) = sum(massBranch);
            end
            dataStruct(i).data.(genvarname(method))(j).Mass = sum(massGroup);
        end  
    end
    try
        eval([name '=dataStruct;']);
        save([name '.mat'],name,'-v7.3');
    catch
        disp('Struct was not saved');
    end
end
%%
% figure
% trisurf(C,vSeg(:,1),vSeg(:,2),vSeg(:,3),'FaceColor','cyan','FaceAlpha',0.5)
% hold
% scatter3(vSeg(in,1),vSeg(in,2),vSeg(in,3),'b*')
%%
% tsearchn([X(:) Y(:) Z(:)],TRI,testpoints)

% %%
% clear tt
% for i=1:length(Vtest)
% for k=1:length(Vtest{i})/16-1
% [~,tt{i}(k)] = convhull(Vtest{i}((k-1)*16+1:(k+1)*16,1),Vtest{i}((k-1)*16+1:(k+1)*16,2),Vtest{i}((k-1)*16+1:(k+1)*16,3));
% end
% end

% expression = ['save(''', name, ''',''a*'',''b*'')'];
% evalin('base',expression);