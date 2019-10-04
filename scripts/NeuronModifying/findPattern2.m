function [start, pattval] = findPattern2(array, pattern)
%findPattern2 Locate a pattern in an array.
%
%   indices = findPattern2(array, pattern) finds the starting indices of
%   pattern within array.
%
%   Example:
%   a = [0 1 4 9 16 4 9];
%   patt = [4 9];
%   indices = findPattern2(a,patt)
%   indices =
%        3     6

% Let's assume for now that both the pattern and the array are non-empty
% VECTORS, but there's no checking for this. 
% For this algorithm, I loop over the pattern elements.
len = size(pattern,1);
% First, find candidate locations; i.e., match the first element in the
% pattern.
% start = find(array==pattern(1,:));
start=find(ismember(array,pattern(1,:),'rows'));
% Next remove start values that are too close to the end to possibly match
% the pattern.
endVals = start+len-1;
start(endVals>size(array,1)) = [];
% Next, loop over elements of pattern, usually much shorter than length of
% array, to check which possible locations are valid still.
for pattval = 2:len
    % check viable locations in array
    locs = ismember(array(start+pattval-1,:),pattern(pattval,:),'rows');
    % delete false ones from indices
    start(~locs) = [];
    if length(start) < 1
        break;
    end
end