%Use this function to rotate a vector B towards another vector A such that
%it is a percent of the original angle.  0 % means that B lies along
%vector A.

%verts should be inputed as a column vector.  where column 1:3 are x,y,z.

function newVector = rotateVectors(verts,percent,junctionNum) 
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
            newVector = [verts(1:junctionNum-1,:); newVector];
            else 
                newVector = verts;
            end
        else
            newVector = verts;
        end
end


% function newVector = rotateVectors(verts,percent)
%     verts = [verts ones(size(verts,1),1)];
%     for i=1:size(verts,1)-2
%         theta = acos(dot(verts(i+1,:)-verts(i,:),verts(i+2,:)-verts(i+1,:))/(norm(verts(i+1,:)-verts(i,:))*norm(verts(i+2,:)-verts(i+1,:))));
%         theta = -(1-percent)*theta;
%         eVector = cross(verts(i+1,1:3)-verts(i,1:3),verts(i+2,1:3)-verts(i+1,1:3)); 
%         eVector = eVector/norm(eVector); %defines the vector to rotate about
%         Mrot = makehgtform('axisrotate',eVector,theta);
%         Mtran = makehgtform('translate',-verts(i+1,1:3));
%         Mtran2 = makehgtform('translate',verts(i+1,1:3));
%         newVector = (Mtran2*Mrot*Mtran*verts((i+1):end,:)')';
%         newVector = [verts(1:i,:); newVector];
%     end
% end