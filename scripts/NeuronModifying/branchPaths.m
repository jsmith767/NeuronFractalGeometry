%gets all the paths from the start of a group to a terminal branch.
function P = branchPaths(PL,DM)
for i=length(PL):-1:1
    j = i;
    k = 1;
    while j > 0
        P{i}(k) = j;
        j = PL(j,1);
        k = k+1;
    end
    P{i}(k) = j;
end
E = (DM(:,1)==0); %Selects only the paths that have ending branches
P = P(E);
end
    