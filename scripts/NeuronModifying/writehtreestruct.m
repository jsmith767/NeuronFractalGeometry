%write H-tree struct file.
%loads in vertex files of formaty {x,y,z} and converts them to a structure
%with fields name, D, x,y,z and volume
function s = writehtreestruct(F)
    for i=1:length(F)
    s(i).name = F(i).name(end-19:end-16); % needs to be re-written with regexp
    s(i).D = num2str(s(i).name(2:end));
    V = importHTreefile(F(i).name);
    s(i).x = V(:,1);
    s(i).y = V(:,2);
    s(i).z = V(:,3);
    [~,s(i).Vol] = convhull(s(i).x,s(i).y,s(i).z);
%     s(i).Mass = length(s(i).x);
    end
end


R = nthroot(VolsExact{2}/VolsExact{m},3);