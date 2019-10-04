figure
polarhistogram(sa,40,'normalization','probability','FaceColor','r')
hold
polarhistogram(wa,100,'normalization','probability','FaceColor','b')
pax = gca;
% pax.ThetaAxisUnits = 'radians';
% pax.ThetaLim = [0 pi/2];
pax.ThetaLim = [0 90];
pax.FontSize = 20;
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
rticklabels({})
rl = rlim;
r = rl(2);
th1 = median(sa);
th2 = median(wa);
polarplot(th1,r,'*','color','r')
polarplot(th2,r,'*','color','b')
