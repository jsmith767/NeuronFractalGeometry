% pad a 1-D array with nan
function A = padNAN(A,size)
    for i=size:-1:length(A)+1
        A(i) = nan;
    end
    
end
