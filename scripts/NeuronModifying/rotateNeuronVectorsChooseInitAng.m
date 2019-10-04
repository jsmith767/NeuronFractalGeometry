%Use this function to rotate a vector B towards another vector A such that
%it is a percent of the original angle.  0 % means that B lies along
%vector A.

%verts should be inputed as a column vector.  where column 1:3 are x,y,z.

function [newVector,newVectorAll,eVector,theta, translationPT] = rotateNeuronVectorsChooseInitAng(verts,vertsAll,percent,junctionNum) 
        %determine the angle between the first segment and the line from
        %the first point to the last.  
        if (junctionNum == 1)
            theta = acos(dot(verts(2,1:3)-verts(1,1:3),verts(end,1:3)-verts(1,1:3))...
            /(norm(verts(2,1:3)-verts(1,1:3))*norm(verts(end,1:3)-verts(1,1:3))));
        else %determine the angle between the segments
            theta = acos(dot(verts(junctionNum,1:3)-verts(junctionNum-1,1:3),verts(junctionNum+1,1:3)-verts(junctionNum,1:3))...
            /(norm(verts(junctionNum,1:3)-verts(junctionNum-1,1:3))*norm(verts(junctionNum+1,1:3)-verts(junctionNum,1:3))));
        end
        theta = -(1-percent)*theta;
        %determine the normal vector
        if (junctionNum == 1)
            eVector = cross(verts(end,1:3)-verts(1,1:3),verts(2,1:3)-verts(1,1:3));
        else
            eVector = cross(verts(junctionNum,1:3)-verts(junctionNum-1,1:3),verts(junctionNum+1,1:3)-verts(junctionNum,1:3));
        end
        eVector = eVector/norm(eVector); %defines the vector to rotate about
        if (eVector(1) ~= 0 || eVector(2) ~= 0 || eVector(3) ~= 0) %determine if rotation is needed
            if (1 ~= isnan(eVector(1)) || 1 ~= isnan(eVector(2)) || 1 ~= isnan(eVector(3)))
            Mrot = makehgtform('axisrotate',eVector,theta);
            Mtran = makehgtform('translate',-verts(junctionNum,1:3));
            Mtran2 = makehgtform('translate',verts(junctionNum,1:3));
            newVector = (Mtran2*Mrot*Mtran*verts(junctionNum:end,:)')';
            newVectorAll = (Mtran2*Mrot*Mtran*vertsAll(junctionNum*16+1:end,:)')';%--
            if (junctionNum ~= 1)
                newVector = [verts(1:junctionNum-1,:); newVector];
                newVectorAll = [vertsAll(1:junctionNum*16,:); newVectorAll];%--
            else
                newVectorAll = [vertsAll(1:junctionNum*16,:); newVectorAll];
            end
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