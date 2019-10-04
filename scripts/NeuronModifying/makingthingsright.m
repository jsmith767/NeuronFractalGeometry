method = 'allangles';
for i=1:length(masterN)
    fn = fieldnames(plottingN(i).data.A);
for j=1:9
  for k=1:length(fn)
    masterN(i).data.(genvarname(method))(j).(genvarname(fn{k})) = plottingN(i).data.A(j).(genvarname(fn{k}));
  end
% masterNW(i).data.W(j).SA = plottingN(i).data.W(j).SA;
% masterNW(i).data.W(j).convHullSA = plottingN(i).data.W(j).convHullSA;
% masterNW(i).data.W(j).volMass= plottingN(i).data.W(j).volMass;
% masterNW(i).data.W(j).VintR1 = plottingN(i).data.W(j).VintR1;
end
end
% 
% var = 'volume';
% for i=1:length(masterN)
% for j=1:9
%     [~,masterN(i).data.P(j).volume] = convhull(vertcat(masterN(i).data.P(j).VAll{:}));
% % masterNW(i).data.W(j).SA = plottingN(i).data.W(j).SA;
% % masterNW(i).data.W(j).convHullSA = plottingN(i).data.W(j).convHullSA;
% % masterNW(i).data.W(j).volMass= plottingN(i).data.W(j).volMass;
% % masterNW(i).data.W(j).VintR1 = plottingN(i).data.W(j).VintR1;
% end
% end
% method = 'P';
% for i=1:length(masterN)
% disp(i);
% for j=1:9
% masterN(i).data.(genvarname(method))(j).Vint = makeSurface(vertcat(masterN(i).data.(genvarname(method))(j).VAll{:}),vertcat(masterN(i).F{:}),0.1);
% masterN(i).data.(genvarname(method))(j).VintR1 =unique(round(masterN(i).data.(genvarname(method))(j).Vint),'rows');
% end
% masterN(i).data.P=rmfield(masterN(i).data.P,'Vint');
% end