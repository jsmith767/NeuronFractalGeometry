% for i=1:length(s)
%     for j = 1:length(s(i).PL)
%         s(i).PL{j}=s(i).PL{j}(1:length(s(i).SLA{j}));
%         s(i).WL{j}=s(i).WL{j}(1:length(s(i).SLA{j}));
%     end
% end
% 
% 
% N = [0;BDataEnd(5).SLA{1}{1}(:,2)];
% V = BDataEnd(5).V{1}{1};
% IL = BDataEnd(5).IL{1}{1};
% IIL = ones(length(IL),1);


for i=5
    for j=1:length(s(i).SLA)
        for k=1:length(s(i).SLA{j})
            N = [0;s(i).SLA{j}{k}(:,2)];
            IIL = ones(length(s(i).IL{j}{k}),1);
            for m=1:max(s(i).IL{j}{k})
            Ind = find(s(i).IL{j}{k}(:,1)==m);
                for n = 1:length(Ind)
                IIL(Ind(n)) = n;
                end
            end
            VIL = ones(length(s(i).V{j}{k}),2);
            for n =1:length(s(i).IL{j}{k})
            VIL(N(n)+1:N(n+1),1)=s(i).IL{j}{k}(n);
            VIL(N(n)+1:N(n+1),2)=IIL(n);
            end
            s(i).TL{j}{k} = [s(i).V{j}{k},VIL];
            s(i).TLA{j}{k} = s(i).TL{j}{k};
            for p = length(s(i).SLA{j}{k}):-1:1
                s(i).TLA{j}{k}(s(i).SLA{j}{k}(p,2)-1:s(i).SLA{j}{k}(p,2),:) = [];
            end        
        end
    end
end


