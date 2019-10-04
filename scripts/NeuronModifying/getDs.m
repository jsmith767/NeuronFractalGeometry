function [Ds,Ms,stds,files] = getDs(varargin)
    if length(varargin) < 1
        [P,~] = subdir();
    else
        P = varargin{1};
    end
    for i =1:length(P)
    [~,Ds{i},~,~,files{i}] = getR2Ds(P{i});
    Ms(i) = mean(Ds{i});
    stds(i) = std(Ds{i});
    end
end
