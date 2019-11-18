function masterN = findMaxPathWrapper(mN)
for i=1:length(mN)
    mN(i).Ldata.mCP(1) = 0;
    mN(i).Ldata.sCP(1) = 0;
    for j=1:length(mN(i).SLA) %loop through all groups
        P = branchPaths(mN(i).PL{j},mN(i).DM{j}); %get all paths
        [mP,pID,sP,sID] = findMaxPath(P,mN(i).SLA{j},mN(i).DM{j});
        mN(i).Ldata.mP{j,1} = mP';
        mN(i).Ldata.pID{j,1} = pID;
        mN(i).Ldata.sP{j,1} = sP';
        mN(i).Ldata.sID{j,1} = sID;
        mN(i).Ldata.hacks{j,1} = mP'./sP';
        %calculate all groups as if they come to the same point
        if mP(1) > mN(i).Ldata.mCP(1)
            mN(i).Ldata.mCP(1) = mP(1);
        end
        mN(i).Ldata.mCP = [mN(i).Ldata.mCP;mP(2:end)'];
        mN(i).Ldata.sCP(1) = mN(i).Ldata.sCP(1)+sP(1);
        mN(i).Ldata.sCP = [mN(i).Ldata.sCP;sP(2:end)'];
    end
    
end
masterN = mN;
end