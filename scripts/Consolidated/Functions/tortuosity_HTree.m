% Model = ImportTxt4('D:\Conor\Research\Mathematica\CurvyHTrees\WithBranchNum\90\It1Branch2D2.00Length100000Theta0.0981748Phi3.1BranchAngle90.001.txt');
% iterations = 1:6;
% Df = 2.0;
% Nb = 2;
% Lt = 10000;
% ItLen = Lt/sum((Nb).^((iterations-1)*(Df-1)/Df))./Nb.^((iterations-1)/Df);
% segments = round(ItLen(1)./(Nb).^((iterations-1)/Df))+1;
% stepsize = ItLen./(segments-1);
% branches = Nb.^(iterations-1);
function [L,R,tortlens,lenrange] = tortuosity_HTree(Model,numlens)

iterations = max(Model(:,4));
branches = max(Model(:,5));
groups = cell(iterations,branches);
grouplens = cell(iterations,branches);
for i = 1:iterations
    for j = 1:branches
        len = double(0);
        groups{i,j} = intersect(find(Model(:,4)==i), find(Model(:,5)==j));
        for s = 2:size(groups{i,j},1)
            xi = Model(groups{i,j}(s-1,1),1);
            yi = Model(groups{i,j}(s-1,1),2);
            zi = Model(groups{i,j}(s-1,1),3);
            xn = Model(groups{i,j}(s,1),1);
            yn = Model(groups{i,j}(s,1),2);
            zn = Model(groups{i,j}(s,1),3);
            len = len + norm([xn-xi yn-yi zn-zi]);
        end
        grouplens{i,j} = len;
    end
end

minlen = min([grouplens{:,1}])/3;
maxlen = max([grouplens{:,:}])-0.000001;
tortlens = minlen:(maxlen-minlen)/(numlens-1):maxlen;
lenrange = [(minlen-(maxlen-minlen)/(2*(numlens-1))) (maxlen+(maxlen-minlen)/(2*(numlens-1)))];
tortdata = cell(iterations,branches);
L = [];
R = [];

for i = 1:iterations
    for j = 1:branches
%         S = [];
        tortdata{i,j} = [];
        for s = 2:size(groups{i,j},1)
            axi = Model(groups{i,j}(s-1,1),1);
            ayi = Model(groups{i,j}(s-1,1),2);
            azi = Model(groups{i,j}(s-1,1),3);
            alen = double(0);
            alencount = 1;
            for t = s:size(groups{i,j},1)
                ax1 = Model(groups{i,j}(t-1,1),1);
                ay1 = Model(groups{i,j}(t-1,1),2);
                az1 = Model(groups{i,j}(t-1,1),3);
                ax2 = Model(groups{i,j}(t,1),1);
                ay2 = Model(groups{i,j}(t,1),2);
                az2 = Model(groups{i,j}(t,1),3);
                alen = alen + norm([ax2-ax1 ay2-ay1 az2-az1]);
                if alen > tortlens(1,alencount)
                    elen = norm([ax2-axi ay2-ayi az2-azi]);
                    tortdata{i,j} = [tortdata{i,j}; alen elen];
                    alencount = alencount + 1;
%                     if alencount == numlens + 1
%                         break
%                     end
                end
            end
%        scatter3(tortdata{i,j}(:,1),tortdata{i,j}(:,1)./tortdata{i,j}(:,2),S)
        end
        if isempty(tortdata{i,j}) == 0
            L = [L; tortdata{i,j}(:,1)];
            R = [R; tortdata{i,j}(:,2)];
%             S = [S; (grouplens{i,j}-alen).*ones(size(tortdata{i,j}(:,1),1),1)];
        end
    end
end

% figure
% hold
% Clist = C*ones(length(L),1);
% scatter3(L,L./R,Clist)

% [LAve, LDev, RAve, RDev] = BinDatabyL(lenrange, numlens, L, R);
% [~, ~, TAve, TDev] = BinDatabyL(lenrange, numlens, L, L./R);
% 
% figure
% subplot(2,1,1)
% plot(LAve, RAve, 'ks') % RDev, RDev, LDev, LDev,
% ylabel('R (Euclidean Distance)')
% xlabel('L (Arc Length)')
% 
% subplot(2,1,2)
% plot(LAve, TAve, 'ks') % TDev, TDev, LDev, LDev,
% ylabel('T (Tortuosity L/R)')
% xlabel('L (Arc Length)')
% grouplens = cell(max(itnums),max(brnums));
% for i = 1:size(iterations,2)
%     for j = 1:branches(i)
%         len = double(0);
%         for s = 2:size(groups{i,j},1)
%             xi = Model(groups{i,j}(s-1,1),1);
%             xn = Model(groups{i,j}(s,1),1);
%             yi = Model(groups{i,j}(s-1,1),2);
%             yn = Model(groups{i,j}(s,1),2);
%             zi = Model(groups{i,j}(s-1,1),3);
%             zn = Model(groups{i,j}(s,1),3);
%             len = len + norm([xn-xi yn-yi zn-zi]);
%         end
%         grouplens{i,j} = len;
%     end
% end
end