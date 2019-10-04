curveRange = 0:0.25:2;
scaling = 3;
% method = 'original';
% method = 'init';
% method = 'allangles';
method = 'W';
for i=1:length(masterN)
    if(masterN(i).broken ==1)
        i
        [V,VAll,SLA,VRM,DM,WL,PL,IL,N]=processNeuronReturnNoWrite(masterN(i).name,masterN(i).path,pwd,curveRange,scaling,method);
        masterN(i).data = getCurveData(curveRange,V,VAll,N,method); %get data specific to each curvature
        parsave(fullfile(pwd,[masterN(i).name '.mat']),masterN(i));
    end 
end