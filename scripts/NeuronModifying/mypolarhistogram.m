%[D,A,IA,WA,SA] = AvgAngleVsD(masterN);
% wa = vertcat(WA{5}{:});
% sa = vertcat(SA{5}{:});


figure
c1 = [0.4940 0.1840 0.5560];
c2 = [0.5569 0.5255 0.1843];

polarhistogram(sa,40,'normalization','probability','FaceColor',c1)
hold
polarhistogram(wa,100,'normalization','probability','FaceColor',c2)
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
polarplot(th1,r,'*','color',c1,'MarkerSize',10)
polarplot(th2,r,'*','color',c2,'MarkerSize',10)

