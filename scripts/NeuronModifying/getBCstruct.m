%gets the box count struct from a cell array of all neurons of a particular
%curvature


function s = getBCstruct(BC)
   s(size(BC,1)/100) = struct();
    for i=1:size(BC,1)/100
    s(i).name = BC{((i-1)*100+1),1}(1:end);
    s(i).Curvature = str2double(char(insertAfter(extractAfter(s(i).name,"Full"),1,".")));
    s(i).name = char(extractBefore(s(i).name,"Full"));
        for j=1:100
            s(i).res(j) = BC{(i-1)*100+j,2};
            s(i).L(j) = BC{(i-1)*100+j,3};
            s(i).N(j) = BC{(i-1)*100+j,4};
        end
    end
end
