function variable=getStructVar(m,var,varargin)
p = inputParser;
addParameter(p, 'subfields', '', @ischar);
addParameter(p, 'subindices', [], @isnumeric);
parse(p,varargin{:});
% 
% p = inputParser;
% addParameter(p, 'continue', false, @islogical);
% addParameter(p, 'redo', '', @ischar);%maintains the TPC files, just replaces the desired string. Enter Ex: '09'  finds Project_TileScan_003_s09_ch01
% addParameter(p,'reference',s.ref,@isnumeric);
% addParameter(p,'select','',@ischar); %be careful with select, it re-writes the whole TPC files
% addParameter(p,'buffer',300,@isnumeric);
% addParameter(p,'bufferFull',2048,@isnumeric);
% addParameter(p,'adjusted','',@ischar);
% addParameter(p,'redoMask',false,@islogical);
% addParameter(p,'blank',false,@islogical);
% % addParameter(p,'start',[],@isnumeric);
% parse(p,varargin{:});
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
% method = 'W';
% method = 'I';
% method = 'P';
% c = 0:0.25:2;
% m(structfind(m,'data',[]))=[];%cleans entries that don't have data
variable = cell(length(m),1);
% for j=1:length(c)
%     variable{j} = [];
% %     AveP{j} = [];
% end
for i =1:length(m)
%     variable{j} = [variable{j} m(i).data.(genvarname(method))(j).(genvarname(var))];
    variable{j} = [variable{j} m(i).data.(genvarname(method))(c(j)).(genvarname(var))];
%     AveP{j} = [AveP{j} m(i).data.(genvarname(method))(j).AveP/m(i).data.(genvarname(method))(j).mass];
end
if(length(variable) ==1 && iscell(variable))
    variable = variable{1};
end
    
% for j=1:length(c)
% mD(j) = mean(D{j});
% sD(j) = std(D{j});
% mP(j) = mean(AveP{j});
% sP(j) = std(AveP{j});
% end
% figure
% xlabel('Curvature')
% yyaxis left
% errorbar(c,mD,sD)
% % plot(c,mD);
% ylabel('D')
% yyaxis right
% % plot(c,mP);
% errorbar(c,mP,sP)
% ylabel('\sigma')
end