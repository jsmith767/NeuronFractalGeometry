%% Optical Data Odor Toolset
%Recent updates
%191002 altered for eye imaging, red/green
% optimized for 2P and wide field data taken with sniff and odor
% presentation to quantify cells with deltaC responses
% expected inputs: tiff stack, bpod code 
%
%% load file from tif stack
clc
clear
close all

%! set to open and select
%FileTif=uiimport;%('*.tif');

FileTif='fileZ4_10ustack_00002.tif';
%! find a better way to save metadata of frame rate and load here
%! not integrated yet
magnification=4

%! verify the timing of the odor has been updated with the TTL changes

ROIrange={0,fix((1370/magnification)/4),(fix(1370/magnification)/2),...
    fix((1370/magnification)*3/4),fix((1370/magnification))}; %enter mag, returns um

InfoImage=imfinfo(FileTif);
mImage=InfoImage(1).Width
nImage=InfoImage(1).Height
NumberImages=length(InfoImage)

% data=zeros(nImage,mImage,NumberImages,'double');
data=zeros(nImage,mImage,NumberImages,'uint16');
for i=1:NumberImages
   data(:,:,i)=imread(FileTif,'Index',i);
end
disp('read done')
data16=data;
data=double(data);
data(39,39,39)-data16(39,39,39)
% 
% if data(39,39,39)-data(39,39,39) == 0
%     print('data conversion correct')
% else
%     print('fix data conversion')
    
% disp('done')
% %other read in options
% %this works
% fname = '8076_767Hz_00001.tif';
% info = imfinfo(fname);
% num_images = numel(info);
% for k = 1:num_images
%     A = imread(fname, k, 'Info', info);
%     % ... Do something with image A ...
% end
%% optional split R/G channel
dataG=data(:,:,1:2:end);
% dataG=data(:,:,1:2:30);
DMG = mean(dataG,3);
dataR=data(:,:,2:2:end);
% dataR=data(:,:,2:2:30);
DMR=mean(dataR,3);
disp('R/G split')
%% optional plot Red and Green channels
close all
figure
colormap gray;
% boundG=[min(DMG(:)),prctile(DMG(:),95)]
boundG=[1.2    1.3]
imagesc(DMG,[boundG(1),boundG(2)])
hold on
title('Green')
%add correct sizing
yticks([1, size(DMG,2)/4,size(DMG,2)/2,...
    size(DMG,2)*3/4,size(DMG,2)]);
yticklabels({num2str(ROIrange{1}),num2str(ROIrange{2}),...
    num2str(ROIrange{3}),num2str(ROIrange{4}),num2str(ROIrange{5})});
xticks([1, size(DMG,2)/4,size(DMG,2)/2,...
    size(DMG,2)*3/4,size(DMG,2)]);
xticklabels({num2str(ROIrange{1}),num2str(ROIrange{2}),...
    num2str(ROIrange{3}),num2str(ROIrange{4}),num2str(ROIrange{5})});

print(gcf,'figureG.png','-dpng','-r300');
hold off


figure
colormap gray;
boundR=[min(DMR(:)),prctile(DMR(:),95)]
imagesc(DMR,[boundR(1),boundR(2)])
hold on
title('Red')
%add correct sizing
yticks([1, size(DMG,2)/4,size(DMG,2)/2,...
    size(DMG,2)*3/4,size(DMG,2)]);
yticklabels({num2str(ROIrange{1}),num2str(ROIrange{2}),...
    num2str(ROIrange{3}),num2str(ROIrange{4}),num2str(ROIrange{5})});
xticks([1, size(DMG,2)/4,size(DMG,2)/2,...
    size(DMG,2)*3/4,size(DMG,2)]);
xticklabels({num2str(ROIrange{1}),num2str(ROIrange{2}),...
    num2str(ROIrange{3}),num2str(ROIrange{4}),num2str(ROIrange{5})});

print(gcf,'figureR.png','-dpng','-r300');
hold off
