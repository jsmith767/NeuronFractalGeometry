%Flattens an obj by just taking the x and y coordinates of the vertices
%with faces "F".  Then expands the resulting flattened polygon by distance
%"d".  Exports the area of the expanded polygon. Also exports the original 
% & expanded polygon


function [A,polyout,polyoutB] = getNProfileArea(x,y,F,d)
    warning('off')
    %% preferred method
    tic
    ply = polyshape.empty(length(F),0);
    for i=1:length(F) %makes a list of all polygon objects
        ply(i,1) = polyshape([x(F(i,1)) x(F(i,2)) x(F(i,3))],[y(F(i,1)) y(F(i,2)) y(F(i,3))]);
    end
%     toc
%     tic
    polyout = union(ply(1:end)); %combines the list into one massive polygon
    toc

%%   *********Alternative method (a little longer time)***********
%     tic
%     polyout = polyshape([x(F(1,1)) x(F(1,2)) x(F(1,3))],[y(F(1,1)) y(F(1,2)) y(F(1,3))]);
%     for i=2:length(F)
%        polyout = union(polyout, polyshape([x(F(i,1)) x(F(i,2)) x(F(i,3))],[y(F(i,1)) y(F(i,2)) y(F(i,3))]));
%     end
%     toc

%   *************************************************************
    
%     toc 

%% finish up
    polyoutB = polybuffer(polyout,d);
    A = area(polyoutB);   
    warning('on')
end