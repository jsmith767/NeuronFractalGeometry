%rescaleNeuron
%rescales neuron by a factor but keeps the arbor width the same at each
%point.  Achieve this by applying the rescaling factor and then translating
%the ring points to the new location of the point. R is the factor which we
%scale the neuron by 
function [Vscaled, VAllscaled] = rescaleNeuron(V,VAll,R)
    Vscaled = cellfun(@(V) V.*R, V,'UniformOutput', false);%scales the neuron
    %skeleton by an appropiate factor R
%     Vscaled{1} = R*V{1};
    VAllscaled = cell(1,length(VAll));%finds the number of sub-branches
    for k=1:length(VAllscaled)%iterates through those sub-branches
        for i = 0:(size(V{k},1)-1)%iterates through the vertices of that sub-brnach
                j = (i*16)+1:((i+1)*16);
                VAllscaled{k}(j,1)= VAll{k}(j,1)+V{k}(i+1,1)*(R-1);
                VAllscaled{k}(j,2)= VAll{k}(j,2)+V{k}(i+1,2)*(R-1);
                VAllscaled{k}(j,3)= VAll{k}(j,3)+V{k}(i+1,3)*(R-1);
        end
    end
end