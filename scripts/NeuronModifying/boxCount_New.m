% load('test_recarray_struct.mat')
%s is a struct with fields 'x','y', and 'z' which correspond to all the
%voxelized points of a neuron.  
% inputRes refers to the resolution which the file was voxelized at. this
% can be found in the neuranalyze.py file that created it.  Also it should
% be 1/(box size), give at the end of the 'mat' or '.npy' file 'L-0_25'->4

function ns = boxCount_New(s,inputRes,sR)
bbox = max([max(s.x)-min(s.x),max(s.y)-min(s.y),max(s.z)-min(s.z)]); %define the bounding box
v = [s.x;s.y;s.z]';
% inputRes = 5;
tic %start timing
res = geomspace(3,bbox/inputRes,100); %inputRes converts the boudning box 
%of the voxelized neuron to that of real units.  Think of res as a number of divisions of the bbox
% res = geomspace(3,bbox/inputRes,100); -> values from a third of the
% bounding box to 1 micron.
    for i = 1:length(res) % goes through all the resolutions
    %     tic
        L = bbox/res(i); % finds the box length
        slideRes =floor(L/sR);
        if slideRes < 1
            slideRes = 1;
        end
        t = zeros(size(0:slideRes:floor(L)-1,2),size(0:slideRes:floor(L)-1,2),size(0:slideRes:floor(L)-1,2)); %initialize the counting struct
        it1 = 1;
        for j = 0:slideRes:floor(L)-1 % loop through the box sizes
    %         tic
            it2 =1;
            for k = 0:slideRes:floor(L)-1
    %             tic
                it3 = 1;
                for l = 0:slideRes:floor(L)-1
%                     tic
                    t(it1,it2,it3)=size(unique(uint16(ceil((v+[j k l])./L)),'rows'),1); % gets all the counts at a particular length (see R.Montgomery thesis for algorithm)            
%                     toc
                    it3 = it3 +1;
                end
                it2 = it2 +1;
    %             toc
            end
            it1 = it1+1;
    %         toc
        end
        
        ns(i).res = res(i); % Sets a struct with the resolution
        ns(i).L = L/inputRes; % Sets a struct with the box length
        ns(i).N = min(min(min(t))); % Sets the min number of counts
    %     toc
    end
toc
end
        
