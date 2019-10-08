load('K:\Keck\Programs\Consolidated\plottingN_A.mat');

Use0Case = 0; % 0 for no // 1 for yes
% BNumMods = size(plottingN(1).data.P,2);
% BNumMods = size(plottingN(1).data.W,2);
% BNumMods = size(plottingN(1).data.I,2);
BNumMods = size(plottingN(1).data.allangles,2);
% BNumMods = size(plottingN(1).data.original,2);
% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
clr2 = [[161 30 34]/255;[232 166 49]/255];
hists = cell(1,BNumMods);
C = [1 2 3 4 5 6 7 8 9];

if Use0Case == 0
    FirstMod = 2;
else
    FirstMod = 1;
end
Fcell = extractfield(plottingN,'name');
Dcell = cell(BNumMods-(FirstMod-1),size(plottingN,2));
Vcell = cell(BNumMods-(FirstMod-1),size(plottingN,2));
Pcell = cell(BNumMods-(FirstMod-1),size(plottingN,2));
Mcell = cell(BNumMods-(FirstMod-1),size(plottingN,2));
% SAcell = cell(BNumMods-(FirstMod-1),size(plottingN,2));
% for c = 1+(FirstMod-1):BNumMods
%     for n = 1:size(plottingN,2)
%         if ~isempty(plottingN(n).data)
%             if ~isempty(plottingN(n).data.P(c).Ddata)
%                 Dcell{c-(FirstMod-1),n} = plottingN(n).data.P(c).Ddata.reg.D;
%                 Vcell{c-(FirstMod-1),n} = plottingN(n).data.P(c).volume;
%                 Pcell{c-(FirstMod-1),n} = plottingN(n).data.P(c).AveP;
%                 Mcell{c-(FirstMod-1),n} = plottingN(n).data.P(c).mass;
%             end
%         end
%     end
% end
% for c = 1+(FirstMod-1):BNumMods
%     for n = 1:size(plottingN,2)
%         if ~isempty(plottingN(n).data)
%             if ~isempty(plottingN(n).data.W(c).Ddata)
%                 Dcell{c-(FirstMod-1),n} = plottingN(n).data.W(c).Ddata.reg.D;
%                 Vcell{c-(FirstMod-1),n} = plottingN(n).data.W(c).volume;
%                 Pcell{c-(FirstMod-1),n} = plottingN(n).data.W(c).AveP;
%                 Mcell{c-(FirstMod-1),n} = plottingN(n).data.W(c).mass;
%             end
%         end
%     end
% end
% for c = 1+(FirstMod-1):BNumMods
%     for n = 1:size(plottingN,2)
%         if ~isempty(plottingN(n).data)
%             if ~isempty(plottingN(n).data.I(c).Ddata)
%                 Dcell{c-(FirstMod-1),n} = plottingN(n).data.I(c).Ddata.reg.D;
%                 Vcell{c-(FirstMod-1),n} = plottingN(n).data.I(c).volume;
%                 Pcell{c-(FirstMod-1),n} = plottingN(n).data.I(c).AveP;
%                 Mcell{c-(FirstMod-1),n} = plottingN(n).data.I(c).mass;
%             end
%         end
%     end
% end
for c = 1+(FirstMod-1):BNumMods
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            if ~isempty(plottingN(n).data.allangles(c).Ddata)
                Dcell{c-(FirstMod-1),n} = plottingN(n).data.allangles(c).Ddata.reg.D;
                Vcell{c-(FirstMod-1),n} = plottingN(n).data.allangles(c).volume;
                Pcell{c-(FirstMod-1),n} = plottingN(n).data.allangles(c).AveP;
                Mcell{c-(FirstMod-1),n} = plottingN(n).data.allangles(c).mass;
%                 SAcell{c-(FirstMod-1),n} = plottingN(n).data.allangles(c).SA;
            end
        end
    end
