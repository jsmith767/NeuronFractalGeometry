%takes a neuron data struct and renormalizes the profile volume and mass
%based off of the natural neuron.

function s = renormalizestruct(s)
    for i=1:length(s)
        for j=1:length(s(i).name)
            try
                allP = zeros(length(s),1);
                allVol = zeros(length(s),1);
                allMass = zeros(length(s),1);
                for k=1:length(s)
                    allP(k) = s(k).P{j};
                    allVol(k) = s(k).Vol{j};
                    allMass(k) = s(k).Mass{j};
                end
                s(i).nP{j} = s(i).P{j}./mean(allP);
                s(i).nVol{j} = s(i).Vol{j}./mean(allVol);
                s(i).nMass{j} = s(i).Mass{j}./mean(allMass);
            catch
                s(i).nP{j} = [];
                s(i).nVol{j} = [];
                s(i).nMass{j} = [];
            end
                
    %         s(i).nP{j} = s(i).P{j}./s(5).P{j};
    %         s(i).nVol{j} = s(i).Vol{j}./s(5).Vol{j};
    %         s(i).nMass{j} = s(i).Mass{j}./s(5).Mass{j};
        end
    end
end