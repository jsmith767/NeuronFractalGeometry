function [F,D,P,M,V]=neurondataplot(s)

F = extractfield(s,'name');
D = extractfield(s,'D');
M = extractfield(s,'nMass');
V = extractfield(s,'Vol');
P = extractfield(s,'nP');%scaled plots
% L = extractfield(s,'Length');
F = vertcat(F{:});
D = vertcat(D{:});
M = vertcat(M{:});
V = vertcat(V{:});
P = vertcat(P{:});
% L = vertcat(L{:});
IF = ~cellfun(@isempty,F);
ID = ~cellfun(@isempty,D);
IM = ~cellfun(@isempty,M);
IV = ~cellfun(@isempty,V);
IP = ~cellfun(@isempty,P);
% IL = ~cellfun(@ismissing,L);
Index = and(IF,ID);
Index = and(Index,IM);
Index = and(Index,IV);
Index = and(Index,IP);
% Index = and(Index,IL);
F = vertcat(F(Index));
D = vertcat(D{Index});
V = vertcat(V{Index});
M = vertcat(M{Index});
P = vertcat(P{Index});
% L = vertcat(L{Index});
if length(s) ==1
    F = F';
end
end