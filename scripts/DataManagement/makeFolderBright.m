%image birthness adjuster
F = dir('*.tif');
mkdir('BrightImages')
for i=1:length(F)
    image = imread(F(i).name);
    try
        imageB = imadjust(image);
        imwrite(imageB,[F(i).name(1:end-4) 'B.tif']);
        movefile([F(i).name(1:end-4) 'B.tif'],'BrightImages','f');
    catch
        copyfile(F(i).name,'BrightImages','f');
    end 
end
    