function isit = iswf(obj)
% ISWF True for WaveFront type objects.
%   ISWF(OBJ) returns logical true (1) if OBJ is an object of
%   WaveFront type, like the ones loaded by LOADWAVEFRONT, and logical
%   false (0) otherwise.
% 
% See also LOADWAVEFRONT

% Conditions to be checked
checks = { 
    'isstruct(obj)' 
    'size(fields(obj),1)==11'
    'isfield(obj, ''vertex'')'
    'isfield(obj, ''vtex'')'
    'isfield(obj, ''vnorm'')'
    'isfield(obj, ''vparam'')'
    'isfield(obj, ''points'')'
    'isfield(obj, ''lines'')'
    'isfield(obj, ''faces'')'
    'isfield(obj, ''curvs'')'
    'isfield(obj, ''curvs2'')'
    'isfield(obj, ''surfs'')'
    'isfield(obj, ''conn'')'
    'isnumeric(obj.vertex)'
    'isnumeric(obj.vtex)'
    'isnumeric(obj.vnorm)'
    'isnumeric(obj.vparam)'
    'isnumeric(obj.curvs)'
    'isnumeric(obj.curvs2)'
    'isnumeric(obj.surfs)'
    'isnumeric(obj.conn)'
    'iscell(obj.points)'
    'iscell(obj.lines)'
    'iscell(obj.faces)' };

for i=1:length(checks)
  check = eval(checks{i});
  if ~check
    isit = false;
    return;
  end
end
isit = true;
