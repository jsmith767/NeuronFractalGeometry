radii = 50;
Circles = cell(1,radii);
Spheres = cell(1,radii);

for r = 1:radii
    [cols,rows,tals] = meshgrid(0:2*r);
    Sphere = (rows - r).^2 + (cols - r).^2 + (tals - r).^2 <= (r)^2;
    
    % Use the next two lines for logical arrays
    Spheres{1,r} = Sphere;
    Circles{1,r} = Sphere(:,:,r+1);
    
    % Use the rest of the code for (x,y,z) coordinate arrays
%     rI = cell(1,2*r+1);
%     cI = cell(1,2*r+1);
%     tI = cell(1,2*r+1);
%     
%     for z = 1:2*r+1
%         [rI{1,z},cI{1,z}] = find(Sphere(:,:,z));
%         rI{1,z} = rI{1,z} - (r+1);
%         cI{1,z} = cI{1,z} - (r+1);
%         tI{1,z} = zeros(size(rI{1,z},1),1);
%         tI{1,z}(:,1) = z - (r+1);
%     end
%     
%     count = 0;
%     for z = 1:2*r+1
%         count = count + size(tI{1,z},1);
%     end
%     Spheres{1,r} = zeros(count,3);
%     count1 = 0;
%     count2 = 0;
%     for z = 1:2*r+1
%         count1 = count2 + 1;
%         count2 = count2 + size(tI{1,z},1);
%         Spheres{1,r}(count1:count2,1:3) = [rI{1,z} cI{1,z} tI{1,z}];
%     end
%     
%     Circles{1,r} = unique(Spheres{1,r}(:,1:2),'rows');
end

clearvars -except plottingN plottingH masterN masterH HTreeM mNVox Spheres Circles