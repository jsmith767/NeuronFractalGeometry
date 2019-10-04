function [F,D,P,M,V] = sfg(varargin)
    F = cell(length(varargin),1);
    D = cell(length(varargin),1);
    P = cell(length(varargin),1);
    M = cell(length(varargin),1);
    V = cell(length(varargin),1);
%     L = cell(length(varargin),1);
    for i=1:length(varargin)
        [F{i},D{i},P{i},M{i},V{i}] = neurondataplot(varargin{i});
    end
    F = vertcat(F{:});
    D = vertcat(D{:});
    P = vertcat(P{:});
    M = vertcat(M{:});
    V = vertcat(V{:});
%     L = vertcat(L{:});
end