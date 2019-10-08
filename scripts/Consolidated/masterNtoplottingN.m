% plottingN(238) = struct;

% load('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_P_Basal_SA_4-18-19.mat');
NumNeurs = size(masterN,2);
NumMods = size(masterN(1).data.P,2);
subi = 0;
for i = 1:NumNeurs
    plottingN(i).name = masterN(i).name;
    if ~isempty(masterN(i).data)
        for j = 1:NumMods
            plottingN(i-subi).data.P(j).AngMult = masterN(i).data.P(j).Curvature;
            plottingN(i-subi).data.P(j).volume = masterN(i).data.P(j).volume;
            plottingN(i-subi).data.P(j).mass = masterN(i).data.P(j).volMass;
            plottingN(i-subi).data.P(j).SA = 0;
            plottingN(i-subi).data.P(j).convHullSA = masterN(i).data.P(j).convHullSAVAll;
            plottingN(i-subi).data.P(j).VintR1 = masterN(i).data.P(j).VintR1;
            if ~isempty(masterN(i).data.P(j).Ddata)
                plottingN(i-subi).data.P(j).D = masterN(i).data.P(j).Ddata.reg.D;
            end
%             plottingN(i-subi).data.P(j).AveP = masterN(i).data.P(j).AveP;
%             plottingN(i-subi).data.P(j).AllP = masterN(i).data.P(j).AllP;
        end
    else
        subi = subi + 1;
    end
end

% load('plottingN_4-17-19.mat')
subi = 0;
for i = 1:NumNeurs
    if ~isempty(masterN(i).data)
        for j = 1:NumMods
            plottingN(i-subi).data.A(j).AngMult = plottingNOld(i).data.allangles(j).Curvature;
            plottingN(i-subi).data.A(j).volume = AAvol(i,j);
            plottingN(i-subi).data.A(j).mass = plottingNOld(i).data.allangles(j).volMass;
            plottingN(i-subi).data.A(j).SA = plottingNOld(i).data.allangles(j).SA;
            plottingN(i-subi).data.A(j).convHullSA = plottingNOld(i).data.allangles(j).convHullSA;
            plottingN(i-subi).data.A(j).VintR1 = plottingNOld(i).data.allangles(j).VintR1;
            if ~isempty(plottingNOld(i).data.allangles(j).Ddata)
                plottingN(i-subi).data.A(j).D = plottingNOld(i).data.allangles(j).Ddata.reg.D;
            end
            plottingN(i-subi).data.A(j).AveP = plottingNOld(i).data.allangles(j).AveP;
            plottingN(i-subi).data.A(j).AllP = plottingNOld(i).data.allangles(j).AllP;
            
            plottingN(i-subi).data.W(j).AngMult = plottingNOld(i).data.W(j).Curvature;
            plottingN(i-subi).data.W(j).volume = plottingNOld(i).data.W(j).volume;
            plottingN(i-subi).data.W(j).mass = plottingNOld(i).data.W(j).volMass;
            plottingN(i-subi).data.W(j).SA = plottingNOld(i).data.W(j).SA;
            plottingN(i-subi).data.W(j).convHullSA = plottingNOld(i).data.W(j).convHullSA;
            plottingN(i-subi).data.W(j).VintR1 = plottingNOld(i).data.W(j).VintR1;
            if ~isempty(plottingNOld(i).data.W(j).Ddata)
                plottingN(i-subi).data.W(j).D = plottingNOld(i).data.W(j).Ddata.reg.D;
            end
            plottingN(i-subi).data.W(j).AveP = plottingNOld(i).data.W(j).AveP;
            plottingN(i-subi).data.W(j).AllP = plottingNOld(i).data.W(j).AllP;
            
            plottingN(i-subi).data.A(j).ArbR = plottingNOld(i).data.allangles(j).ArbR;
            plottingN(i-subi).data.A(j).Tort = plottingNOld(i).data.allangles(j).Tort;
%             plottingN(i-subi).data.P(j).ArbR = ArborRadius_Neuron(masterN(i).data.P(j).V,masterN(i).SLA);
%             [Ls, Rs] = tortuosity_Neuron(masterN(i).data.P(j).V,masterN(i).SLA);
%             plottingN(i-subi).data.P(j).Tort = [Ls Rs];
            plottingN(i-subi).data.W(j).ArbR = plottingNOld(i).data.W(j).ArbR;
            plottingN(i-subi).data.W(j).Tort = plottingNOld(i).data.W(j).Tort;
        end
    else
        subi = subi + 1;
    end
    
    plottingN(i).SLA = plottingNOld(i).SLA;
end