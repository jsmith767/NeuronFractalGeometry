function verts = convertNeuronRingsToPoints(V)
  J = V(1:8:end,:);
  P=(J(1:2:end,:)+J(2:2:end,:))/2;
  verts = P;
end

%scatter3(verts(:,1),verts(:,2),verts(:,3));