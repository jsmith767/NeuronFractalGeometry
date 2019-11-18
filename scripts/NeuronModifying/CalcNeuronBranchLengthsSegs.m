% e.g. [branch,segs] = CalcNeuronBranchLengthsSegs(masterN.data.S.V{1});
%Calculates the segment lengths of all the vertices of the branch
%Not sure but I think it doesn't add extra long lengths between
%segments. So it should be fine... but not positive.
%looks like branch reproduces SLA
%asks for midpoint vertices (V)
function [branch,segs] = CalcNeuronBranchLengthsSegs(V)
squareDist = squareform(pdist((V(1:end,:))));
startNum = 1;
start = V(startNum,:);
branch = [];
i=startNum+1;
k = 0;
% mkdir('images280001');
    while(i < length(V))
    distance = 0;
    %length(branch)
        while(V(i,1)~= start(1) || V(i,2)~= start(2) || V(i,3)~= start(3)) 
%             i
%             figure = scatter3(V(1:i,1),V(1:i,2),V(1:i,3));
%             saveas(figure, ['images280001/figure'  num2str(i) '.tif']);
            distance = distance + squareDist(i,i-1);
            d(i-1) = squareDist(i,i-1);
            if d(i-1)>18
                d(i-1) = squareDist(i,i-1);
            end
            i = i+1;
            if(i == length(V))
                branch = [branch ; [distance i+1]];
                return
            end
        end 
    branch = [branch ; [distance i+1]];
    i=i+2;
    k=k+1;
    if (i <= length(V))
%         writeOBJ(V(1:i-1,:),k);  %Important line that will write
%         % iterative obj's for viewing
        start = V(i,:);
%         k
%         i
%         V(i-4:i,:)
%         branch(k)
    end
    i = i+1;
    end
    d( :, ~any(d,1) ) = [];  %columns
    segs = d';
end