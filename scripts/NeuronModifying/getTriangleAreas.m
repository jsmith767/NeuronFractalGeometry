function A = getTriangleAreas(V,F)
    area = zeros(size(F,1),1);
    for i=1:size(F,1)
        p31 = (V(F(i,3),:)-V(F(i,1),:));
        p21 = (V(F(i,2),:)-V(F(i,1),:));
        area(i) = norm(cross(p31,p21))/2;
    end
    A = sum(area);
end
    