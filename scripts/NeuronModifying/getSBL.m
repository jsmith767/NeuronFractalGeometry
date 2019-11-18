%[SBL,SBLFull] = getSBL(SL,SLA,CL);
%gets the strahler branch Lengths
function [SBL,SBLFull] = getSBL(SL,SLA,CL)
SBL = cell(size(SL));
I = 1:size(SBL,1);
excluded = [];
for i=I
%     SBL{i,2} = SL(i);
    if ~ismember(i,excluded) 
        SBL{i} = SLA(i,1);
        j = i;
        if ~isempty(CL{j})
            while SL(CL{j}(1)) ~= SL(CL{j}(2)) %check if children are equal
                [~,mI] = max(SL(CL{j})); %finds which of the two children is a continued branch
                SBL{i} = SBL{i} + SLA(CL{j}(mI));%adds the length of the continued  branch to the main
                excluded = [excluded CL{j}(mI)]; %excludes the child that is being added from being considered as it's own branch
                j = CL{j}(mI); %set index to that of the child just added
            end
        end
    end
end
SBLFull = SBL;
SBL = vertcat(SBL{:});
SLcut =SL;
SLcut(excluded)=[];
SBL=[SBL,SLcut];
end

            
            
