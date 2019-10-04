% files = dir('*.mat');
% for i=1:length(files)
% load(files(i).name);
% for j = 1:length(x.data.allangles)
% x.data.allangles(j).ItData = x.data.original(j).ItData;
% end
% x.data = rmfield(x.data,'original');
% save(fullfile('newMat',files(i).name),'x');
% end


for i=1:length(masterN)
if(~isempty(masterN(i).data))
for j=1:length(masterN(i).data.allangles)
masterN(i).data.allangles(j).ItData = masterN(i).data.original(j).ItData;
end
masterN(i).data = rmfield(masterN(i).data,'original');
end
end