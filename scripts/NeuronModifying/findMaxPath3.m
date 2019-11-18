%mP = the maximum upstream path
%mID = the ID of the max path.
%sP = the sum of the upstream paths
%sID = the ID of the sum of the upstream paths
%still broken, having a hard time runnign through segments
function [mSP,mSPF,mP,mID,sP,sID] = findMaxPath3(P,SLA,DM,segL,CL)
    m = 0;
    for i=1:length(P) %finds the highest numbered branch in the group
        if max(P{i}) > m
        m = max(P{i});
        end
    end
    sP(1,1) = sum(SLA(nonzeros([1 DM(1,2:end)]),1)); %finds the sum of paths from the soma
    sID{1,1} = [1 DM(1,2:end)]; %get the ID of that path
    for i=1:m  %loop through all branches in group
        mP(i,1) = 0; %initialize the max path to compare to
        for j = 1:length(P) %loop through all possible paths
            if ismember(i-1,P{j}) %if the start of that branch exists in the jth path.
                Ptemp = P{j}(P{j} > i-1); %find all branches upstream (away from soma) of that start
                if sum(SLA(Ptemp,1))> mP(i,1) %if this is the new max path
                    mP(i,1) = sum(SLA(Ptemp,1));%set the value
                    mID{i,1} = Ptemp;%set the ID
                end
            end         
        end

        sP(i+1,1) = sum(SLA(nonzeros(DM(i,2:end)),1));%set the sum of the branches upstream
        sID{i+1,1} = nonzeros(DM(i,2:end)); %set that ID of all those branches
    end
    %sets the mP array so that duplicate indices have values
    for i=find(~cellfun('isempty',CL))'
        for j=1:length(CL{i})
            mP(CL{i}(j))=max(mP(CL{i}));
        end
    end
    %finds the max paths for all the segments
    step = 0.1;
    for i=1:m
        for j=length(segL{i}):-1:1
            if DM(i,1) == 0
                mSP{i,1}(j,1)= sum(segL{i}((j+1):end));
                ind = 1;
                for k=step:step:segL{i}(j)
                    mSPF{i,1}{j,1}(ind,1) = mSP{i,1}(j,1)+k;
                    ind = ind+1;
                end
            else
                mSP{i,1}(j,1)= mP(min(mID{i+1}),1)+sum(segL{i}((j+1):end));
                ind = 1;
                for k=step:step:segL{i}(j)            
                    mSPF{i,1}{j,1}(ind,1) = mSP{i,1}(j,1)+k;               
                    ind = ind+1;
                end
            end
        end  
    end
    sP = sP(~cellfun('isempty',sID));
    sID = sID(~cellfun('isempty',sID));
    mP = mP(~cellfun('isempty',mID));
    mID = mID(~cellfun('isempty',mID));
    
        
%     for i=m:-1:1
%         mP{i} = 0;
%         for j = 1:length(P)
%             if ismember(i,P{j})
%                 Ptemp = P{j}(P{j} >= i);
%                 if sum(SLA(Ptemp,1))> mP{i}
%                     mP{i} = sum(SLA(Ptemp,1));
%                 end
%             end
%         end
%     end
end