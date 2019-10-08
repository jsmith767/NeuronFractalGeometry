function [ArbR] = ArborRadius_Neuron(Model,SLA)

NumPoints = 0;
NumBranches = 0;
for gn = 1:size(SLA,2)
    NumPoints = NumPoints + SLA{1,gn}(end,2);
    NumBranches = NumBranches + size(SLA{1,gn},1);
end
NumPoints = NumPoints - NumBranches*3;

groups = size(Model,2);
NMod = zeros(NumPoints,4);

count = 0;
for g = 1:groups
    for p = 1:SLA{1,g}(1,2)-3
        count = count + 1;
        xi = Model{1,g}(p,1);
        yi = Model{1,g}(p,2);
        zi = Model{1,g}(p,3);
        xn = Model{1,g}(p+1,1);
        yn = Model{1,g}(p+1,2);
        zn = Model{1,g}(p+1,3);
        NMod(count,:) = [mean([[xn yn zn];[xi yi zi]]) norm([xn-xi yn-yi zn-zi])];
    end
    for s = 2:size(SLA{1,g},1)
        for p = SLA{1,g}(s-1,2)+1:SLA{1,g}(s,2)-3
            count = count + 1;
            xi = Model{1,g}(p,1);
            yi = Model{1,g}(p,2);
            zi = Model{1,g}(p,3);
            xn = Model{1,g}(p+1,1);
            yn = Model{1,g}(p+1,2);
            zn = Model{1,g}(p+1,3);
            NMod(count,:) = [mean([[xn yn zn];[xi yi zi]]) norm([xn-xi yn-yi zn-zi])];
        end
    end
end

ArbR = 0;
for i = 1:size(NMod,1)
    for j = 1:size(NMod,1)
        ArbR = ArbR + NMod(i,4)*NMod(j,4)*((NMod(i,1)-NMod(j,1))^2 + (NMod(i,2)-NMod(j,2))^2 + (NMod(i,3)-NMod(j,3))^2);
    end
end
ArbR = sqrt(ArbR/(2*sum(NMod(:,4))^2));

end