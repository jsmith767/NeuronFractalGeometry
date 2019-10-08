% Processes = imread('K:\Keck\MicroscopeImages\BB5\Pluth\Batman graph\Project_TileScan_003_s049_ch00processes.tif');
% Processes = logical(Processes);
% [ProX ProY] = ind2sub([size(Processes,1) size(Processes,2)],find(Processes));
% ProXY = [ProX, ProY];
% Input ProXY as Mod.

function ExpMod = makePtsLarger_Processes(Mod,D)
    Diam = D*2 + 1;
    [cols,rows] = meshgrid(1:Diam);
    BSphere = (rows - (D+1)).^2 + (cols - (D+1)).^2 <= (D)^2;
    [SphereIx,SphereIy] = ind2sub([Diam Diam],find(BSphere));
    SphereIx = SphereIx - (D+1);
    SphereIy = SphereIy - (D+1);
    ExpMod = zeros(size(Mod,1)*size(SphereIx,1),2);
    count = 1;
    for p = 1:size(Mod,1)
        for r = 1:size(SphereIx,1)
            ExpMod(count,:) = [Mod(p,1)+SphereIx(r,1) Mod(p,2)+SphereIy(r,1)];
            count = count + 1;
        end
    end
    ExpMod = unique(ExpMod,'rows');
end