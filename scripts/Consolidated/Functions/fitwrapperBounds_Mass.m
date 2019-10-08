%takes log10 of box size l and number of boxes when calculating regression
%asks for start as the resolution in the natural units of the input 
%LSCO = large scale cutoff (as a percentage of the total e.g. '.25')
%FSCO = fine scale cutoff (as a physical dimension in the natural units e.g. '5' (um in the case of our neurons))
%at current logarithmic scaling 56 pts ~1 order of magnitude 37 pts ~2/3 OM
%OrderOfMagnitude tells how many points should be in the regression in
%terms of orders of magnitude: 1 = 1 OM
function [r] = fitwrapperBounds_Mass(Radius,Mass,FSCOInd,LSCOInd,minPts)

% %find the appropriate order of magnitude
% OMfactor = 10^OrderOfMagnitude;
% minPts = 1;
% OM = 0;
% while OM < OMfactor
% minPts = minPts +1;
% OM = floor(Radius(end)/Radius(end+1-minPts));
% end
r.minPtsAllowed = minPts;

r.L10R = log10(Radius);
r.L10M = log10(Mass);
r.L10Rcut = r.L10R(FSCOInd:LSCOInd);
r.L10Mcut = r.L10M(FSCOInd:LSCOInd);

[r.fit,r.gof,r.output] = createFit1(log10(Radius),log10(Mass),FSCOInd,LSCOInd); %finds the line of regression for the whole line
r.D = abs(r.fit.p1); %Gets the slope (fractal dimension)
r.RR = r.gof.rsquare; %Gets the Rsquared value
r.LSCOInd = LSCOInd; %writes the start point into the struct
r.FSCOInd = FSCOInd; %writes the stop point into the struct
%%%naive data
r.fitn = r.fit;
r.gofn = r.gof;
r.outputn = r.output;
r.Dn = r.D;
r.RRn = r.RR;
r.LSCOIndn = LSCOInd; %writes the start point into the struct
r.FSCOIndn = FSCOInd; %writes the stop point into the struct

for i=1:(LSCOInd-minPts+1)
    for j = i+minPts-1:LSCOInd
        [ftemp,gtemp,otemp] = createFit1(log10(Radius),log10(Mass),i,j);
        if gtemp.rsquare > r.gof.rsquare
            r.fit = ftemp; %fines the new equation for the goodness of fit
            r.gof = gtemp; %finds the new goodness of fit
            r.output = otemp;
            r.D = abs(ftemp.p1);
            r.RR = gtemp.rsquare;
            r.LSCOInd = j;
            r.FSCOInd = i;
            r.LSCOBS = Radius(j);
            r.FSCOBS = Radius(i);
            r.L10Rcut = r.L10R(i:j);
            r.L10Mcut = r.L10M(i:j);
        end
    end
end

end