%takes log10 of box size l and number of boxes when calculating regression
%asks for start as the resolution in the natural units of the input 
%LSCO = large scale cutoff (as a percentage of the total e.g. '.25')
%FSCO = fine scale cutoff (as a physical dimension in the natural units e.g. '5' (um in the case of our neurons))
%at current logarithmic scaling 56 pts ~1 order of magnitude 37 pts ~2/3 OM
%OrderOfMagnitude tells how many points should be in the regression in
%terms of orders of magnitude: 1 = 1 OM
function [r] = fitwrapperBounds(l,n,res,LSCO,FSCO,OrderOfMagnitude)
r.BS = l; %Writes the inputted box sizes
r.N = n; %writes the inputted number of boxes filled at a size
r.resolution = res; %essentially number of divisions the bounding box is devided by so res=10 -> boxes of length .1 of the whole


%find the appropriate order of magnitude
OMfactor = 10^OrderOfMagnitude;
minPts = 1;
OM = 0;
while OM < OMfactor
minPts = minPts +1;
OM = floor(l(1)/l(minPts));
end

r.minPtsAllowed = minPts; 

r.L10BS = log10(1./l);%log10(1./l);
r.L10N = log10(n);


LSCOInd = find(res >1/LSCO,1,'first');
FSCOInd = find(l > FSCO,1,'last');

% LSCOInd = LSCO;
% FSCOInd = FSCO;

[r.fit,r.gof,r.output] = createFit1(r.L10BS,r.L10N,LSCOInd,FSCOInd); %finds the line of regression for the whole line
r.D = abs(r.fit.p1); %Gets the slope (fractal dimension)
r.RR = r.gof.rsquare; %Gets the Rsquared value
r.LSCOInd = LSCOInd; %writes the start point into the struct
r.FSCOInd = FSCOInd; %writes the stop point into the struct
r.LSCOBS = r.BS(LSCOInd);
r.FSCOBS = r.BS(FSCOInd);
r.L10BScut = r.L10BS(LSCOInd:FSCOInd); %writes the portion of boxsizes that we use 
r.L10Ncut = r.L10N(LSCOInd:FSCOInd); %writes the portion of boxes filled used
r.BScut = r.BS(LSCOInd:FSCOInd); %writes the portion of boxsizes that we use 
r.Ncut = r.N(LSCOInd:FSCOInd); %writes the portion of boxes filled used
%%%naive data
r.fitn = r.fit;
r.gofn = r.gof;
r.outputn = r.output;
r.Dn = r.D;
r.RRn = r.RR;
r.LSCOIndn = LSCOInd; %writes the start point into the struct
r.FSCOIndn = FSCOInd; %writes the stop point into the struct
r.LSCOBSn = r.BS(LSCOInd);
r.FSCOBSn = r.BS(FSCOInd);
r.L10BScutn = r.L10BS(LSCOInd:FSCOInd); %writes the portion of boxsizes that we use 
r.L10Ncutn = r.L10N(LSCOInd:FSCOInd); %writes the portion of boxes filled used
r.BScutn = r.BS(LSCOInd:FSCOInd); %writes the portion of boxsizes that we use 
r.Ncutn = r.N(LSCOInd:FSCOInd); %writes the portion of boxes filled used

for i=LSCOInd:(FSCOInd-minPts+1)
    for j = i+minPts-1:FSCOInd
        [ftemp,gtemp,otemp] = createFit1(r.L10BS,r.L10N,i,j);
        if gtemp.rsquare > r.gof.rsquare
            r.fit = ftemp; %fines the new equation for the goodness of fit
            r.gof = gtemp; %finds the new goodness of fit
            r.output = otemp;
            r.D = abs(ftemp.p1);
            r.RR = gtemp.rsquare;
            r.LSCOInd = i;
            r.FSCOInd = j;
            r.LSCOBS = r.BS(i);
            r.FSCOBS = r.BS(j);
            r.L10BScut = r.L10BS(i:j); %writes the portion of boxsizes that we use 
            r.L10Ncut = r.L10N(i:j); %writes the portion of boxes filled used
            r.BScut = r.BS(i:j);
            r.Ncut = r.N(i:j);
        end
    end
end

end