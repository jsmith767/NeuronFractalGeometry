%Use this function to rotate a vector B towards another vector A such that
%it is a percent of the original angle.  0 % means that B lies along
%vector A.

%verts should be inputed as a column vector.  where column 1:3 are x,y,z.

function [newVector,newVectorAll,eVector,theta, translationPT] = rotateNeuronVectors(verts,vertsAll,percent,junctionNum) 
        %determine the angle between the segments
        theta = acos(dot(verts(junctionNum,1:3)-verts(junctionNum-1,1:3),verts(junctionNum+1,1:3)-verts(junctionNum,1:3))...
            /(norm(verts(junctionNum,1:3)-verts(junctionNum-1,1:3))*norm(verts(junctionNum+1,1:3)-verts(junctionNum,1:3))));
        theta = -(1-percent)*theta;
        %determine the normal vector
        eVector = cross(verts(junctionNum,1:3)-verts(junctionNum-1,1:3),verts(junctionNum+1,1:3)-verts(junctionNum,1:3)); 
        eVector = eVector/norm(eVector); %defines the vector to rotate about
        if (eVector(1) ~= 0 || eVector(2) ~= 0 || eVector(3) ~= 0) %determine if rotation is needed
            if (1 ~= isnan(eVector(1)) || 1 ~= isnan(eVector(2)) || 1 ~= isnan(eVector(3)))
            Mrot = makehgtform('axisrotate',eVector,theta);
            Mtran = makehgtform('translate',-verts(junctionNum,1:3));
            Mtran2 = makehgtform('translate',verts(junctionNum,1:3));
            newVector = (Mtran2*Mrot*Mtran*verts(junctionNum:end,:)')';
            newVectorAll = (Mtran2*Mrot*Mtran*vertsAll(junctionNum*16:end,:)')';%--
            newVector = [verts(1:junctionNum-1,:); newVector];
            newVectorAll = [vertsAll(1:junctionNum*16-1,:); newVectorAll];%--
            else 
                newVector = verts;
                newVectorAll =vertsAll;%--
            end
        else
            newVector = verts;
            newVectorAll = vertsAll;%--
        end
        translationPT = verts(junctionNum,1:3);
end