% load('D:\Conor\Research\Mathematica\HTree-Models\3D-7It-Both\masterH.mat');
tic

viewpoints = 200; %Number of viewpoints to use when calculating the profile area
ExpandDiameterBy = 4; %Number of voxels to expand the diameter of the neurons by
NumHTrees = size(masterH,2);

for n = 1%:NumHTrees
    [p,plist,~] = ProfileArea_HTree(masterH(n).ptCloud,viewpoints,ExpandDiameterBy+1);
    masterH(n).AveP = p;
    masterH(n).AllP = plist;
end
toc
% save('D:\Conor\Research\Mathematica\HTree-Models\3D-7It-Both\masterH.mat','masterH','-v7.3');

% clearvars