function c = vD(c)
while iscell(c)
    c = vertcat(c{:});
end
end