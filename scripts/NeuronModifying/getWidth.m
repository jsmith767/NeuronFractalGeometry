function w = getWidth(VAll)
    v = convertNeuronRingsToPoints(VAll);
    vc = VAll(1:16:end,:);
    d = pdist2(v,vc);
    w = 2*diag(d);
end
    
