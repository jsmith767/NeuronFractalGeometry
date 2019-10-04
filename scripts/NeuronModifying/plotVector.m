%plots a 3d vector from some starting position to an ending position as a line
% Example plotVector(V(6:19,:));
function y = plotVector(verts)
    hold
    for i=1:size(verts,1)-1
       v = [verts(i,:) ; verts(i+1,:)];
       plot3(v(:,1),v(:,2),v(:,3),'r')
    end
    hold
    axis equal
end

% function y = plotVector(start,stop)
%     hold
%     for i=1:size(start,1)
%        v = [start(i,:) ; stop(i,:)];
%        plot3(v(:,1),v(:,2),v(:,3),'r')
%     end
%     hold
% end