%gets the vertices and faces of a single branch in a form that they can be
%plotted with patch individually
%e.g. patch('vertices',v,'faces',f,'FaceColor',[0.85,0.85,0.85],'EdgeColor','k','FaceAlpha',1);hold
%V is really VAll
function [v,f]=getVandFsingle(V,F,SLA,GN,BN)
    if BN == 1
        vStart = 1;
    else
        vStart = SLA{GN}(BN-1,2)*16+1;
    end
    vEnd = (SLA{GN}(BN,2)-2)*16; 
    masterInd = size(vertcat(V{1:GN-1}),1);
    floc = find(sum(ismember(F{GN},masterInd+vStart:masterInd+vEnd),2)==3);
    v = V{GN}(vStart:vEnd,:);
    f = F{GN}(floc,:);
    f = f-min(min(f))+1; 
%     figurep
%     hold
%     scatter3(v(:,1),v(:,2),v(:,3));
%     patch('vertices',v,'faces',f,'FaceColor',[0.85,0.85,0.85],'EdgeColor','k','FaceAlpha',1);
%     set(gcf, 'Color', 'w');
%     axis equal
%     axis off
%     vw = [-5 -2 5];
%     [caz,cel] = view(vw);    


end
