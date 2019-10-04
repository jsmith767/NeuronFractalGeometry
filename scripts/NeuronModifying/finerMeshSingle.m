%input all the vertices and one face value
function [v,f] = finerMeshSingle(V,F,Fnumber,Vlength)
    F =  F(Fnumber,:);
    p12 = (V(F(1),:)+V(F(2),:))/2;
    p23 = (V(F(2),:)+V(F(3),:))/2;
    p31 = (V(F(3),:)+V(F(1),:))/2;
    v = [p12;p23;p31];
%     v = [v,Fnumber*ones(size(v,1),1)];
    f = [F(1),Vlength+1,Vlength+3; ...
        F(2),Vlength+1,Vlength+2; ...
        F(3),Vlength+2,Vlength+3; ...
        Vlength+1,Vlength+2,Vlength+3];
    f = [f,F(4)*ones(size(f,1),1)];
end