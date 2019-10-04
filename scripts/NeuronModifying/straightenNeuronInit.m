% Example: "Vnew50 = straightenNeuron(V,DM,SLA,WL,.5);" would mean that
% every angle between branches would be 50% of what it previously was.  
% previously Vnew = straightenNeuron(V, DM, SLA, WL, percent)

function  [Vnew, VAllnew] = straightenNeuronInit(V, VAll, DM, SLA, WL, PL, percent)
    Vnew = V;
    VAllnew = VAll; %--
    for i=1:size(SLA,1)
%         if ~any(i ==WL) %skips over wonky joints. --leave rings unaltered here too.
            segV = getSegV(Vnew, SLA, i); 
            segVAll = getRingSegV(VAllnew,SLA,i); %--
            % get the parrent segment
            if PL(i) == 0 % don't want to align if we have the first branch
                segVparent = [];
%                 segVAllparent = [];
            else
                segVparent = getSegV(Vnew, SLA, PL(i));
%                 segVAllparent = getRingSegV(VAllnew,SLA,PL(i));
            end
%             [newSeg,Vnew] = rotateNeuronSeg(Vnew,DM,SLA,segV,i,percent);
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSeg(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%keeps original angle            
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegPreserveCone(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%sets angle based off of last pt
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegAllAngle(Vnew,VAllnew,DM,SLA,segV,segVAll,segVparent,i,percent);%changes even the very first angle
             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegInit(Vnew,VAllnew,DM,SLA,segV,segVAll,segVparent,i,percent);%changes only the very first angle
            Vnew = setNewV(Vnew,newSeg,SLA,i);
            VAllnew = setNewVAll(VAllnew,newSegAll,SLA,i);%--
%         end
    end