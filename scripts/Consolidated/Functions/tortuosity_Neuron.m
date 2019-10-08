function [Ls,Rs] = tortuosity_Neuron(Model,SLA)

%         MaxLen = 0;
%         for g = 1:groups
%             if MaxLen < max(SLA{1,g}(:,1),1)
%                 MaxLen = max(SLA{1,g}(:,1),1);
%             end
%         end
%         MinLen = 1;
%         TortLens = MinLen:(MaxLen-MinLen)/(numLs-1):MaxLen;
%         LenRange = [(MinLen-(MaxLen-MinLen)/(2*(numLs-1))) (MaxLen+(MaxLen-MinLen)/(2*(numLs-1)))];
%         LRanges{i,1} = lrange;

groups = size(Model,2);

NumSegs = 0;
for g = 1:groups
    NumSegs = NumSegs + nchoosek(SLA{1,g}(1,2)-2,2);
    for s = 2:size(SLA{1,g},1)
        NumSegs = NumSegs + nchoosek(SLA{1,g}(s,2)-SLA{1,g}(s-1,2)-2,2);
    end
end

Ls = zeros(NumSegs,1);
Rs = zeros(NumSegs,1);
count = 0;
for g = 1:groups
    for p = 1:SLA{1,g}(1,2)-3
        alen = 0;
        xp = Model{1,g}(p,1);
        yp = Model{1,g}(p,2);
        zp = Model{1,g}(p,3);
        for q = p+1:SLA{1,g}(1,2)-2
            xq1 = Model{1,g}(q-1,1);
            yq1 = Model{1,g}(q-1,2);
            zq1 = Model{1,g}(q-1,3);
            xq2 = Model{1,g}(q,1);
            yq2 = Model{1,g}(q,2);
            zq2 = Model{1,g}(q,3);
            
            alen = alen + norm([xq1-xq2 yq1-yq2 zq1-zq2]);
            elen = norm([xq2-xp yq2-yp zq2-zp]);
            
            count = count + 1;
            Ls(count,1) = alen;
            Rs(count,1) = elen;
        end
    end
    for s = 2:size(SLA{1,g},1)
        for p = SLA{1,g}(s-1,2)+1:SLA{1,g}(s,2)-3
            alen = 0;
            xp = Model{1,g}(p,1);
            yp = Model{1,g}(p,2);
            zp = Model{1,g}(p,3);
            for q = p+1:SLA{1,g}(s,2)-2
                xq1 = Model{1,g}(q-1,1);
                yq1 = Model{1,g}(q-1,2);
                zq1 = Model{1,g}(q-1,3);
                xq2 = Model{1,g}(q,1);
                yq2 = Model{1,g}(q,2);
                zq2 = Model{1,g}(q,3);
                
                alen = alen + norm([xq1-xq2 yq1-yq2 zq1-zq2]);
                elen = norm([xq2-xp yq2-yp zq2-zp]);
                
                count = count + 1;
                Ls(count,1) = alen;
                Rs(count,1) = elen;
            end
        end
    end
end

end