end
% for c = 1+(FirstMod-1):BNumMods
%     for n = 1:size(plottingN,2)
%         if ~isempty(plottingN(n).data)
%             if ~isempty(plottingN(n).data.original(c).Ddata)
%                 Dcell{c-(FirstMod-1),n} = plottingN(n).data.original(c).Ddata.reg.D;
%                 Vcell{c-(FirstMod-1),n} = plottingN(n).data.original(c).volume;
%                 Pcell{c-(FirstMod-1),n} = plottingN(n).data.original(c).AveP;
%                 Mcell{c-(FirstMod-1),n} = plottingN(n).data.original(c).mass;
%             end
%         end
%     end
% end
IF = ~cellfun(@isempty,Fcell);
ID = ~cellfun(@isempty,Dcell);
IV = ~cellfun(@isempty,Vcell);
IP = ~cellfun(@isempty,Pcell);
IM = ~cellfun(@isempty,Mcell);
% ISA = ~cellfun(@isempty,SAcell);
Index = and(IF,ID);
Index = and(Index,IV);
Index = and(Index,IP);
Index = and(Index,IM);
% Index = and(Index,ISA);
UseIndex = 1;
checknum = sum(Index(UseIndex,:));
for i = 1:BNumMods-(FirstMod-1)
    if checknum > sum(Index(i,:))
        checknum = sum(Index(i,:));
        UseIndex = i;
    end
end
% UseIndex = 5;
BDbyM = zeros(BNumMods-(FirstMod-1),sum(Index(UseIndex,:)));
D = zeros((BNumMods-(FirstMod-1))*sum(Index(UseIndex,:)),1);
BVbyM = zeros(BNumMods-(FirstMod-1),sum(Index(UseIndex,:)));
V = zeros((BNumMods-(FirstMod-1))*sum(Index(UseIndex,:)),1);
BPbyM = zeros(BNumMods-(FirstMod-1),sum(Index(UseIndex,:)));
P = zeros((BNumMods-(FirstMod-1))*sum(Index(UseIndex,:)),1);
BMbyM = zeros(BNumMods-(FirstMod-1),sum(Index(UseIndex,:)));
M = zeros((BNumMods-(FirstMod-1))*sum(Index(UseIndex,:)),1);
% BSAbyM = zeros(BNumMods-(FirstMod-1),sum(Index(UseIndex,:)));
% SA = zeros((BNumMods-(FirstMod-1))*sum(Index(UseIndex,:)),1);
count = 0;
BAveNatVol = mean(vertcat(Vcell{5-(FirstMod-1),Index(UseIndex,:)}));
for i = 1:BNumMods-(FirstMod-1)
    BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
    BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)})./BAveNatVol;
    BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
    BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
%     BSAbyM(i,:) = vertcat(SAcell{i,Index(UseIndex,:)});
    
    jsub = 0;
    for j = 1:size(plottingN,2)
        if Index(UseIndex,j)
            count = count + 1;
            D(count,1) = BDbyM(i,j-jsub);
            V(count,1) = BVbyM(i,j-jsub);
            P(count,1) = BPbyM(i,j-jsub);
            M(count,1) = BMbyM(i,j-jsub);
%             SA(count,1) = BSAbyM(i,j-jsub);
        else
            jsub = jsub+1;
        end
    end
end

% b = bar(lengthbincenterALL,numinlengthbinALL,'stacked','FaceColor','flat','BarWidth',1);

