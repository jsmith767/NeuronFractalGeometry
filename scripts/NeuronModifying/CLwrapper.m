%masterN = CLwrapper(masterN);
%This function creates a Child list (CL) with same dimensions as SLA and
%puts it into the masterN struct
function masterN = CLwrapper(masterN)
    for i=1:length(masterN) %for the length of masterN
        for j=1:length(masterN(i).SLA) % for the number of groups of branches
            masterN(i).CL{j} = calcCL(masterN(i).DM{j});
        end     
    end
end