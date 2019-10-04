%expects log10 of box size l and number of boxes 
function [regression] = fitwrapper(l,n,start,stop,minPts)
regression.BS = l; %Writes the inputted box sizes
regression.N = n; %writes the inputted number of boxes filled at a size
[regression.fit,regression.gof] = createFit1(l,n,start,stop); %finds the line of regression for the whole line
regression.D = regression.fit.p1; %Gets the slope (fractal dimension)
regression.RR = regression.gof.rsquare; %Gets the Rsquared value
regression.start = start; %writes the start point into the struct
regression.stop = stop; %writes the stop point into the struct
regression.BScut = l(start:stop); %writes the portion of boxsizes that we use 
regression.Ncut = n(start:stop); %writes the portion of boxes filled used

for i=start:(stop-minPts+1)
    for j = i+minPts-1:stop
        [ftemp,gtemp] = createFit1(l,n,i,j);
        if gtemp.rsquare > regression.gof.rsquare
            regression.fit = ftemp; %fines the new equation for the goodness of fit
            regression.gof = gtemp; %finds the new goodness of fit
            regression.D = ftemp.p1;
            regression.RR = gtemp.rsquare;
            regression.start = i;
            regression.stop = j;
            regression.BScut = l(i:j);
            regression.Ncut = n(i:j);
        end
    end
end

end