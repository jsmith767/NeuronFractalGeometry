%gets the vertices and faces of a single branch in a form that they can be
%plotted with patch individually
%e.g. patch('vertices',v,'faces',f,'FaceColor',[0.85,0.85,0.85],'EdgeColor','k','FaceAlpha',1);hold
%SN = segment number
%Bn = branch number
%GN = group number
% V is really VAll

function [v,f]=getVandFsingleSeg(V,F,SLA,GN,BN,SN)
    if BN ==1
        vStart = (SN-1)*16+1;
        vEnd = (SN+1)*16; 
    else
        vStart = (SLA{GN}(BN-1,2)+SN-1)*16+1;
        vEnd = (SLA{GN}(BN-1,2)+SN+1)*16;
    end
%     vEnd = (SLA{GN}(BN,2)+SN-2)*16; 
    masterInd = size(vertcat(V{1:GN-1}),1);
    floc = find(sum(ismember(F{GN},masterInd+vStart:masterInd+vEnd),2)==3);
    v = V{GN}(vStart:vEnd,:);
%     f = [1,2,16;2,3,15;3,4,14;4,5,13;5,6,11;7,8,10;9,10,8;10,11,7;11,12,6;12,13,5;13,14,4;14,15,3;15,16,2];
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