figure('Name','1','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
hold;
if Use0Case == 0
    for i = 1:BNumMods-(FirstMod-1)
        subplot(2,4,i)
        hists{1,C(i)} = histfit(BDbyM(C(i),:),10,'kernel');
        hists{1,C(i)}(1).FaceColor = clr(C(i),:);
        hists{1,C(i)}(1).FaceAlpha = 1.0;
        hists{1,C(i)}(1).EdgeAlpha = 0.8;
        hists{1,C(i)}(2).Color = [0 0 0];
        ax = gca;
        ax.FontSize = 18;
    end
    boxloc = [[0.12 0.785];[0.33 0.785];[0.530 0.785];[0.74 0.785];[0.12 0.31];[0.33 0.31];[0.530 0.31];[0.74 0.31]];
    for i = 1:4
        for j = 1:2
            annotation('textbox',[boxloc(i+(j-1)*4,1) boxloc(i+(j-1)*4,2) 0.2 0.2],'String',strcat("Angle Multiplier ",num2str((i-1+(FirstMod-1))*0.25+(j-1)*1.00)),'FontSize',16,'FitBoxToText','on');
        end
    end
else
    for i = 1:BNumMods-(FirstMod-1)
        subplot(3,3,i)
        hists{1,C(i)} = histfit(BDbyM(C(i),:),10,'kernel');
        hists{1,C(i)}(1).FaceColor = clr(C(i),:);
        hists{1,C(i)}(1).FaceAlpha = 1.0;
        hists{1,C(i)}(1).EdgeAlpha = 0.8;
        hists{1,C(i)}(2).Color = [0 0 0];
        ax = gca;
        ax.FontSize = 18;
    end
    boxloc = [[0.17 0.768];[0.44 0.768];[0.72 0.768];[0.17 0.468];[0.44 0.468];[0.72 0.468];[0.17 0.168];[0.44 0.168];[0.72 0.168]];
    for i = 1:3
        for j = 1:3
            annotation('textbox',[boxloc(i+(j-1)*3,1) boxloc(i+(j-1)*3,2) 0.2 0.2],'String',strcat("Angle Multiplier ",num2str((i-1+(FirstMod-1))*0.25+(j-1)*0.75)),'FontSize',16,'FitBoxToText','on');
        end
    end
end

lgdstr = cell(BNumMods-(FirstMod-1),1);
for i = 1:BNumMods-(FirstMod-1)
    lgdstr{i,1} = strcat("Angle Multiplier ",num2str((i-1+(FirstMod-1))*0.25));
end
figure('Name','2','units','normalized','outerposition',[1.02 0.12 0.6 0.85])
hold;
for i = 1:BNumMods-(FirstMod-1)
    hists{1,C(i)} = histfit(BDbyM(C(i),:),10,'kernel');
    delete(hists{1,C(i)}(1));
    hists{1,C(i)}(2).Color = clr(C(i),:);
    ax = gca;
    ax.FontSize = 22;
    axL = xlabel('Fractal Dimension (D)');
    axL.FontSize = 26;
    ayL = ylabel('Counts');
    ayL.FontSize = 26;
end
legend(lgdstr,'Location','northeast','FontSize',16);

BPbyMAve = zeros(1,BNumMods-(FirstMod-1));
BPbyMDev = zeros(1,BNumMods-(FirstMod-1));
BDbyMAve = zeros(1,BNumMods-(FirstMod-1));
BDbyMDev = zeros(1,BNumMods-(FirstMod-1));
for i = 1:BNumMods-(FirstMod-1)
    BPbyMAve(1,i) = mean(BPbyM(i,:)./BMbyM(i,:));
    BPbyMDev(1,i) = std(BPbyM(i,:)./BMbyM(i,:));
    BDbyMAve(1,i) = mean(BDbyM(i,:));
    BDbyMDev(1,i) = std(BDbyM(i,:));
end
fig = figure('Name','3','units','normalized','outerposition',[1.02 0.12 0.6 0.85]);
set(fig,'defaultAxesColorOrder',[clr2(1,:);clr2(2,:)]);
hold;
% xlabel('Curvature')
xlabel('Angle Multiplier')
xlim([-0.1+(FirstMod-1)*0.25 2.1])
xticks(0:0.25:2)
yyaxis left
% ylim([0.236 0.25]) %Limits for AllAngles method
ylabel('Potential Connectivity (C)')
errorbar((FirstMod-1)*0.25:0.25:2,BPbyMAve,BPbyMDev,'LineWidth',1.3);
% plot((FirstMod-1)*0.25:0.25:2,BPbyMAve,'LineWidth',1.3);
%,'MarkerFaceColor', clr2(2,:), 'MarkerEdgeColor', clr2(2,:));
yyaxis right
% ylim([1.375 1.775]) %Limits for AllAngles method
ylabel('Fractal Dimension (D)')
% plot(0:0.25:2,BDbyMAve,'LineWidth',1.3);
errorbar((FirstMod-1)*0.25:0.25:2,BDbyMAve,BDbyMDev,'LineWidth',1.3);
%,'MarkerFaceColor', clr2(1,:), 'MarkerEdgeColor', clr2(1,:));
ax = gca;
ax.FontSize = 22;
axL.FontSize = 26;
ayL.FontSize = 26;

% % Connectivity versus Weave figure with no numbers
% figure
% hold;
% plot(0:0.25:2,BPbyMAve,'k-','LineWidth',1.6);
% xlabel('Weave')
% xlim([0 2])
% xticks(0:0.25:2)
% ylabel('Connectivity')
% set(gca,'xtick',[])
% set(gca,'ytick',[])
% ax = gca;
% ax.FontSize = 18;
% axL.FontSize = 22;
% ayL.FontSize = 22;