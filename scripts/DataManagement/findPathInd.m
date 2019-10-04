% Finds path to folders that Include ('I') or exclude ('E') strings within their
% path name
% Example: 
%     Ind = findPathInd(P,'I',sampleIDS,'Pluth','CNTGliaAnalysis','E','xtraFiles');
%           
%           'I' and 'E' mark the strings to be included or excluded. Those
%           strings or sets of string then follow.
%           where 'sampleIDS' is a cell array of character arrays.  e.g.
%           sampleIDs = {'AL1\','AL2\','AG10\'...}
%           When put together in a single cell array it will include all
%           instances of that array (a union, a logical 'OR'), separate entries will
%           provide an intersection (Logical 'AND').
%
% Often we will be pulling from a structure. e.g. 'params' in such an
% instance you might construct 'sampleIDS' as follows.
% sampleIDS = strcat(extractfield(params,'name'),'\');
%     Note: if you don't include the '\' confusion might occurs (e.g. 'A1' is included in 'A12'). 
%           The '\' denotes that we're looking for a folder.
%
% IMPORTANT: Include('I') before you exclude('E') if you are doing both!
function Ind = findPathInd(P,varargin)
%determine if we are excluding any strings and find appropriate indices
if isempty(find(strcmp(varargin,'E') == 1, 1,'first'))
    excludeInd = length(varargin)+1;
else
    excludeInd = find(strcmp(varargin,'E') == 1, 1,'first');
end
    %set our master index
    Ind = [];
    %run over inclusions
    for i=(find(strcmp(varargin,'I') == 1,1,'first')+1):(excludeInd-1)
        Index = [];
        %convert to cell of a character array if input is char array
        if ischar(varargin{i})
            varargin{i} = varargin(i);
        end
        %find the indices of the inclusions in P.
        for j=1:length(varargin{i})
            Index1 = ~contains(P,varargin{i}{j});
            Index = [Index find(Index1 == 0)];
        end
        %if it's the first instance then set all to output
        if i==(find(strcmp(varargin,'I') == 1,1,'first')+1)
            Ind = union(Ind,Index);
        else %otherwise take an intersection
            Ind = intersect(Ind,Index);
        end
    end
    %run over exclusions
    for i=excludeInd+1:length(varargin)
        Index = [];
        %convert to cell of a character array if input is char array
        if ischar(varargin{i})
            varargin{i} = varargin(i);
        end
        %find the indices of the exclusions in P.
        for j=1:length(varargin{i})
            Index1 = contains(P,varargin{i}{j});
            Index = [Index find(Index1 == 0)];
        end
        %if it's the first instance then set all to output
        if isempty(find(strcmp(varargin,'I') == 1, 1,'first')) && i==(find(strcmp(varargin,'E') == 1,1,'first')+1)
            Ind = union(Ind,Index);
        else %otherwise take an intersection
            Ind = intersect(Ind,Index);
        end
    end
end
