
[P F] = getFiles(pwd);

VRM = cell(1,length(F));
DM = cell(1,length(F));
WL = cell(1,length(F));
PL = cell(1,length(sort([F{:}])));
IT = cell(1,length(sort([F{:}])));
M = cell(length(sort([F{:}])),2);
V = cell(1,length(F));
VAll = cell(1,length(F));
SLA = cell(1,length(sort([F{:}])));
slope = cell(length(sort([F{:}])),2);
k=1;
for i=1:length(F)
    for j=1:length(F{i})
%         fileName = F{i}(j);
        [~,fileName,~] = fileparts(cell2mat(F{i}(j)));
        filePath = P{i};
        %checks to see if the output file we will write already exists.
        %Have to look at 'writeOBJFulltest.m' to find the path.  clunky...
%         if ~(exist(fullfile('C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\',[fileName 'Full0.obj']),'file') == 2)
            try
                [~,~,PL{k},SLA{k},~,~,~] = getNeuronData(fileName,filePath);
                IT{k} = getIterationList(PL{k});
                M{k,2} = getMeansByIt(IT{k},SLA{k});
                M{k,1} = fileName;
                k=k+1;
            catch
                disp(['Something went wrong when getting data' fileName]);
            end
%         end
    end
end
name = 'meanDataBasal.dat';
path = 'C:\Users\jsmit\Google Drive\Research\Juliaba\NeuronObjs\Basal\';
T = cell2table(M,'VariableNames',{'fileName','D'});
writetable(T,name);
% fileID = fopen(name,'wt');
% formatspec = '%s %f\n';
% for i=1:length(slope)
%    fprintf(fileID, formatspec,slope{i,:});
% end
% fclose(fileID);

movefile(name,path,'f');