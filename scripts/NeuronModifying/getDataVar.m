function variable=getDataVar(m,method,c,var)
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
% method = 'W';
% method = 'I';
% method = 'P';
% c = 0:0.25:2;
% m(structfind(m,'data',[]))=[];%cleans entries that don't have data
variable = cell(length(c),1);
% for j=1:length(c)
%     variable{j} = [];
% %     AveP{j} = [];
% end
for i =1:length(m)
    for j=1:length(c)
%     variable{j} = [variable{j} m(i).data.(genvarname(method))(j).(genvarname(var))];
    variable{j} = [variable{j} m(i).data.(genvarname(method))(c(j)).(genvarname(var))];
%     AveP{j} = [AveP{j} m(i).data.(genvarname(method))(j).AveP/m(i).data.(genvarname(method))(j).mass];
    end
end
if(length(variable) ==1 && iscell(variable))
    variable = variable{1};
end
    
% for j=1:length(c)
% mD(j) = mean(D{j});
% sD(j) = std(D{j});
% mP(j) = mean(AveP{j});
% sP(j) = std(AveP{j});
% end
% figure
% xlabel('Curvature')
% yyaxis left
% errorbar(c,mD,sD)
% % plot(c,mD);
% ylabel('D')
% yyaxis right
% % plot(c,mP);
% errorbar(c,mP,sP)
% ylabel('\sigma')
end