%gets the box count struct from a cell array of all neurons of a particular
%curvature


function s = getBCstructIndividual(BC)
    s.name = BC{1,1};
    for j=1:size(BC,1)
            s.res(j) = BC{j,2};
            s.L(j) = BC{j,3};
            s.N(j) = BC{j,4};
    end
end
