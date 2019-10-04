function [A,polyout,polyoutB] = getNProfileAreaPClip(x,y,F,d)
    warning('off')
%     tic
%     xC = cell(1,length(F));
%     yC = cell(1,length(F));
%     for i=1:length(F)
%         xC{i} = [x(F(i,1)) x(F(i,2)) x(F(i,3))];
%         yC{i} = [y(F(i,1)) y(F(i,2)) y(F(i,3))];
%     end
%     ply= polyshape(xC(1:1000),yC(1:1000));
%     ply = polyshape.empty(length(F),0);
%     tic
%     for i=1:length(F)
%         ply(i,1) = polyshape([x(F(i,1)) x(F(i,2)) x(F(i,3))],[y(F(i,1)) y(F(i,2)) y(F(i,3))]);
%     end
%     toc
%     tic
%     polyout = union(ply(1:end));
%     toc
    tic
    ply.x = [x(F(1,1)) x(F(1,2)) x(F(1,3))];
    ply.y = [y(F(1,1)) y(F(1,2)) y(F(1,3))];
    ply.hole=0;
    for i=2:length(F)
    plyt.x = [x(F(i,1)) x(F(i,2)) x(F(i,3))];
    plyt.y = [y(F(i,1)) y(F(i,2)) y(F(i,3))];
    plyt.hole=0;
    ply = PolygonClip(ply,plyt,3); 
    end
    toc
    polyout = ply;
    A = 1;
%     polyoutB = polybuffer(polyout,d);
%     A = area(polyoutB);
%     warning('on')
%     toc 
end