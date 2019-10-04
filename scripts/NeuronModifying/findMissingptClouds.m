for i=1:length(masterN)
    ILs = [];
    for j=1:length(masterN(i).IL)
    ILs(j) = length(masterN(i).IL{j}); 
    end
    if(min(ILs) ==1)
    masterN(i).broken = 1;
    else
    masterN(i).broken = 0;
    end
end