function BCcell = importBCfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   B200BOXCOUNTS = IMPORTFILE(FILENAME) Reads data from text file FILENAME
%   for the default selection.
%
%   B200BOXCOUNTS = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from
%   rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   B200boxCounts = importfile('B200_boxCounts.csv', 2, 20401);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2018/09/13 17:44:00

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Format for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
dataArray([2, 3, 4]) = cellfun(@(x) num2cell(x), dataArray([2, 3, 4]), 'UniformOutput', false);
dataArray(1) = cellfun(@(x) mat2cell(x, ones(length(x), 1)), dataArray(1), 'UniformOutput', false);
BCcell = [dataArray{1:end-1}];
