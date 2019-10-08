NumSamps = 1000;
NumNums = 5;

% NumCells = [20 50 100 200 500];
NumCells = [5 10 20 50 100];

for w = 1:8
    if w == 1
        W25 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 2
        W50 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 3
        W75 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 4 
        W100 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 5
        W125 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 6
        W150 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 7
        W175 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    elseif w == 8
        W200 = load(strcat('MATs\W',num2str(25*w),'-BetaGSim-',num2str(NumSamps),'Samples-R15.mat'));
    end
end


% figure;
% errorbar(NumCells,mean(W100.BetaG,2),std(W100.BetaG,0,2),'s','LineWidth',2,'Color',[0 0 0]);
% ylabel('\beta_G');
% xlabel('Cell Number');

Widths = 25:25:200;
BetaGbyWAve = zeros(NumNums,length(Widths));
BetaGbyWMed = zeros(NumNums,length(Widths));
BetaGbyWStd = zeros(NumNums,length(Widths));
for m = 1:NumNums
    BetaGbyWAve(m,1) = mean(W25.BetaG(m,:));
    BetaGbyWAve(m,2) = mean(W50.BetaG(m,:));
    BetaGbyWAve(m,3) = mean(W75.BetaG(m,:));
    BetaGbyWAve(m,4) = mean(W100.BetaG(m,:));
    BetaGbyWAve(m,5) = mean(W125.BetaG(m,:));
    BetaGbyWAve(m,6) = mean(W150.BetaG(m,:));
    BetaGbyWAve(m,7) = mean(W175.BetaG(m,:));
    BetaGbyWAve(m,8) = mean(W200.BetaG(m,:));
    
    BetaGbyWMed(m,1) = median(W25.BetaG(m,:));
    BetaGbyWMed(m,2) = median(W50.BetaG(m,:));
    BetaGbyWMed(m,3) = median(W75.BetaG(m,:));
    BetaGbyWMed(m,4) = median(W100.BetaG(m,:));
    BetaGbyWMed(m,5) = median(W125.BetaG(m,:));
    BetaGbyWMed(m,6) = median(W150.BetaG(m,:));
    BetaGbyWMed(m,7) = median(W175.BetaG(m,:));
    BetaGbyWMed(m,8) = median(W200.BetaG(m,:));
    
    BetaGbyWStd(m,1) = std(W25.BetaG(m,:));
    BetaGbyWStd(m,2) = std(W50.BetaG(m,:));
    BetaGbyWStd(m,3) = std(W75.BetaG(m,:));
    BetaGbyWStd(m,4) = std(W100.BetaG(m,:));
    BetaGbyWStd(m,5) = std(W125.BetaG(m,:));
    BetaGbyWStd(m,6) = std(W150.BetaG(m,:));
    BetaGbyWStd(m,7) = std(W175.BetaG(m,:));
    BetaGbyWStd(m,8) = std(W200.BetaG(m,:));
    
    figure;
    annotation('textbox',[0.45 0.9 0.1 0.1],'String',num2str(NumCells(1,m)),'LineStyle','none','Color',[0 0 0]/255,'FontSize',20,'FontName','SansSerif');
    errorbar(Widths,BetaGbyWAve(m,:),BetaGbyWStd(m,:),'LineWidth',2);
    hold on;
    errorbar(Widths,BetaGbyWMed(m,:),BetaGbyWStd(m,:),'LineWidth',2);
    legend({'Mean' 'Median'});
    ylabel('\beta_G');
    xlabel('Width');
end

figure;
hold on;
for m = 1:NumNums
    errorbar(Widths,BetaGbyWMed(m,:),BetaGbyWStd(m,:),'LineWidth',2);
end
legend({'5' '10' '20' '50' '100' '500'});
ylabel('\beta_G');
xlabel('Width');