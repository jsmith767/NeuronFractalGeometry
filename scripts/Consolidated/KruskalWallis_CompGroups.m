% Run GetGroupData before this script

% pltgrp1 = {GInfo{1,1} GInfo{1,2} GInfo{1,3} GInfo{1,4} GInfo{1,5} GInfo{1,6}}; % All groups
% pltgrp2 = {GInfo{1,4} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,2} | GInfo{1,3}}; % {'Healthy' 'Unhealthy'}
% pltgrp3 = {GInfo{1,2} | GInfo{1,3} | GInfo{1,5} | GInfo{1,6} GInfo{1,1} | GInfo{1,4}}; % {'Trained' 'Pseudotrained'}
% pltgrp4 = {GInfo{1,1} | GInfo{1,2} | GInfo{1,4} | GInfo{1,5} GInfo{1,3} | GInfo{1,6}}; % {'Enriched' 'Standard'}
% pltgrp5 = {GInfo{1,5} | GInfo{1,6} GInfo{1,4}}; % {'Trained' 'Pseudotrained'} Healthy Only
% pltgrp6 = {GInfo{1,4} | GInfo{1,5} GInfo{1,6}}; % {'Enriched' 'Standard'} Healthy Only
plthem = {HInfo{1,1} HInfo{1,2}}; % {'Left' 'Right'}

% CompGroups = {pltgrp1 pltgrp2 pltgrp3 pltgrp4 pltgrp5 pltgrp6; Groups {'Healthy' 'Unhealthy'} {'Trained' 'Pseudotrained'} {'Enriched' 'Standard'} {'Trained' 'Pseudotrained'} {'Enriched' 'Standard'}};
CompHems = {plthem; {'Left' 'Right'}};
% GroupP = cell(1,size(CompGroups,2));
% GroupT = cell(1,size(CompGroups,2));
% GroupS = cell(1,size(CompGroups,2));
HemsP = cell(1,size(CompHems,2));
HemsT = cell(1,size(CompHems,2));
HemsS = cell(1,size(CompHems,2));

% for c = 1:size(CompGroups,2)
%     NumPerGroup = cellfun(@sum,CompGroups{1,c});
%     MaxNum = max(NumPerGroup);
%     
%     KWM = NaN(MaxNum,size(CompGroups{1,c},2));
%     
%     for g = 1:size(CompGroups{1,c},2)
%         KWM(1:NumPerGroup(1,g),g) = BDbyM(5,CompGroups{1,c}{1,g});
%     end
%     
%     [GroupP{1,c},GroupT{1,c},GroupS{1,c}] = kruskalwallis(KWM,CompGroups{2,c},'on');
%     set(gca,'LineWidth',2,'FontSize',20);
%     set(findobj(gca,'type','line'),'LineWidth',2);
% end

for c = 1:size(CompHems,2)
    NumPerHem = cellfun(@sum,CompHems{1,c});
    MaxNum = max(NumPerHem);
    
    KWM = NaN(MaxNum,size(CompHems{1,c},2));
    
    for h = 1:size(CompHems{1,c},2)
        KWM(1:NumPerHem(1,h),h) = BDbyM(5,CompHems{1,c}{1,h});
    end
    
    [HemsP{1,c},HemsT{1,c},HemsS{1,c}] = kruskalwallis(KWM,CompHems{2,c},'on');
    set(gca,'LineWidth',2,'FontSize',20);
    set(findobj(gca,'type','line'),'LineWidth',2);
end