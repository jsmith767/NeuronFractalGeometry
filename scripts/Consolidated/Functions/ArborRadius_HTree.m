function [ArbR] = ArborRadius_HTree(Model)

iterations = max(Model(:,4));
branches = max(Model(:,5));
groups = cell(iterations,branches);
grouplens = cell(iterations,branches);
NMod = zeros(size(Model,1),4);
count = 0;
for i = 1:iterations
    for j = 1:branches
        len = double(0);
        groups{i,j} = intersect(find(Model(:,4)==i), find(Model(:,5)==j));
        for s = 2:size(groups{i,j},1)
            xi = Model(groups{i,j}(s-1,1),1);
            yi = Model(groups{i,j}(s-1,1),2);
            zi = Model(groups{i,j}(s-1,1),3);
            xn = Model(groups{i,j}(s,1),1);
            yn = Model(groups{i,j}(s,1),2);
            zn = Model(groups{i,j}(s,1),3);
            len = len + norm([xn-xi yn-yi zn-zi]);
            
            count = count + 1;
            NMod(count,:) = [mean([[xn yn zn];[xi yi zi]]) norm([xn-xi yn-yi zn-zi])];
        end
        grouplens{i,j} = len;
    end
end
NMod = NMod(any(NMod,2),:);

ArbR = 0;
for i = 1:size(NMod,1)
    for j = 1:size(NMod,1)
        ArbR = ArbR + NMod(i,4)*NMod(j,4)*((NMod(i,1)-NMod(j,1))^2 + (NMod(i,2)-NMod(j,2))^2 + (NMod(i,3)-NMod(j,3))^2);
    end
end
ArbR = sqrt(ArbR/(2*sum(NMod(:,4))^2));

end