%Use rotateVectors.m instead of this one

%Use this function to rotate a vector B towards another vector A such that
%it is a percent of the original angle.  0 % means that B lies along
%vector A.

function newVector = rotateVector(A,B,percent)
    theta = acos(dot(A,B)/(norm(A)*norm(B)));
    theta = -(1-percent)*theta;
    eVector = cross(A,B); 
    eVector = eVector/norm(eVector); %defines the vector to rotate about
    newVector = cos(theta)*B + sin(theta)*cross(eVector,B)+(1-cos(theta))*dot(eVector,B)*eVector;
end