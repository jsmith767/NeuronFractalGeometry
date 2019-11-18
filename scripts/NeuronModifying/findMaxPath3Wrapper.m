function masterN = findMaxPath3Wrapper(mN,varargin)
%gets the segment lengths if it doesn't already exist in a struct

p = inputParser;
addParameter(p,'curvature',1,@isnumeric);
parse(p,varargin{:});

fn = fieldnames(mN(1).data);
method = fn{1};
if ~isfield(mN, 'segL')
    mN = segLWrapper(mN,'method',method,'curvature',p.Results.curvature);
end
if ~isfield(mN, 'CL')
    mN = CLwrapper(mN);
end

for i=1:length(mN)
    mN(i).Ldata.mCP(1) = 0;
    mN(i).Ldata.sCP(1) = 0;
    mN(i).Ldata.mSP = [];
    for j=1:length(mN(i).SLA) %loop through all groups
        P = branchPaths(mN(i).PL{j},mN(i).DM{j}); %get all paths
        [mSP,mSPF,mP,pID,sP,sID] = findMaxPath3(P,mN(i).SLA{j},mN(i).DM{j},mN(i).segL{j},mN(i).CL{j});
%         mN(i).Ldata.mP{j,1} = mP';
        mN(i).Ldata.pID{j,1} = pID;
%         mN(i).Ldata.sP{j,1} = sP';
        mN(i).Ldata.sID{j,1} = sID;
        mN(i).Ldata.mSP{j,1} = mSP;
        mN(i).Ldata.mSPF{j,1} = mSPF;
        mN(i).Ldata.hacks{j,1} = mP./sP;
        %calculate all groups as if they come to the same point
        if mP(1) > mN(i).Ldata.mCP(1)
            mN(i).Ldata.mCP(1) = mP(1);
%             mN(i).Ldata.mSP{1} = mSP{1};
        end
        mN(i).Ldata.mCP = [mN(i).Ldata.mCP;mP(2:end)];
        mN(i).Ldata.sCP(1) = mN(i).Ldata.sCP(1)+sP(1);
        mN(i).Ldata.sCP = [mN(i).Ldata.sCP;sP(2:end)];
%         mN(i).Ldata.mSP = [mN(i).Ldata.mSP;mSP];
    end
    
end
masterN = mN;
end