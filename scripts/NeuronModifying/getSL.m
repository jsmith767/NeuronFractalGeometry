%SL = getSL(CL,PL);
%gets the horton-strahler iteration scheme list. Does so goup by group
function SL = getSL(CL,PL)
SL = zeros(size(CL));
ind= cellfun('isempty',CL);
SL(ind) = 1;
while ~all(SL) %runs untill the strahler list is complete
    I = PL(ind)';%finds the indices of the parents 
%     I = unique(I);%removes redundant parents
    I = unique(I(I >0));
    for i=I %Loop over those parents
        children = CL{i}; %find the children of the current parent
    %     child2 = CL{i}(2);
    if i==3
%     disp(i)
    end
        if SL(children(1))*SL(children(2))==0 %skip over parents where both children haven't been decided yet
%             disp(i);    
        elseif SL(children(1)) == SL(children(2)) %check if those hildren have the same S#
            SL(i) =SL(children(1))+1;

        else
            SL(i) = max(SL(children)); 
        end
    end
    ind = I;
%     Sind = Sind+1;
%     ind = SL==Sind;
end
end