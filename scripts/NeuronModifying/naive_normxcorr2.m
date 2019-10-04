function [NCC]  = naive_normxcorr2(temp,img)

    [n_p,m_p]=size(temp);

    M = n_p*m_p;

    % compute template mean & std
    temp_mean = mean(temp(:));
    temp = temp - temp_mean;

    temp_std = sqrt(sum(temp(:).^2)/M);

    % compute windows' mean & std
    wins_mean =  box_corr2(img,[1,n_p,1,m_p],1/M,  n_p,m_p);
    wins_mean2 = box_corr2(img.^2,[1,n_p,1,m_p],1/M,n_p,m_p);


    wins_std = real(sqrt(wins_mean2 - wins_mean.^2));
    NCC_naive = naive_corr(temp,img);

    NCC = NCC_naive ./ (M .* temp_std .* wins_std);
end 