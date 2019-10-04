% Example: "Vnew50 = straightenNeuron(V,DM,SLA,WL,.5);" would mean that
% every angle between branches would be 50% of what it previously was.  
% previously Vnew = straightenNeuron(V, DM, SLA, WL, percent)

function  [Vnew, VAllnew] = straightenNeuronI(V, VAll, DM, SLA, WL, percent)
    Vnew = V;
    VAllnew = VAll; %--
    for i=1:size(SLA,1)
%         if ~any(i ==WL) %skips over wonky joints. --leave rings unaltered here too.
            segV = getSegV(Vnew, SLA, i); 
            segVAll = getRingSegV(VAllnew,SLA,i); %--
%             [newSeg,Vnew] = rotateNeuronSeg(Vnew,DM,SLA,segV,i,percent);
            [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegI(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%keeps original angle            
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegPreserveCone(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%sets angle based off of last pt
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegAllAngle(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%changes even the very first angle
            Vnew = setNewV(Vnew,newSeg,SLA,i);
            VAllnew = setNewVAll(VAllnew,newSegAll,SLA,i);%--
%         end
    end