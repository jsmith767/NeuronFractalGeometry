function [Lave,Rave,D,L,R] = TortuosityAverage(masterN,method,curve)
    Lave = zeros(length(masterN),1);
    Rave = zeros(length(masterN),1);
    for i=1:length(masterN)
        temp = vertcat(masterN(i).SLA{:});
        L{i} = temp(:,1);
        Lave(i) = mean(L{i});
        m = 1;
        Rbranch = zeros(size(vertcat(masterN(i).SLA{:}),1),1);
        for j = 1:size(masterN(i).SLA,2)   
            for k=1:size(masterN(i).SLA{j},1)
                if k==1
                    v1 = masterN(i).data.(genvarname(method))(curve).V{j}(1,:);
                    v2 = masterN(i).data.(genvarname(method))(curve).V{j}(masterN(i).SLA{j}(k,2),:);
                else
                    v1 = masterN(i).data.(genvarname(method))(curve).V{j}(masterN(i).SLA{j}(k-1,2)+1,:);
                    v2 = masterN(i).data.(genvarname(method))(curve).V{j}(masterN(i).SLA{j}(k,2),:);
                end
                Rbranch(m) = pdist([v1;v2]);
                m=m+1;
            end
        end
        R{i} = Rbranch;
        Rave(i) = mean(R{i});
        D(i) = masterN(i).data.(genvarname(method))(curve).Ddata.reg.D;
    end
end
    
