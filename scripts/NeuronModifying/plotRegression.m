function y = plotRegression(reg) %input a regression struct
% figure
scatter(reg.BS,reg.N,'.')
hold
h = plot(reg.fit,reg.BScut,reg.Ncut);
legend(h,'Location','NorthWest')
ylim=get(gca,'ylim');
xlim=get(gca,'xlim');
text(0.3*xlim(2),1.4*ylim(1),['Low Bound =' num2str(10^(-reg.BScut(1))) ', High Bound =' num2str(10^(-reg.BScut(end))) ', D =' num2str(reg.D)]);
end