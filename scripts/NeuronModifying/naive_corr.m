function [N] = naive_corr(pat,img)

[n,m] = size(img);
[np,mp] = size(pat);

 N = zeros(n-np+1,m-mp+1);

 for i = 1:n-np+1
    for j = 1:m-mp+1
        N(i,j) = sum(dot(pat,img(i:i+np-1,j:j+mp-1)));
    end
 end

end