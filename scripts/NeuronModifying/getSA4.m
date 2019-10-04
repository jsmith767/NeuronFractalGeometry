%Attempts to get the surface area of a Neuron.  Attemps to run over
%multiple segments at once
function [dataStruct,vM,fM,allFacesToExclude] =getSA4(dataStruct,name,method,fineMeshIt)
    for i=1:size(dataStruct,2)%for the Neuron number
        tic
        disp(num2str(i));        
        for j=1:size(dataStruct(i).data.(genvarname(method)),2)%for the curvature
            v = vertcat(dataStruct(i).data.(genvarname(method))(j).VAll{:});
            if ~isempty(dataStruct(i).F)
                f = vertcat(dataStruct(i).F{:});
            else
                f = vertcat(dataStruct(i).data.(genvarname(method))(j).F{:});
            end
            [vM,fM] = finerMeshWrapperCell(v,f,fineMeshIt);
            allFacesToExclude = false(size(fM,1),1);
            masterInd = 1;
            %%
%             figure;
%             hold
%             axis tight
%             view([100,100,100])
            %%
%             disp(num2str(j));  
            for k=1:size(dataStruct(i).data.(genvarname(method))(j).VAll,2)%for the group
                BranchStart = true;
                for m=1:size(dataStruct(i).SLA{k},1) % for the branches
                    if m == 1
                        vStart = 1;
                    else
                        vStart = dataStruct(i).SLA{k}(m-1,2)*16+1;
                    end
                    vEnd = (dataStruct(i).SLA{k}(m,2)-2)*16; %-2 because last two are replicas

                    vBranch = dataStruct(i).data.(genvarname(method))(j).VAll{k}(vStart:vEnd,:);
                    
                    
                    
                    for n=1:size(vBranch,1)/16-2%for the number of segments in a branch (-1 because one less branch than rings)(-1 again because looking at two segs at a time)


                        
                        if(n==1)
                            segStart1 = ((n-1)*16+1);
                            segEnd1 = (n+1)*16;
                            vSeg1 = vBranch(segStart1:segEnd1,:);

%                             f1 =(f(:,1) >= masterInd+segStart1-1 & f(:,1) <= masterInd+segEnd1-1);
%                             f2 =(f(:,2) >= masterInd+segStart1-1 & f(:,2) <= masterInd+segEnd1-1);
%                             f3 =(f(:,3) >= masterInd+segStart1-1 & f(:,3) <= masterInd+segEnd1-1);
%                             fI1 = (f1 & f2 & f3);
%                             fI1loc = find(fI1);
                            fI1loc = find(sum(ismember(f(:,1:3),masterInd+segStart1-1:masterInd+segEnd1-1),2)==3);
                            
                            [C1,~] = convhull(vSeg1);

                            in1 = inhull(vM,vSeg1,C1,1.e-13*mean(abs(vSeg1(:))));
%                             in1 = inhull(vM,vSeg1,C1,0);

                            in1Loc = find(in1); %indices of points in the segment

                            in1F = ismember(fM(:,1:3),in1Loc);%face matrix with vertices that are inside the current segment

                            sumIn1F = sum(in1F,2); %tells how many vertices of a given face(by index) is in the current segment
                            fSeg1I = ismember(fM(:,4),fI1loc); %fM indices of faces that make up the segment                               
%                             InitialFaceLoc = find(sum(ismember(f(:,1:3),(size(vBranch,1)+1):(size(vBranch,1)+16)),2)==3);
%                             InitialFaceI = ismember(fM(:,4),InitialFaceLoc);
%                             fSeg1I = or(fSeg1I,InitialFaceI);
                        else
%                             fI1loc = fI2loc;
%                             C1 = C2;
%                             in1 = in2;
%                             in1Loc = in2Loc;
                            in1F = in2F;
                            sumIn1F = sumIn2F;
                            fSeg1I = fSeg2I;
                        end
                        %%
                        
                        segStart2 = (n)*16+1;
                        segEnd2 = (n+2)*16;                        
                        vSeg2 = vBranch(segStart2:segEnd2,:);

                        % Find locations of faces            
                        f4 =(f(:,1) >= masterInd+segStart2-1 & f(:,1) <= masterInd+segEnd2-1);
                        f5 =(f(:,2) >= masterInd+segStart2-1 & f(:,2) <= masterInd+segEnd2-1);
                        f6 =(f(:,3) >= masterInd+segStart2-1 & f(:,3) <= masterInd+segEnd2-1);
                        fI2 = (f4 & f5 & f6);
                        fI2loc = find(fI2);                                              
                        %or do
                        % fIloc = find(sum(ismember(f(:,1:3),k:k+31),2)==3);                
