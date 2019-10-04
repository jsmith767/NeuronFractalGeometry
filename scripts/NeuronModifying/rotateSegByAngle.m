%Use this function to rotate a vector B towards another vector A such that
%it is a percent of the original angle.  0 % means that B lies along
%vector A.

%verts should be inputed as a column vector.  where column 1:3 are x,y,z.

function newVector = rotateSegByAngle(verts,eVector, theta, translationPT) 
        if (eVector(1) ~= 0 || eVector(2) ~= 0 || eVector(3) ~= 0) %determine if rotation is needed
            if (1 ~= isnan(eVector(1)) || 1 ~= isnan(eVector(2)) || 1 ~= isnan(eVector(3)))
            Mrot = makehgtform('axisrotate',eVector,theta);
            Mtran = makehgtform('translate',-translationPT);
            Mtran2 = makehgtform('translate',translationPT);
            newVector = (Mtran2*Mrot*Mtran*verts')';
%             newVector = [verts(1:junctionNum-1,:); newVector];
            else 
                newVector = verts;
            end
        else
            newVector = verts;
        end
end