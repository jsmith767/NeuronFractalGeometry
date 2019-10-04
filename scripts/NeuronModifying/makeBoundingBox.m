function [V,F] = makeBoundingBox(Vamend,Famend,AllV)
Famend = Famend - min(min(Famend))+1;

[zmin,zminloc]=min(AllV(:,3)); %finds min Z value
[zmax,zmaxloc]=max(AllV(:,3));
[ymin,yminloc]=min(AllV(:,2)); 
[ymax,ymaxloc]=max(AllV(:,2)); 
[xmin,xminloc]=min(AllV(:,1)); 
[xmax,xmaxloc]=max(AllV(:,1)); 

Vamend(size(Vamend,1)+1,:)=AllV(zminloc,:); % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)-10];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

% [ymin,yminloc]=min(Vertices{1}(:,2));%fines min Y value
Vamend(size(Vamend,1)+1,:)=AllV(yminloc,:); % makes a duplicate of the lowest y value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)-10,Vamend(size(Vamend,1),3)];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

% [xmin,xminloc]=min(Vertices{1}(:,1));%finds min X value
Vamend(size(Vamend,1)+1,:)=AllV(xminloc,:); % makes a duplicate of the lowest x value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1)-10,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

% [zmax,zmaxloc]=max(Vertices{1}(:,3)); %finds largest Z value
Vamend(size(Vamend,1)+1,:)=AllV(zmaxloc,:); % makes a duplicate of the largest z value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)+10];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

% [ymax,ymaxloc]=max(Vertices{1}(:,2));%Finds largest Y value
Vamend(size(Vamend,1)+1,:)=AllV(ymaxloc,:); % makes a duplicate of the largest y value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+10,Vamend(size(Vamend,1),3)];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

% [xmax,xmaxloc]=max(Vertices{1}(:,1));% finds largest X value
Vamend(size(Vamend,1)+1,:)=AllV(xmaxloc,:); % makes a duplicate of the largest x value
Vamend(size(Vamend,1),:)=[Vamend(size(Vamend,1),1)+10,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)];
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2),Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1)+1,Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)]; % makes a duplicate of the lowest Z value
Vamend(size(Vamend,1)+1,:)=[Vamend(size(Vamend,1),1),Vamend(size(Vamend,1),2)+1,Vamend(size(Vamend,1),3)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-3,size(Vamend,1)-2,size(Vamend,1)-1];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-2,size(Vamend,1)-1,size(Vamend,1)];
Famend(size(Famend,1)+1,:)= [size(Vamend,1)-1,size(Vamend,1),size(Vamend,1)-3];
Famend(size(Famend,1)+1,:)= [size(Vamend,1),size(Vamend,1)-3,size(Vamend,1)-2];

V = Vamend;
F = Famend;
end