%                         fB = f(fI,:);                                                                     
                        [C2,~] = convhull(vSeg2);                        
                        in2 = inhull(vM,vSeg2,C2,1.e-13*mean(abs(vSeg2(:))));
%                         
%                         in2 = inhull(vM,vSeg2,C2,0);                        
                        in2Loc = find(in2); %indices of points in the segment                        
                        in2F = ismember(fM(:,1:3),in2Loc);%face matrix with vertices that are inside the current segment
                        
                        
                        
                        
                        sumIn2F = sum(in2F,2); %tells how many vertices of a given face(by index) is in the current segment
                        
                        %%
                        
                        inF = or(in1F,in2F);
                        sumInF = sum(inF,2);
                        %Finds the index of faces with at least 1,2, or 3 vertices inside
                        %the segment
        %                 oneVInSeg = (sumInF >= 1);
        %                 twoVInSeg = (sumInF >= 2);
                        threeVInSeg1 = (sumIn1F == 3);
                        threeVInSeg2 = (sumIn2F == 3);
                        threeVInSegs = (sumInF == 3);

                        
                        fSeg2I = ismember(fM(:,4),fI2loc); %fM indices of faces that make up the segment
                        

                        %%
%                         fSeg1 = fM(fSeg1I,1:3); %fM faces of segment
%                         fSeg2 = fM(fSeg2I,1:3); %fM faces of segment
%                         
%                         patch('vertices', vM, 'faces', fSeg1,'FaceColor','green','FaceAlpha',0.3);
%                         patch('vertices', vM, 'faces', fSeg2,'FaceColor','green','FaceAlpha',0.3);
                        %%
                        facesToExclude1 = threeVInSeg1;
                        facesToExclude2 = threeVInSeg2;
                        facesToExclude = or(facesToExclude1,facesToExclude2);
                        facesToExclude = or(facesToExclude,threeVInSegs);
                        facesToExclude(fSeg1I) = 0;
                        facesToExclude(fSeg2I) = 0;
                        if(BranchStart)
                            InitialFaceLoc = find(sum(ismember(f(:,1:3),(masterInd+vStart-1):(masterInd+vEnd+16-1)),2)==3);
                            InitialFaceI = ismember(fM(:,4),InitialFaceLoc);
                            facesToExclude(InitialFaceI) = 0;
                        end
                        if(dataStruct(i).DM{k}(m,1)==0 && n==size(vBranch,1)/16-2)
                            EndFaceLoc = find(sum(ismember(f(:,1:3),(masterInd+segEnd2+16):(masterInd+segEnd2+31)),2)==3);
                            EndFaceI = ismember(fM(:,4),EndFaceLoc);
                            facesToExclude(EndFaceI) = 0;
                        end
%                         patch('vertices', vM, 'faces', fM(facesToExclude,1:3),'FaceColor','red','FaceAlpha',0.5);
%                         facesToExclude = and(facesToExclude,fSegI);
                        %% plot the excluded region
%                         s3(vM,'k.');
%                         hold
%                         patch('vertices', vM, 'faces', fM(facesToExclude,1:3),'FaceColor','red');
                        %%
                        allFacesToExclude = or(allFacesToExclude,facesToExclude); %updates the allFacesToExclude logical
%                         if (m == 2 && n == 4)
%                             disp(masterInd);
%                         end
                        BranchStart = false;
                    
                    end
                    % plot the excluded region
    %                 s3(vM,'k.');
    %                 hold
    %                 patch('vertices', vM, 'faces', fM(allFacesToExclude,1:3),'FaceColor','green');
                    masterInd = masterInd + (vEnd+2*16-vStart+1);
                end
            end
        dataStruct(i).data.(genvarname(method))(j).SAe{fineMeshIt+1} = getTriangleAreas(vM,fM(allFacesToExclude,1:3));
        dataStruct(i).data.(genvarname(method))(j).SAne{fineMeshIt+1} = getTriangleAreas(vM,fM(~allFacesToExclude,1:3));
        if(fineMeshIt+1 >= length(dataStruct(i).data.(genvarname(method))(j).SAne))            
            dataStruct(i).data.(genvarname(method))(j).SA = getTriangleAreas(vM,fM(~allFacesToExclude,1:3));
        end
        dataStruct(i).data.(genvarname(method))(j).SAt{fineMeshIt+1} = getTriangleAreas(vM,fM(:,1:3));
        dataStruct(i).data.(genvarname(method))(j).vM{fineMeshIt+1} = vM;
        dataStruct(i).data.(genvarname(method))(j).fM{fineMeshIt+1} = fM;
        dataStruct(i).data.(genvarname(method))(j).efM{fineMeshIt+1} = allFacesToExclude;
        end
    toc    
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