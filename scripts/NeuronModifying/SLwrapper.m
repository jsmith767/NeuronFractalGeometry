function masterN=SLwrapper(masterN)
    if ~isfield(masterN,'CL')
        masterN=CLwrapper(masterN);
    end
    for i=1:length(masterN)
        disp(i);
        for j=1:length(masterN(i).CL)
%             if i==21 && j ==2
%             disp(j);
%             end
            masterN(i).SL{j} = getSL(masterN(i).CL{j},masterN(i).PL{j});
        end
    end
end
        