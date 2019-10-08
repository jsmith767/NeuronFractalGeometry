tic;

rmMax = 200;
rmNums = 72; % (200,72)->50, (120,60)->50, (170,50)->50, (200,30)->25, (60,36)->25, (50,37)->25

numNeurs = size(plottingN,2);
numCurvs = size(plottingN(1).data.W,2);

Mass = cell(numCurvs,numNeurs);
Radius = unique(round(geomspace(1,rmMax,rmNums)));

for n = 1:1
    for c = 5%1:numCurvs
        Model = unique(plottingN(n).data.W(c).VintR1(:,1:2),'rows');
        maxMod = [max(Model(:,1)) max(Model(:,2))];
        minMod = [min(Model(:,1)) min(Model(:,2))];
        RG = floor(plottingN(n).data.W(c).ArbR);
        CM = round(mean(Model));
        BCM = CM - minMod + [1 1];
        ModXR = maxMod(1,1)-minMod(1,1)+1;
        ModYR = maxMod(1,2)-minMod(1,2)+1;
        BModR = 2*(RG+rmMax)+1;
        if BModR < ModXR
            BModR = ModXR;
        end
        if BModR < ModYR
            BModR = ModYR;
        end
        BModSX = round((BModR - ModXR)/2);
        BModSY = round((BModR - ModYR)/2);
        BModel = false(BModR,BModR);
        for p = 1:size(Model,1)
            BModel(Model(p,1)-minMod(1,1)+1+BModSX,Model(p,2)-minMod(1,2)+1+BModSY) = 1;
        end
        
        [cols,rows] = meshgrid(1:BModR);
        RGMod = (rows - (round(ModXR/2)+BModSX)).^2 + (cols - (round(ModYR/2)+BModSY)).^2 <= (RG)^2;
        RGMod = RGMod.*BModel;
        [rI,cI] = find(RGMod);
        numCens = round(size(rI,1)/10);
        CenI = randi(size(rI,1),1,numCens);
        Mass{c,n} = zeros(1,rmMax);
        MassR = cell(1,rmMax);
        for r = Radius
            [rmcols,rmrows] = meshgrid(0:2*r);
            rmSphere = (rmrows - r).^2 + (rmcols - r).^2 <= (r)^2;
            MassR{1,r} = zeros(1,numCens);
            for p = 1:numCens
                MassR{1,r} = sum(sum(BModel(rI(CenI(1,p),1)-r:rI(CenI(1,p),1)+r,cI(CenI(1,p),1)-r:cI(CenI(1,p),1)+r).*rmSphere));
            end
            Mass{c,n}(1,r) = mean(rmmissing(MassR{1,r}));
        end
        Mass{c,n} = Mass{c,n}(1,Mass{c,n}~=0);
    end
end

% clearvars -except plottingN plottingH masterN masterH HTreeM mNVox Mass Radius

toc;