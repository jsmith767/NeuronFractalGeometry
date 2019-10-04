%Plots for Normalize off natural Neurons
function y = batchneuronplot(type,method,s1,type2,method2,s2)
    [F,D,P,M,V,L] = sfg(s1);
    if nargin > 3
      [F2,D2,P2,M2,V2,L2] = sfg(s2);
    end
    figure
    subplot(3,3,1)
    fig1 = scatter(D,P,5);
    xlabel('D')
    ylabel('\sigma')
    title(['Profile vs Fractal Dimension (' type ',' method ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0.5 1.5])   
    if nargin > 3
        hold;
        scatter(D2,P2,5);
        title(['Profile vs Fractal Dimension (' type '/' type2 ',' method '/' method2 ',aveNorm)'])
    end
%     saveas(fig1,['nPvsD-' type(1) '-' method(1) '.fig']);
    subplot(3,3,2)
    fig2 = scatter(D,V,5);
    xlabel('D')
    ylabel('V')
    title(['Volume vs Fractal Dimension (' type ',' method ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0 2])  
    if nargin > 3
        hold;
        scatter(D2,V2,5);
        title(['Volume vs Fractal Dimension (' type '/' type2 ',' method '/' method2 ',aveNorm)'])
    end
%     
%     subplot(3,1,3)
%     fig2 = scatter(D,1./V,5);
%     xlabel('D')
%     ylabel('1/V')
%     title(['Inverse Volume vs Fractal Dimension (' type ',' method ',aveNorm)'])
%     xlim([1 2])
%     ylim([0 2])  
%     if nargin > 3
%         hold;
%         scatter(D2,1./V2,5);
%     end
    
%     saveas(fig2,['nVvsD-' type(1) '-' method(1) '.fig']);
    subplot(3,3,3)
    fig3 = scatter(D,M,5);
    xlabel('D')
    ylabel('M')
    title(['Mass vs Fractal Dimension (' type ',' method ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0 2])
    if nargin > 3
        hold;
        scatter(D2,M2,5);
    end
    
%     saveas(fig3,['nMvsD-' type(1) '-' method(1) '.fig']);
%     subplot(2,3,4)
%     fig4 = scatter(D,P./V,5);
%     xlabel('D')
%     ylabel('\sigma/V')
%     title(['Connectivity vs Fractal Dimension (' type ',' method ',aveNorm)'])
%     xlim([1 2])
%     ylim([0 2])
end
