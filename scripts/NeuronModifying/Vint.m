% method = 'allangles';
method = 'W';
for i=1:length(masterN)
    i
%     [~,~,~,masterN(i).F,~] = analyzeNeuron(masterN(i).path,masterN(i).name);
    for j=1:9
        Vinttemp =makeSurface(vertcat(masterN(i).data.(genvarname(method))(j).VAll{:}),vertcat(masterN(i).F{:}),0.1);
        masterN(i).data.(genvarname(method))(j).VintR1 =unique(round(Vinttemp),'rows');
    end
end