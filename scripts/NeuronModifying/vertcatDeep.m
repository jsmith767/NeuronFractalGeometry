function c = vertcatDeep(c)
while iscell(c)
    c = vertcat(c{:});
end
end