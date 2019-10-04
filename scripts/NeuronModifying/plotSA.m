function plotSA(s,method,neuronID,C,meshIt)
if(meshIt >length(s(neuronID).data.(genvarname(method))(C).efM))
    meshIt = length(s(neuronID).data.(genvarname(method))(C).efM);
end
figure
patch('vertices', s(neuronID).data.(genvarname(method))(C).vM{1}, 'faces', s(neuronID).data.(genvarname(method))(C).fM{1}(:,1:3),'FaceColor','green','FaceAlpha',0.3);
% patch('vertices', s(neuronID).data.allangles(C).vM{meshIt}, 'faces', s(neuronID).data.allangles(C).fM{meshIt}(~s(neuronID).data.allangles(C).efM{meshIt},1:3),'FaceColor','green','FaceAlpha',0.3);
hold
patch('vertices', s(neuronID).data.(genvarname(method))(C).vM{meshIt}, 'faces', s(neuronID).data.(genvarname(method))(C).fM{meshIt}(s(neuronID).data.(genvarname(method))(C).efM{meshIt},1:3),'FaceColor','red','FaceAlpha',1);
axis tight
view([100,100,100])
end