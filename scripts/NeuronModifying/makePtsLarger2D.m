%takes in a 4 vector and broadens it's points to a diameter of D pixels
%D should be an odd number
function W = makePtsLarger2D(V,D)
    C = ones(D,D);%make a cube the size of the diameter
    ind = find(C); %find the indices
    [I,J] = ind2sub(size(C),ind); %convert those to postions
    M = [I-ceil(D/2),J-ceil(D/2),ones(length(I),1)]';%shifts the matrix over
    exclude = sqrt(M(1,:).^2+M(2,:).^2); % find elements alrger than our radius
    exclude(exclude > floor(D/2)) = 0; %set thos elements to zero
%     indE = find(exclude==0);
    M(:,exclude == 0)=[]; %find the elements that are equal to zero and elimante them from our 'Ball'
    W = zeros(size(M,2)*size(V,1),3);%initialize our new coordinate vector
    
    for i=1:size(V,1) %loop over original coordinates
%         T = makehgtform('translate',[V(i,1),V(i,2)]); % make the translation matrix
        T = [1 0 0; 0 1 0; V(i,1) V(i,2) 1];
        N = T*M;%Find the points to be added to the matrix
        W(((i-1)*size(M,2)+1):(i*size(M,2)),:) = N';
    end
    W = unique(W,'rows');
    W = W(:,1:2);
end
        