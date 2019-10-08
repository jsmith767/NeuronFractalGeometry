function ExpMod = makePtsLarger_WithIB(Mod,D)
    Diam = D*2 + 1;
    [cols,rows,tals] = meshgrid(1:Diam);
    BSphere = (rows - (D+1)).^2 + (cols - (D+1)).^2 + (tals - (D+1)).^2 <= (D)^2;
    [SphereIx,SphereIy,SphereIz] = ind2sub([Diam Diam Diam],find(BSphere));
    SphereIx = SphereIx - (D+1);
    SphereIy = SphereIy - (D+1);
    SphereIz = SphereIz - (D+1);
    ExpMod = zeros(size(Mod,1)*size(SphereIx,1),5);
    count = 1;
    for p = 1:size(Mod,1)
        for r = 1:size(SphereIx,1)
            ExpMod(count,:) = [Mod(p,1)+SphereIx(r,1) Mod(p,2)+SphereIy(r,1) Mod(p,3)+SphereIz(r,1) Mod(p,4) Mod(p,5)];
            count = count + 1;
        end
    end
    ExpMod = unique(ExpMod,'rows');
end