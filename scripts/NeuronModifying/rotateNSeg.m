%rotateNSeg.m

%Rotates an entire neuron segment starting from the end and working backwards
% segV should be inputed as a column vector.  where column 1:3 are x,y,z.

%it is a percent of the original angle.  0 % means that B lies along
%vector A.
function newSeg = rotateNSeg(segV,percent)
    segV = [segV ones(size(segV,1),1)];  %Transforms vector into a 4-vector for translations  
    segV = segV(1:end-2,:); % cuts off the last two values which are start and end duplicates
    for i=(size(segV,1)-1):-1:2
        segV = rotateVectors(segV,percent,i);
    end
        segV(end+1,:) = segV(1,:); %adds the new start
        segV(end+1,:) = segV(end-1,:); %adds the new end
        newSeg = segV(:,1:3);
end