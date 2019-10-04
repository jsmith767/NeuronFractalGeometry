%rotateNueronSeg.m
%Rotates an entire neuron segment starting from the end and working backwards
% segV should be inputed as a column vector.  where column 1:3 are x,y,z.

%it is a percent of the original angle.  0 % means that B lies along
%vector A.
% previously [newSeg, Vnew] = rotateNeuronSeg(Vnew,DM,SLA,segV,segN, percent)
function [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegChooseInitAng(Vnew,VAllnew,DM,SLA,segV,segVAll,segN,percent)
    segV = [segV ones(size(segV,1),1)];  %Transforms vector into a 4-vector for translations  
    segV = segV(1:end-2,:); % cuts off the last two values which are start and end duplicates
    segVAll = [segVAll ones(size(segVAll,1),1)];%--
    segVAll = segVAll(1:end-2*16,:); %shouldn't be needed but helps to think about parralelization%--
    for i=1:1:(size(segV,1)-1) % if you end at 1 then it reorients the branch towards the end.
        %otherwise it just straightens based off of a percent of
        %consecutive branch angles from the segment number chosen.
        [segV,segVAll,eVector, theta, translationPT] = rotateNeuronVectorsChooseInitAng(segV,segVAll,percent,i);
%         segRingsToRot = segVAll(i*16+1:end,:);%--
%         segVAll = rotateSegByAngle(segRingsToRot,eVector,theta,translationPT);%--
        for j=2:(1+DM(segN,1)) %runs through daughter segments of the current segment that this pt is in
            segToRot = getSegV(Vnew,SLA,DM(segN,j));
            segToRot = [segToRot ones(size(segToRot,1),1)];  %Transforms vector into a 4-vector for translations  
            segRingsToRot = getRingSegV(VAllnew,SLA,DM(segN,j));%--
            segRingsToRot = [segRingsToRot ones(size(segRingsToRot,1),1)];%--
            rotatedSeg = rotateSegByAngle(segToRot,eVector,theta,translationPT);
            rotatedSeg = rotatedSeg(:,1:3);
            rotatedSegAll = rotateSegByAngle(segRingsToRot,eVector,theta,translationPT);%--
            rotatedSegAll = rotatedSegAll(:,1:3);%--
            Vnew = setNewV(Vnew,rotatedSeg,SLA,DM(segN,j));
            VAllnew = setNewVAll(VAllnew,rotatedSegAll,SLA,DM(segN,j));%--
        end
    end
        segV(end+1,:) = segV(1,:); %adds the new start
        segV(end+1,:) = segV(end-1,:); %adds the new end
        segVAll = [segVAll ;segVAll(1:16,:)]; %--adds the new start ring
        segVAll = [segVAll ;segVAll(end-31:end-16,:)]; %--adds the new end 
        
        newSeg = segV(:,1:3);
        newSegAll = segVAll(:,1:3);%--
end