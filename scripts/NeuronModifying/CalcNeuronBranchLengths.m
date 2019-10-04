function branch = CalcNeuronBranchLengths(V)
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
end