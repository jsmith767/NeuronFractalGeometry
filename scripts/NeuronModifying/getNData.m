    %Get's useful neuron data you didn't think you needed to save, but you
    %actually did save it...Just look next time...
function mN = getNData(s,method)
    for j = 1:length(s) %Loops through all the neurons
        disp(j);
        GroupLength = length(s(j).SLA);
        V = s(j).data.(genvarname(method))(5).V;
        SLA = s(j).SLA;
        VRM = cell(1,length(GroupLength));
        DM = cell(1,length(GroupLength));
        WL = cell(1,length(GroupLength));
        PL = cell(1,length(GroupLength));
        IL = cell(1,length(GroupLength));

        for i=1:length(GroupLength)%lop through the groups

             VRM{i} = distVertPos(V{i});
             [DM{i},WL{i},PL{i}] = daughterM(SLA{i},VRM{i});
             IL{i} = getItList(PL{i});
        end
        s(j).VRM = VRM;
        s(j).DM = DM;
        s(j).DM = PL;
        s(j).DM = IL;
        s(j).DM = WL;
        mN = s;
    end
end