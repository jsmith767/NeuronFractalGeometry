function y = plotRegressionBoundsSingle(reg) %input a regression struct
% name = strrep(Ddata.name,'_','\_');
figure
subplot(2,1,1)
scatter(reg.L10BS,reg.L10N,'.')
hold

h = plot(reg.fit,'r-',reg.L10BScut,reg.L10Ncut);

% h2 = plot(reg.fitn,'b--',reg.L10BScutn,reg.L10Ncutn);
legend({'Allpts','','D','','Dn'},'Location','NorthWest')
line([reg.L10BS(reg.LSCOIndn) reg.L10BS(reg.LSCOIndn)], ylim);
line([reg.L10BS(reg.FSCOIndn) reg.L10BS(reg.FSCOIndn)], ylim);
% ylim=get(gca,'ylim');
% xlim=get(gca,'xlim');
% text(xlim(1),ylim(1),['FSCO =' num2str(reg.FSCOBS) ', LSCO =' num2str(reg.LSCOBS) ', D =' num2str(reg.D)]);
xlabel('log10(1/L)');
ylabel('log10(N)');
title([' min Pts:' num2str(reg.minPtsAllowed) ' FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D)]);
% title(['FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D),': FSCOn =' num2str(reg.FSCOBSn) 'um , LSCOn =' num2str(reg.LSCOBSn) 'um , Dn =' num2str(reg.Dn)]);
hold
subplot(2,1,2)
scatter(reg.L10BScut,reg.output.residuals,'o')
title('Residuals')
xlabel('log10(1/L)');
end