%makeGif
filename = '1_00040-05-200Orig.gif';
files = dir('*.png');
num = (0:0.02:2);
num2 = flip(num);
num = [num num2];
% for i=1:length(files)%use for single gif files
% im{i} = imread(files(i).name);
% im{i} = textOverlay(im{i},['\theta =' num2str(num(i),'%1.2f')],500,500);
% end
im1 = cell(1,length(files)/2);
im2 = cell(1,length(files)/2);
im = cell(1,length(files)/2);
[~,ndx] = natsortfiles({files.name}); % indices of correct order
files = files(ndx); % sort structure using indices
for i=1:length(files)/2 %use for basal and apical together
im1{i} = imread(files(i).name);
im2{i} = imread(files(i+length(files)/2).name);
im{i} = imfuse(im1{i},im2{i});
im{i} = textOverlay(im{i},['n =' num2str(num(i),'%1.2f')],500,500);
end
im2 = flip(im);
im = [im im2];
for idx = 1:length(im)
[A,map] = rgb2ind(im{idx},256);
if idx == 1
imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
else
imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
end
end