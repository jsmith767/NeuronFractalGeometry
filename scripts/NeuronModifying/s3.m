function s3(vector,varargin)
% p = inputParser;
% addOptional(p,'color','k.');
% parse(p,varargin{:});

scatter3(vector(:,1),vector(:,2),vector(:,3),varargin{:})
end