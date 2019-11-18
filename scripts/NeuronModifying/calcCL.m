%CL = calcCL(DM)
%inputs a single groups DM and outputs the child list for that group of
%branches
function CL = calcCL(DM)
CL = cell(size(DM,1),1);
for i =1:size(DM,1)
    if DM(i,1)~= 0
%         CL{i,1} = 0;
%     else
%         CL{i,1} = 2;
        DMtemp = DM(i,2:end);%gets the daughters of the ith 
%         DMtemp = DMtemp(DMtemp >0);
        DMdaughters = DM((i+1):end,2:end); %gets the daughters of all daughters
        Lia = ~ismember(DMtemp,DMdaughters);
        CL{i,1} = DMtemp(Lia);
    end
end


end
    
    
    
    
    
