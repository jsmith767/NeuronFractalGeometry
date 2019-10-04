%Attempts to get the surface area of a Neuron.  Breaks in a few ways
%currently
function [dataStruct,vM,fM,allFacesToExclude] =getSA3(dataStruct,name,method,fineMeshIt)
    for i=2%1:size(dataStruct,2)%for the Neuron number
        tic
%         disp(num2str(i));        
        for j=2%1:size(dataStruct(i).data.(genvarname(method)),2)%for the curvature
            v = vertcat(dataStruct(i).data.(genvarname(method))(j).VAll{:});
            f = vertcat(dataStruct(i).data.(genvarname(method))(j).F{:});
            [vM,fM] = finerMeshWrapperCell(v,f,fineMeshIt);
            allFacesToExclude = false(size(fM,1),1);
            masterInd = 1;
            
            figure;
            hold
            axis tight;
            view([100,100,100])
            
            disp(num2str(j));  
            for k=1:size(dataStruct(i).data.(genvarname(method))(j).VAll,2)%for the group
                for m=1:size(dataStruct(i).SLA{k},1) % for the branches
                    if m == 1
                        vStart = 1;
                    else
                        vStart = dataStruct(i).SLA{k}(m-1,2)*16+1;
                    end
                    vEnd = (dataStruct(i).SLA{k}(m,2)-2)*16; %-2 because last two are replicas
    %             for k=1:16:size(v,1)-16%for a seg
    %                 vStart = k;
    %                 vEnd = k+31;

%                     if vEnd == 608
%                         disp(vEnd)
%                     end
%                     vSeg = v(vStart:vEnd,:);
                    vBranch = dataStruct(i).data.(genvarname(method))(j).VAll{k}(vStart:vEnd,:);

                    
                    for n=1:size(vBranch,1)/16-1%for the number of segments in a branch (-1 because one less branch than rings)
                        segStart = ((n-1)*16+1);
                        segEnd = (n+1)*16;
                        vSeg = vBranch(segStart:segEnd,:);

                        % Find locations of faces
                        f1 =(f(:,1) >= masterInd+segStart-1 & f(:,1) <= masterInd+segEnd-1);
                        f2 =(f(:,2) >= masterInd+segStart-1 & f(:,2) <= masterInd+segEnd-1);
                        f3 =(f(:,3) >= masterInd+segStart-1 & f(:,3) <= masterInd+segEnd-1);
                        fI = (f1 & f2 & f3);
                        fIloc = find(fI);
                        %or do
                        % fIloc = find(sum(ismember(f(:,1:3),k:k+31),2)==3);                
%                         fB = f(fI,:);                                             
                        [C,~] = convhull(vSeg);
%                         in = inhull(vM,vSeg,C,1.e-13*mean(abs(vSeg(:))));
                        in = inhull(vM,vSeg,C,0);
                        inLoc = find(in); %indices of points in the segment
                        inF = ismember(fM(:,1:3),inLoc);%face matrix with vertices that are inside the current segment
                        sumInF = sum(inF,2); %tells how many vertices of a given face(by index) is in the current segment
                        %Finds the index of faces with at least 1,2, or 3 vertices inside
                        %the segment
        %                 oneVInSeg = (sumInF >= 1);
        %                 twoVInSeg = (sumInF >= 2);
                        threeVInSeg = (sumInF == 3);

                        fSegI = ismember(fM(:,4),fIloc); %fM indices of faces that make up the segment
                        fSeg = fM(fSegI,1:3); %fM faces of segment
                        
                        patch('vertices', vM, 'faces', fSeg,'FaceColor','green','FaceAlpha',0.3);
                        
                        facesToExclude = threeVInSeg;
                        facesToExclude(fSegI) = 0;
%                         patch('vertices', vM, 'faces', fM(facesToExclude,1:3),'FaceColor','red','FaceAlpha',0.5);
%                         facesToExclude = and(facesToExclude,fSegI);
                        %% plot the excluded region
        %                 s3(vM,'k.');
        %                 hold
                        patch('vertices', vM, 'faces', fM(facesToExclude,1:3),'FaceColor','red');
                        %%
                        allFacesToExclude = or(allFacesToExclude,facesToExclude); %updates the allFacesToExclude logical
                        if (m == 2 && n == 4)
                            disp(masterInd);
                        end
                    
                    end
                    % plot the excluded region
    %                 s3(vM,'k.');
    %                 hold
    %                 patch('vertices', vM, 'faces', fM(allFacesToExclude,1:3),'FaceColor','green');
                    masterInd = masterInd + (vEnd+2*16-vStart+1);
                end
            end
        dataStruct(i).data.allangles(j).SAe{fineMeshIt+1} = getTriangleAreas(vM,fM(allFacesToExclude,1:3));
        dataStruct(i).data.allangles(j).SAne{fineMeshIt+1} = getTriangleAreas(vM,fM(~allFacesToExclude,1:3));
        if(fineMeshIt+1 >= length(dataStruct(i).data.allangles(j).SAne))            
            dataStruct(i).data.allangles(j).SA = getTriangleAreas(vM,fM(~allFacesToExclude,1:3));
        end
        dataStruct(i).data.allangles(j).SAt{fineMeshIt+1} = getTriangleAreas(vM,fM(:,1:3));
        dataStruct(i).data.allangles(j).vM{fineMeshIt+1} = vM;
        dataStruct(i).data.allangles(j).fM{fineMeshIt+1} = fM;
        dataStruct(i).data.allangles(j).efM{fineMeshIt+1} = allFacesToExclude;
        end
    toc    
    end
%     try
%         eval([name '=dataStruct;']);
%         save([name '.mat'],name,'-v7.3');
%     catch
%         disp('Struct was not saved');
%     end
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