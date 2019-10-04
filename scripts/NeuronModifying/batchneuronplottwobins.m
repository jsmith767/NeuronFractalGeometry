%Plots for Normalize off natural Neurons
function y = batchneuronplottwobins(type,method,s1,method2,s2)
    [F,D,P,M,V,L] = sfg(s1);
    if nargin > 3
      [F2,D2,P2,M2,V2,L2] = sfg(s2);
    end
    
    %Add htrees (i.e. ht) and htreeprofiles (i.e. Pave) to function if we
    %want to plot HTrees along with the neurons
    %HProfile = htreeprofiles(1,:);
    %HVolume = extractfield(htrees,'V');
    %HMass = zeros(length(htrees),1);
    %HD = extractfield(htrees,'D');
    %for i = 1:length(htrees)
    %    HMass(i) = length(htrees(i).x);
    %end
    
    binRange = [1.35 1.6];
    Numbins = 12;
    [DAve, DDev, PAve, PDev] = BinDatabyD(binRange,Numbins,D,P);
    [~, ~, VAve, VDev] = BinDatabyD(binRange,Numbins,D,V);
    [~, ~, MAve, MDev] = BinDatabyD(binRange,Numbins,D,M);
    [D2Ave, D2Dev, P2Ave, P2Dev] = BinDatabyD(binRange,Numbins,D2,P2);
    [~, ~, V2Ave, V2Dev] = BinDatabyD(binRange,Numbins,D2,V2);
    [~, ~, M2Ave, M2Dev] = BinDatabyD(binRange,Numbins,D2,M2);
    
    figure
    subplot(3,1,1)
    fig1 = scatter(D,P,5);
    xlabel('Fractal Dimension (D)')
    ylabel('Profile Area (\sigma)')
    title(['Profile Area vs Fractal Dimension (' type ',' method ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0.7 1.2])
    if nargin > 3
        hold;
        scatter(D2,P2,5);
        title(['Profile vs Fractal Dimension (' type ',' method '/' method2 ',aveNorm)'])
    end
%    scatter(DAve,PAve,'b','s')
    errorbar(DAve,PAve,PDev,PDev,DDev,DDev,'bs','LineWidth',1.3)
%    scatter(D2Ave,P2Ave,'r','s')
    errorbar(D2Ave,P2Ave,P2Dev,P2Dev,D2Dev,D2Dev,'rs','LineWidth',1.3)
    legend({method; method2;'OrigBin';'EndBin'})
%     saveas(fig1,['nPvsD-' type(1) '-' method(1) '.fig']);
    subplot(3,1,2)
    fig2 = scatter(D,V,5);
    xlabel('Fractal Dimension (D)')
    ylabel('Volume (V)')
    title(['Volume vs Fractal Dimension (' type ',' method ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0 2])  
    if nargin > 3
        hold;
        scatter(D2,V2,5);
        title(['Volume vs Fractal Dimension (' type ',' method '/' method2 ',aveNorm)'])
    end
%    scatter(DAve,VAve,'b','s')
    errorbar(DAve,VAve,VDev,VDev,DDev,DDev,'bs','LineWidth',1.3)
%    scatter(D2Ave,V2Ave,'r','s')
    errorbar(D2Ave,V2Ave,V2Dev,V2Dev,D2Dev,D2Dev,'rs','LineWidth',1.3)
%    legend([method;method2])
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
    subplot(3,1,3)
    fig3 = scatter(D,M,5);
    xlabel('Fractal Dimension (D)')
    ylabel('Mass (m)')
    title(['Mass vs Fractal Dimension (' type ',' method '/' method2 ',aveNorm)'])
    xlim([1.2 1.8])
    ylim([0.5 1.5])
    if nargin > 3
        hold;
        scatter(D2,M2,5);
    end
%    scatter(DAve,MAve,'b','s')
    errorbar(DAve,MAve,MDev,MDev,DDev,DDev,'bs','LineWidth',1.3)
%    scatter(D2Ave,M2Ave,'r','s')
    errorbar(D2Ave,M2Ave,M2Dev,M2Dev,D2Dev,D2Dev,'rs','LineWidth',1.3)
%    legend([method;method2;'Binned'])
    
%     saveas(fig3,['nMvsD-' type(1) '-' method(1) '.fig']);
%     subplot(2,3,4)
%     fig4 = scatter(D,P./V,5);
%     xlabel('D')
%     ylabel('\sigma/V')
%     title(['Connectivity vs Fractal Dimension (' type ',' method ',aveNorm)'])
%     xlim([1 2])
%     ylim([0 2])
end
