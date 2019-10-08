function y = plotRegressionBoundsSingleScalingOnly(reg) %input a regression struct
% name = strrep(Ddata.name,'_','\_');
figure
s = scatter(reg.L10BS,reg.L10N,'.');
hold

h = plot(reg.fit,'r-',reg.L10BScut,reg.L10Ncut);

% max3 = 7;
% fit3 = createFit1(reg.L10BS,reg.L10N,1,max3);
% m3 = differentiate(fit3,reg.L10BS(1:max3));
% plot(fit3,reg.L10BS(1:max3),reg.L10N(1:max3));
% 
% min2 = 70;
% max2 = 97;
% fit2 = createFit1(reg.L10BS,reg.L10N,min2,max2);
% m2 = differentiate(fit2,reg.L10BS(min2:max2));
% plot(fit2,reg.L10BS(min2:max2),reg.L10N(min2:max2));
% 
% dim = [0.2 0.5 0.3 0.3];
% str = {'D=2'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
% 
% dim = [0.2 0.5 0.3 0.3];
% str = {'D=1.4'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
% 
% dim = [0.2 0.5 0.3 0.3];
% str = {'D=3'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');

% h2 = plot(reg.fitn,'b--',reg.L10BScutn,reg.L10Ncutn);
% legend({'Allpts','','D'},'Location','NorthWest')
legend([s(1) h(1) h(2)],'All Pts','D Fit Pts','D Fit')
line([reg.L10BS(reg.LSCOIndn) reg.L10BS(reg.LSCOIndn)], ylim);
line([reg.L10BS(reg.FSCOIndn) reg.L10BS(reg.FSCOIndn)], ylim);
% ylim=get(gca,'ylim');
% xlim=get(gca,'xlim');
% text(xlim(1),ylim(1),['FSCO =' num2str(reg.FSCOBS) ', LSCO =' num2str(reg.LSCOBS) ', D =' num2str(reg.D)]);
xlabel('log10(1/L)');
ylabel('log10(N)');
title([' min Pts:' num2str(reg.minPtsAllowed) ' FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D)]);
% title(['FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D),': FSCOn =' num2str(reg.FSCOBSn) 'um , LSCOn =' num2str(reg.LSCOBSn) 'um , Dn =' num2str(reg.Dn)]);
end