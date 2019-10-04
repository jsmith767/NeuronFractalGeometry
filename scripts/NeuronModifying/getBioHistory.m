%S= imported csv
 S = table2struct(BasalArborStats17Feb2014);
%%
for i=1:length(S)
S(i).ID = char(S(i).ID);
end
for i=1:length(S)
S(i).Surgery = char(S(i).Surgery);
S(i).Housing = char(S(i).Housing);
S(i).Training = char(S(i).Training);
S(i).Group = char(S(i).Group);
end
%%
for i=1:length(masterN)
    name = masterN(i).name;
    if name(1) == 'a'
        name = name(2:end);
    end
    if endsWith(string(name),'_B') || endsWith(string(name),'_M')
        name = name(1:end-2);
    end  
    ID = structfind(S,'ID',name);
    try
    masterN(i).Group = S(ID).Group;
    masterN(i).Surgery = S(ID).Surgery;
    masterN(i).Housing = S(ID).Housing;
    masterN(i).Training = S(ID).Training;
    catch
        
    end
end