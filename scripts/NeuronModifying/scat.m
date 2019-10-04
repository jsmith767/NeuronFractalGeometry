function scat(x,y,varargin)
figure
% p = inputParser;
% addOptional(p,'color','k.');
% parse(p,varargin{:});
scatter(x,y,varargin{:})
xlabel(inputname(1));
ylabel(inputname(2));
end