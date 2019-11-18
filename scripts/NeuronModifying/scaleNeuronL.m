% Example: "Vnew50 = straightenNeuron(V,DM,SLA,WL,.5);" would mean that
% every angle between branches would be 50% of what it previously was.  
% previously Vnew = straightenNeuron(V, DM, SLA, WL, percent)

% testing options
% rP = 'E:\Julian\FractalNeurons\37_0005_Special\Basal';
% wP = 'E:\Julian\FractalNeurons\37_0005_Special\Results';
% mN = bNC(rP,fullfile(wP,'L'),0,'L','CreationOnly',true);

function  [Vnew, VAllnew,SLAnew] = scaleNeuronL(V, VAll, DM, SLA, maxL, PL,varargin)
p = inputParser;
addParameter(p,'normalized',false,@islogical);
parse(p,varargin{:});
    Vnew = V;
    VAllnew = VAll; %--
    SLAnew = SLA;
    for i=1:size(SLA,1)
           factor = maxL;%/SLA(i,1);
%         if ~any(i ==WL) %skips over wonky joints. --leave rings unaltered here too.
            segV = getSegV(Vnew, SLA, i); 
            segV = [segV ones(size(segV,1),1)];%convert to 4 -vector
            segVAll = getRingSegV(VAllnew,SLA,i); %--
            segVAll = [segVAll ones(size(segVAll,1),1)];%convert to 4 -vector
            segVAllnew = zeros(size(segVAll));
            % get the parrent segment
            if PL(i) == 0 % don't want to align if we have the first branch
                segVparent = [];
%                 segVAllparent = [];
            else
                segVparent = getSegV(Vnew, SLA, PL(i));
%                 segVAllparent = getRingSegV(VAllnew,SLA,PL(i));
            end
            
            
            segVnew = factor*segV; %rescales the branch
            segVnew(:,4) = 1;
%             segVAllnew(:,4) = 1;
            T = segVnew(:,1:3) - segV(:,1:3);
            for j = 1:size(T,1)%translate all the branches rings
                Mtran = makehgtform('translate',T(j,:));
                segVAllnew(16*(j-1)+1:16*j,:) = (Mtran*segVAll(16*(j-1)+1:16*j,:)')'; 
            end
            if PL(i) == 0 %translate onto the end of the parent
                Ptran = makehgtform('translate',[0,0,0]);
            else 
                Ptran = makehgtform('translate',segVparent(end,1:3)-segVnew(1,1:3));
                segVnew = (Ptran*segVnew')';
                segVAllnew = (Ptran*segVAllnew')';
            end

            Vnew = setNewV(Vnew,segVnew(:,1:3),SLA,i);
            VAllnew = setNewVAll(VAllnew,segVAllnew(:,1:3),SLA,i);%--
            
            
            
            for j=2:(1+DM(i,1)) % run through all the daughters and translate the end of the current branch
%                 Mtran1 = makehgtform('translate',T(end,:));
                segToTranslate = getSegV(Vnew,SLA,DM(i,j));
                segToTranslateParent = getSegV(Vnew,SLA,PL(DM(i,j)));
                Mtran = makehgtform('translate',segToTranslateParent(end,1:3)-segToTranslate(1,1:3));
                segToTranslate = [segToTranslate ones(size(segToTranslate,1),1)];  %Transforms vector into a 4-vector for translations  
                segRingsToTranslate = getRingSegV(VAllnew,SLA,DM(i,j));%--
                segRingsToTranslate = [segRingsToTranslate ones(size(segRingsToTranslate,1),1)];%Transforms vector into a 4-vector for translations  
                translatedSeg = (Mtran*segToTranslate')';
                translatedSeg = translatedSeg(:,1:3);
                translatedSegAll = (Mtran*segRingsToTranslate')';
                translatedSegAll = translatedSegAll(:,1:3);%--
                Vnew = setNewV(Vnew,translatedSeg,SLA,DM(i,j));
                VAllnew = setNewVAll(VAllnew,translatedSegAll,SLA,DM(i,j));%--
            end
%             [newSeg,Vnew] = rotateNeuronSeg(Vnew,DM,SLA,segV,i,percent);
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSeg(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%keeps original angle            
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegPreserveCone(Vnew,VAllnew,DM,SLA,segV,segVAll,i,percent);%sets angle based off of last pt
%             [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegAllAngle(Vnew,VAllnew,DM,SLA,segV,segVAll,segVparent,i,percent);%changes even the very first angle
%              [newSeg,Vnew,newSegAll,VAllnew] = rotateNeuronSegL(Vnew,VAllnew,DM,SLA,segV,segVAll,segVparent,i,factor);%changes only the very first angle

%             Vnew = segVnew;
%             VAllnew = segVAllnew;
%         end
        SLAnew(i,1) = factor*SLA(i,1);
    end
    if p.Results.normalized
        Vnew = Vnew/factor;
        VAllnew = VAllnew/factor;
        SLAnew(:,1) = SLAnew(:,1)/factor;
    end
    
    Ttran = makehgtform('translate',V(1,:)-Vnew(1,:));
    Vnewtemp = [Vnew ones(size(Vnew,1),1)];
    VAllnewtemp = [VAllnew ones(size(VAllnew,1),1)];
    Vnewtemp = (Ttran*Vnewtemp')';
    VAllnewtemp = (Ttran*VAllnewtemp')';
    Vnew = Vnewtemp(:,1:3);
    VAllnew = VAllnewtemp(:,1:3);
    
end