function CvsDandP(m)
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
method = 'W';
% method = 'I';
% method = 'P';
c = 0:0.25:2;
m(structfind(m,'data',[]))=[];%cleans entries that don't have data
for j=1:length(c)
    D{j} = [];
    AveP{j} = [];
end
for i =1:length(m)
    for j=1:length(c)
    D{j} = [D{j} m(i).data.(genvarname(method))(j).Ddata.reg.D];
    AveP{j} = [AveP{j} m(i).data.(genvarname(method))(j).AveP/m(i).data.(genvarname(method))(j).mass];
    end
end
for j=1:length(c)
mD(j) = mean(D{j});
sD(j) = std(D{j});
mP(j) = mean(AveP{j});
sP(j) = std(AveP{j});
end
figure
xlabel('Curvature')
yyaxis left
errorbar(c,mD,sD)
% plot(c,mD);
ylabel('D')
yyaxis right
% plot(c,mP);
errorbar(c,mP,sP)
ylabel('\sigma')
end