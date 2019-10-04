for i =1:length(BDataEnd(5).SLA)
    h(i) = histogram(vertcat(BDataEnd(5).SLA{i}{1:end}));
    x{i} = h(i).BinEdges(1:end-1)+h(i).BinWidth/2;
    y{i} = h(i).Values;
    xL{i} = log(1./x{i});
    yL{i} = log(y{i});
end