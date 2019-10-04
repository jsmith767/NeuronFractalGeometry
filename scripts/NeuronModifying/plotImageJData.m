function plotImageJData(fileName,figTitle)
    data = importImageJBCData(fileName);
    dataLog10(:,1) = convertLogx(data(:,1),max(data(:,1)));
%     dataLog10(:,1) = convertLogx(data(:,1),1);
    dataLog10(:,2) = convertLogy(data(:,2));
    dataLog10(:,3) = convertLogy(data(:,3));
    
%     figure('position',[0 0 
    figure
    hold
    scatter(dataLog10(:,1),dataLog10(:,2),'filled');
    plot(dataLog10(:,1),dataLog10(:,3),'LineWidth',3);
    xlabel('$log(\frac{L_{max}}{L})$','FontSize', 36,'Interpreter','latex');
    ylabel('$log(N)$','Rotation',0,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize', 36,'Interpreter','latex');
    set(gca,'FontSize',30);
    if nargin > 1
        title(figTitle);
    end
end
    
