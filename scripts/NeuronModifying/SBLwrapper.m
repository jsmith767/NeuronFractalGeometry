function masterN = SBLwrapper(masterN)
    for i=1:length(masterN)
        for j=1:length(masterN(i).CL)
%             disp(j);
            [masterN(i).SBL{j},masterN(i).SBLFull{j}] = getSBL(masterN(i).SL{j},masterN(i).SLA{j},masterN(i).CL{j});
        end
    end
end