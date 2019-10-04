%Attempts to get the surface area of a Neuron.  Breaks in a few ways
%currently
function dataStruct=getSA2(dataStruct,name,method)
    for i=1:size(dataStruct,2)%for the Neuron number
        disp(num2str(i));        
        for j=1%1:size(dataStruct(i).data.(genvarname(method)),2)%for the curvature
            v = vertcat(dataStruct(i).data.(genvarname(method))(j).VAll{:});
            f = vertcat(dataStruct(i).data.(genvarname(method))(j).F{:});
            [vM,fM] = finerMeshWrapperCell(v,f,2);
            allFacesToExclude = false(size(fM,1),1);
            for k=1:16:size(v,1)-16%for a seg
                vStart = k;
                vEnd = k+31;
                
                if vEnd == 608
                    disp(vEnd)
                end
                vSeg = v(vStart:vEnd,:);
                % Find locations of faces
                f1 =(f(:,1) >= vStart & f(:,1) <= vEnd);
                f2 =(f(:,2) >= vStart & f(:,2) <= vEnd);
                f3 =(f(:,3) >= vStart & f(:,3) <= vEnd);
                fI = (f1 & f2 & f3);
                fIloc = find(fI);
                %or do
                % fIloc = find(sum(ismember(f(:,1:3),k:k+31),2)==3);                
                fB = f(fI,:);                                             
                [C,~] = convhull(vSeg);
                in = inhull(vM,vSeg,C,1.e-13*mean(abs(vSeg(:))));
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
                
                facesToExclude = threeVInSeg;
                facesToExclude(fSegI) = 0;
                %% plot the excluded region
%                 s3(vM,'k.');
%                 hold
%                 patch('vertices', vM, 'faces', fM(facesToExclude,1:3),'FaceColor','green');
                %%
                allFacesToExclude = or(allFacesToExclude,facesToExclude); %updates the allFacesToExclude logical
%                 % plot the excluded region
%                 s3(vM,'k.');
%                 hold
%                 patch('vertices', vM, 'faces', fM(allFacesToExclude,1:3),'FaceColor','green');
            end
        end  
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