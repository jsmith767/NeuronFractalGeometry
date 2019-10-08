NumSamps = 100;
NumNums = 6;
CellDens = [5 10 20 50 100 500];

for masknum = 1:5
    if masknum == 1
        D1p1I4 = load(strcat('MATs\D1.1-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    elseif masknum == 2
        D1p5I4 = load(strcat('MATs\D1.5-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    elseif masknum == 3
        D2p0I4 = load(strcat('MATs\D2.0-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    elseif masknum == 4
        D2p0I4 = load(strcat('MATs\D2.0I4-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    elseif masknum == 5 
        D2p0I5 = load(strcat('MATs\D2.0I5-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    elseif masknum == 6
        D2p0I6 = load(strcat('MATs\D2.0I6-BetaGSim-',num2str(NumSamps),'Samples-R31_pad.mat'));%_pad.mat'));
    end
end

% figure;
% errorbar(NumCells,mean(D1p1I4.BetaG,2),std(D1p1I4.BetaG,0,2),'s','LineWidth',2,'Color',[0 0 0]);
% ylabel('\beta_G');
% xlabel('Cell Density');

Dvals = [1.1 1.5 2.0];
BetaGbyDI4Ave = zeros(NumNums,length(Dvals));
BetaGbyDI4Med = zeros(NumNums,length(Dvals));
BetaGbyDI4Std = zeros(NumNums,length(Dvals));
iterations = [4 5 6];
BetaGbyIAve = zeros(NumNums,length(iterations));
BetaGbyIMed = zeros(NumNums,length(iterations));
BetaGbyIStd = zeros(NumNums,length(iterations));
for m = 1:NumNums
    BetaGbyDI4Ave(m,1) = mean(D1p1I4.BetaG(m,:));
    BetaGbyDI4Ave(m,2) = mean(D1p5I4.BetaG(m,:));
    BetaGbyDI4Ave(m,3) = mean(D2p0I4.BetaG(m,:));
    
    BetaGbyDI4Med(m,1) = median(D1p1I4.BetaG(m,:));
    BetaGbyDI4Med(m,2) = median(D1p5I4.BetaG(m,:));
    BetaGbyDI4Med(m,3) = median(D2p0I4.BetaG(m,:));
    
    BetaGbyDI4Std(m,1) = std(D1p1I4.BetaG(m,:));
    BetaGbyDI4Std(m,2) = std(D1p5I4.BetaG(m,:));
    BetaGbyDI4Std(m,3) = std(D2p0I4.BetaG(m,:));
    
    figure;
    annotation('textbox',[0.45 0.9 0.1 0.1],'String',num2str(CellDens(1,m)),'LineStyle','none','Color',[0 0 0]/255,'FontSize',20,'FontName','SansSerif');
    errorbar(Dvals,BetaGbyDI4Ave(m,:),BetaGbyDI4Std(m,:),'LineWidth',2);
    hold on;
    errorbar(Dvals,BetaGbyDI4Med(m,:),BetaGbyDI4Std(m,:),'LineWidth',2);
    legend({'Mean' 'Median'});
    ylabel('\beta_G');
    xlabel('D');

    
    BetaGbyIAve(m,1) = mean(D2p0I4.BetaG(m,:));
    BetaGbyIAve(m,2) = mean(D2p0I5.BetaG(m,:));
    BetaGbyIAve(m,3) = mean(D2p0I6.BetaG(m,:));
    
    BetaGbyIMed(m,1) = median(D2p0I4.BetaG(m,:));
    BetaGbyIMed(m,2) = median(D2p0I5.BetaG(m,:));
    BetaGbyIMed(m,3) = median(D2p0I6.BetaG(m,:));
    
    BetaGbyIStd(m,1) = std(D2p0I4.BetaG(m,:));
    BetaGbyIStd(m,2) = std(D2p0I5.BetaG(m,:));
    BetaGbyIStd(m,3) = std(D2p0I6.BetaG(m,:));
    
    figure;
    annotation('textbox',[0.45 0.9 0.1 0.1],'String',num2str(CellDens(1,m)),'LineStyle','none','Color',[0 0 0]/255,'FontSize',20,'FontName','SansSerif');
    errorbar(iterations,BetaGbyIAve(m,:),BetaGbyIStd(m,:),'LineWidth',2);
    hold on;
    errorbar(iterations,BetaGbyIMed(m,:),BetaGbyIStd(m,:),'LineWidth',2);
    legend({'Mean' 'Median'});
    ylabel('\beta_G');
    xlabel('Iterations');
end

figure;
hold on;
for m = 1:NumNums
    errorbar(Dvals,BetaGbyDI4Med(m,:),BetaGbyDI4Std(m,:),'LineWidth',2);
end
% legend({'5' '10' '20' '50' '100'});
legend(cellfun(@num2str,num2cell(CellDens),'UniformOutput',false));
ylabel('\beta_G');
xlabel('D');
    
figure;
hold on;
for m = 1:NumNums
    errorbar(iterations,BetaGbyIMed(m,:),BetaGbyIStd(m,:),'LineWidth',2);
end
% legend({'5' '10' '20' '50' '100'});
legend(cellfun(@num2str,num2cell(CellDens),'UniformOutput',false));
ylabel('\beta_G');
xlabel('Iterations');