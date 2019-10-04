%writes the duaghter matrix for each branch segment. 
%Also compiles a list of each "wonky" joint.  These joints will then be
%skipped over when straightening the neuron.
%SLA = segment length matrix (written in 'CalcNeuronBranchLengths.m')
%VRM = vertex replication matrix written by 'distVertPos.m'
%Example "[DM, WL] = daughterM(SLA,VRM);"
function [DM, WL, PL] = daughterM(SLA,VRM)
    DM = zeros(size(SLA,1),size(SLA,1));
    PL = zeros(size(SLA,1),1);
    WL = [];
    for BranchN=size(SLA,1):-1:2 %count down the branch number from the end
        % BranchN = length(SLA)-2;
        tempV = SLA(BranchN,2); %Finds the vertex that is associated with the end of the branch
        parentV = VRM(2,tempV-1); %Finds the vertex of the parent branch
        parent = find(SLA(:,2)== parentV); %finds the branch number of the parent
        if isempty(parent) % if the above test fails that means we have a wonky joint.
            parent = find(SLA(:,2)== parentV + 1)-1; %finds the first parentless branch of the pair and sets its parent to the wonky one. 
            if isempty(parent) % if we're still empty.  This means the point was close enough to be called the same point in disVerPos.
                parent = find(SLA(:,2) == parentV -1);
            end
            if ~any(WL == parent) %sets that parent  to the wonky list if it's not already there.
                WL = [WL ; parent];
            end
        end
        PL(BranchN) = parent;
        DM(parent,DM(parent,1)+2)= BranchN; %assigns the daughter branch to the parents branches list of daughters
        DM(parent,1)= DM(parent,1)+1; % increase the number of daughters in column 1
        if(DM(BranchN,1) > 0) %if there are daughters this adds the daughters of the daughter to the parent as well
            for i=1:DM(BranchN,1)
                DM(parent,DM(parent)+2) =DM(BranchN,i+1);
                DM(parent,1)= DM(parent,1)+1;
            end
        end
    end
end
