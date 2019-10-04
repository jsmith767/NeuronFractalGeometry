function L = getNeuronTotLength(SLA)
L = zeros(1,length(SLA));
    for i=1:length(SLA)
        L(i)=sum(SLA{i}(:,1));
    end
    L = sum(L);
end