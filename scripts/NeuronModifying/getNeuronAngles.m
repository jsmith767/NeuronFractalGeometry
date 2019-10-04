function Angles = getNeuronAngles(V, VAll, SLA, PL)
Angles = cell(size(SLA,1),2);
for i=1:size(SLA,2)
    Angles{i} = getNeuronGroupAngles(V{i},VAll{i},SLA{i},PL{i});
end   
end