function [alpha, bmin, L] = bplfit( h, boundaries, varargin)

% BPLFIT fits a power-law model to binned data. 
% Source: http://tuvalu.santafe.edu/~aaronc/powerlaws/bins/
%
%   When using binned data, the data vector 'h' is assumed to 
%   contain histogram counts between bin edges 'boundaries'.
%   Usage: a = bplfit([900 90 9], [1 10 100 1000])
%   Note that while the above example uses logarithmic binning 
%   (powers of 10), any other binning scheme can be used in 
%   practice.
%
%----------
% Options:
%----------
% 1. a = bplfit(h, boundaries, 'range', 1.5:0.01:3.5)
%    The 'range' option can be specified to restrict search for
%    alpha parameter. In above example, bplfit gives the best 
%    looking alpha in the specified range. By default bplfit uses 
%    matlab's fminsearch function which in turn uses the    
%    Nelder-Mead simplex search algorithm. Refer following url:
%    (http://www.mathworks.com/help/techdoc/math/bsotu2d.html#bsgpq6p-11)
%
% 2. a = bplfit(h, boundaries, 'limit', 100)
%    The 'limit' option lets you limit the search for bmin. 
%    Values in boundaries above this limit are not considered as
%    candidate bmin values. 
%
% 3. a = bplfit(h, boundaries, 'bmin', 100)
%    The 'bmin' option lets you fix a value such as 100 for bmin. 
%    Note that this value should be one of the values in the 
%    boundaries array. In the above example, 100 cannot be the 
%    last bin boundary. Also, it is advisable to give the fitting
%    procedure atleast two bins to work with. 
%
%   With options 2.and 3., if 'limit' or 'bmin' value is not one 
%   of the elements in boundaries, bplfit chooses the bin boundary
%   which is closest to the specified value and less than that 
%   value.
%
% Version 1.0 (2012)
% Copyright (C) 2012 Yogesh Virkar (University of Colorado, Boulder)
% Distributed under GNU GPL v3.0
% http://www.gnu.org/copyleft/gpl.html
% BPLFIT comes with ABSOLUTELY NO WARRANTY

rngal = [];
limit = [];
bminb = [];

% ---------------------------------------------------------------
% ---------------Parsing command-line arguments------------------
% ---------------------------------------------------------------
i=1;
while i<=length(varargin)
    argok = 1;
    if(ischar(varargin{i}))
        switch varargin{i}
            case 'range', rngal = varargin{i+1}; i=i+1;
            case 'limit', limit = varargin{i+1}; i=i+1;
            case 'bmin', bminb = varargin{i+1}; i=i+1;
            otherwise, argok=0;    
        end
    end
    
    if ~argok,
        disp(['(BPLFIT) Ignoring invalid argument #' num2str(i+2)]); 
    end
    i=i+1;
end

% ---------------------------------------------------------------
% ------------------------Checking input-------------------------
% ---------------------------------------------------------------

% 1. h must have integer counts.
if isequal(fix(h),h)==0
    fprintf('(BPLFIT) Error: Vector h should be an integer vector.\n');
    alpha=NaN; bmin=boundaries(1); L=NaN;
    return;
end

% 2. h must be non-negative
if ~isempty(find(h<0, 1))
    fprintf('(BPLFIT) Error: Vector h should be non-negative.\n');
    alpha=NaN; bmin=boundaries(1); L=NaN;
    return;
end

% 3. boundaries must have number of elements as one more than 
%    the number in h
if numel(boundaries)~=(numel(h)+1)
    fprintf('(BPLFIT) Error: Incorrect number of elements in either boundaries or h.\n');
    alpha=NaN; bmin=boundaries(1); L=NaN;
    return;
end

% 4. Need atleast 2 bins to work with.
if numel(h)<2
    fprintf('(BPLFIT) Error: I need atleast 2 bins to make this work.\n');
    alpha=NaN; bmin=boundaries(1); L=NaN;
    return;
end

% 5. Checking range vector
if ~isempty(rngal) && (~isvector(rngal) || min(rngal)<1)
    fprintf('(BPLFIT) Error: ''range'' argument must contain a valid vector; using default.\n');
    rngal = 1.5:0.01:3.5;
end

% 6. Checking limit option
if ~isempty(limit) && (~isscalar(limit) || limit<min(boundaries))
    fprintf('(BPLFIT) Error: ''limit'' argument must be a positive value >= boundaries(1); using default.\n');
    limit = boundaries(end-2);
end

% 7. Checking bmin option
if ~isempty(bminb) && (~isscalar(bminb) || bminb>=boundaries(end-1))
    fprintf('(BPLFIT) Error: ''bmin'' argument must be a positive value < boundaries(end-1); using default.\n');
    bminb = boundaries(1);
end
% ---------------------------------------------------------------
% ---------------------------------------------------------------
% ---------------------------------------------------------------

% Reshape the input vectors
h = reshape(h, numel(h), 1);
boundaries = reshape(boundaries, numel(boundaries), 1);

% Need a minimum of 2 bins.
bmins = boundaries(1:end-2);

if ~isempty(bminb)
    bmins = bmins(find(bmins<=bminb, 1, 'last'));
end
if ~isempty(limit)
    bmins(bmins>limit) = [];
end
dat = zeros(size(bmins));

for xm=1:length(bmins)
            
    bmin = bmins(xm);
    
    % Truncate the data below bmin
    ind = find(boundaries>=bmin, 1);
    z = h(ind:end);
    n = sum(z);
    b = boundaries(ind:end); 
            
    % estimate alpha using specified range or using 
    % numerical maximization
    l = b(1:end-1);
    u = b(2:end);
    if ~isempty(rngal) 
        H = repmat(z, 1, numel(rngal));        
        LOWER_EDGE = repmat(l, 1, numel(rngal));
        UPPER_EDGE = repmat(u, 1, numel(rngal));
        ALPHA_EST = repmat(rngal, numel(b)-1, 1);
        temp = H .* (log(LOWER_EDGE.^(1-ALPHA_EST) - UPPER_EDGE.^(1-ALPHA_EST)) + (ALPHA_EST-1) .* log(bmin));
        sum_ = sum(temp, 1);
        [~,I] = max(sum_);
        al = rngal(I);
    else 
        hnd = @(alpha) -sum( z.*( log((l).^(1-alpha) - (u).^(1-alpha)) + (alpha-1)*log(bmin) ) );
        al = fminsearch(hnd, 1);
    end
    
    % compute KS statistic
    temp = cumsum(z(end:-1:1));
    cx = 1 - temp(end:-1:1)./n;
    cf = 1 - (l./bmin).^(1-al); 
    dat(xm) = max(abs(cf-cx));
end

% Choose bmin which minimizes the KS-statistic
D = min(dat);
bmin = bmins(find(dat<=D, 1, 'first'));

% Truncate data below bmin and recompute alpha
ind = find(boundaries>=bmin, 1);
z = h(ind:end);
b = boundaries(ind:end);
n = sum(z);
l = b(1:end-1);
u = b(2:end);
% recompute alpha using specified range or using 
% numerical maximization
if ~isempty(rngal)
    H = repmat(z, 1, numel(rngal));        
    LOWER_EDGE = repmat(l, 1, numel(rngal));
    UPPER_EDGE = repmat(u, 1, numel(rngal));
    ALPHA_EST = repmat(rngal, numel(b)-1, 1);
    temp = H .* (log(LOWER_EDGE.^(1-ALPHA_EST) - UPPER_EDGE.^(1-ALPHA_EST)) + (ALPHA_EST-1) .* log(bmin));
    sum_ = sum(temp, 1);
    [~,I] = max(sum_);
    alpha = rngal(I);
else
    hnd = @(alpha) -sum( z.*( log((l).^(1-alpha) - (u).^(1-alpha)) + (alpha-1)*log(bmin) ) );
    alpha = fminsearch(hnd, 1);
end
% Computing likelihood under fitted model (alpha, bmin)
L = (alpha-1)*log(bmin)*sum(z) + sum(z.*log(l.^(1-alpha) - u.^(1-alpha)));

end

