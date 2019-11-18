%SLA and V are of a specific group already

function segL = calcNeuronSegLengths(V,SLA)
squareDist = squareform(pdist((V(1:end,:)))); %find the distances between all the vertices in V
startNum = 1; %start at the first vertex
segL = cell(size(SLA,1),1);
for i=1:size(SLA,1) %for the branches
%     distance = 0;
    segInd = 1;
    for j=startNum:(SLA(i,2)-3) % for the branch
%         distance = distance + squareDist(i,i-1);
        segL{i,1}(segInd,1) = squareDist(j+1,j);
        segInd = segInd+1;        
    end
    startNum = SLA(i,2)+1;
end

end