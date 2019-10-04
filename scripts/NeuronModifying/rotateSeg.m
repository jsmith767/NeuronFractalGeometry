 %Rotates an entire segment starting from the end and working backwards
% segV should be inputed as a column vector.  where column 1:3 are x,y,z.

function newSeg = rotateSeg(segV,percent)
    segV = [segV ones(size(segV,1),1)];    %Transforms vector into a 4-vector for translations  
    for i=(size(segV,1)-1):-1:2
        segV = rotateVectors(segV,percent,i);
    end
        newSeg = segV(:,1:3); 
end