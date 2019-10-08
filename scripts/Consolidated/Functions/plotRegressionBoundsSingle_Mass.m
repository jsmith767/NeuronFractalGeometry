function y = plotRegressionBoundsSingle_Mass(reg) %input a regression struct
% name = strrep(Ddata.name,'_','\_');
figure
subplot(2,1,1)
scatter(reg.L10R,reg.L10M,'.')
hold

h = plot(reg.fit,'r-',reg.L10Rcut,reg.L10Mcut);

% h2 = plot(reg.fitn,'b--',reg.L10BScutn,reg.L10Ncutn);
legend({'Allpts','','D','','Dn'},'Location','NorthWest')
% line([-1.47 -1.47], [0 10]);
% line([-0.3 -0.3], [0 10]);
% ylim=get(gca,'ylim');
% xlim=get(gca,'xlim');
% text(xlim(1),ylim(1),['FSCO =' num2str(reg.FSCOBS) ', LSCO =' num2str(reg.LSCOBS) ', D =' num2str(reg.D)]);
xlabel('log10(Radius)');
ylabel('log10(Mass)');
title([' min Pts:' num2str(reg.minPtsAllowed) ' FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D)]);
% title(['FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D),': FSCOn =' num2str(reg.FSCOBSn) 'um , LSCOn =' num2str(reg.LSCOBSn) 'um , Dn =' num2str(reg.Dn)]);
hold
subplot(2,1,2)
scatter(reg.L10Rcut,reg.output.residuals,'o')
title('Residuals')
xlabel('log10(Radius)');
end