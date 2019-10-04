WL = extractfield(masterN,'WL')';
IL = extractfield(masterN,'IL')';

clear WLn;
clear ILn;
clear ILm;
for i=1:length(WL)
%     disp(i);
    WLn{i,1} = WL{i}';
    WLn{i} = vertcat(WLn{i}{:});
    ILn{i,1} = IL{i}';
    ILm(i,1) = max(vertcat(ILn{i}{:}));
%     WLn{i}={i}{:}';
end
noWL = find(cellfun(@isempty,WLn));
IL6 = find(ILm == 6);
noWonk6it = intersect(noWL,IL6);