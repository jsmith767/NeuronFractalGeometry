[Ds,~,~,~]=getDs();
f=vertcat(files{:});
f=cellfun(@(x) x(1:end-7),f,'UniformOutput',false);
D = vertcat(Ds{:});
BAA =setfieldfromstrings(BAA,'D',f,D);