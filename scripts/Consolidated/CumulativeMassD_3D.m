tic;

rmMax = 60;
rmNums = 120; % (200,72)->50, (120,60)->50, (170,50)->50, (200,30)->25, (36,60)->25, (37,50)->25

numNeurs = size(plottingN,2);
numCurvs = size(plottingN(1).data.W,2);

Mass = cell(numCurvs,numNeurs);
Radius = unique(round(geomspace(1,rmMax,rmNums)));

for n = 1:numNeurs
    for c = 1:numCurvs
        Model = plottingN(n).data.W(c).VintR1;
        maxMod = [max(Model(:,1)) max(Model(:,2)) max(Model(:,3))];
        minMod = [min(Model(:,1)) min(Model(:,2)) min(Model(:,3))];
        RG = floor(plottingN(n).data.W(c).ArbR);
        CM = round(mean(Model));
        BCM = CM - minMod + [1 1 1];
        ModXR = maxMod(1,1)-minMod(1,1)+1;
        ModYR = maxMod(1,2)-minMod(1,2)+1;
        ModZR = maxMod(1,3)-minMod(1,3)+1;
        BModR = 2*(RG+rmMax)+1;
        if BModR < ModXR
            BModR = ModXR;
        end
        if BModR < ModYR
            BModR = ModYR;
        end
        if BModR < ModZR
            BModR = ModZR;
        end
        BModSX = round((BModR - ModXR)/2);
        BModSY = round((BModR - ModYR)/2);
        BModSZ = round((BModR - ModZR)/2);
        BModel = false(BModR,BModR,BModR);
        for p = 1:size(Model,1)
            BModel(Model(p,1)-minMod(1,1)+1+BModSX,Model(p,2)-minMod(1,2)+1+BModSY,Model(p,3)-minMod(1,3)+1+BModSZ) = 1;
        end
        
        [cols,rows,tals] = meshgrid(1:BModR);
        RGMod = (rows - (round(ModXR/2)+BModSX)).^2 + (cols - (round(ModYR/2)+BModSY)).^2 + (tals - (round(ModZR/2)+BModSZ)).^2 <= (RG)^2;
        RGMod = RGMod.*BModel;
        [RGModIx,RGModIy,RGModIz] = ind2sub([BModR BModR BModR],find(RGMod));
        numCens = round(size(RGModIx,1)/10);
        CenI = randi(size(RGModIx,1),1,numCens);
        Mass{c,n} = zeros(1,rmMax);
        MassR = cell(1,rmMax);
        for r = Radius
            count = 0;
            [rmcols,rmrows,rmtals] = meshgrid(0:2*r);
            rmSphere = (rmrows - r).^2 + (rmcols - r).^2 + (rmtals - r).^2 <= (r)^2;
            MassR{1,r} = zeros(1,numCens);
            for p = 1:size(RGModIx,1)
%                 MassR{1,r}(1,p) = sum(sum(sum(BModel(RGModIx(CenI(1,p),1)-r:RGModIx(CenI(1,p),1)+r,RGModIy(CenI(1,p),1)-r:RGModIy(CenI(1,p),1)+r,RGModIz(CenI(1,p),1)-r:RGModIz(CenI(1,p),1)+r).*rmSphere)));
                MassR{1,r}(1,p) = sum(sum(sum(BModel(RGModIx(p,1)-r:RGModIx(p,1)+r,RGModIy(p,1)-r:RGModIy(p,1)+r,RGModIz(p,1)-r:RGModIz(p,1)+r).*rmSphere)));
            end
            Mass{c,n}(1,r) = mean(MassR{1,r});
        end
        Mass{c,n} = Mass{c,n}(1,Mass{c,n}~=0);
    end
end

clearvars -except plottingN plottingH masterN masterH HTreeM mNVox Mass Radius

toc;