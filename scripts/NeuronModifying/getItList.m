function IL = getItList(PL)
        IL = zeros(size(PL,1),1);
        for i=1:length(PL)
            j =i;
            while j ~= 0
                j = PL(j);
                IL(i) = IL(i) +1;
            end
        end
end