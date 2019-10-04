


%w_arr the array of coefficients for the boxes
%box_arr of size [k,4] where k is the number boxes, each box represented by
%4 something ... 
function [C] = box_corr2(img,box_arr,w_arr,n_p,m_p)

% construct integral image + zeros pad (for boundary problems)
I = cumsum(cumsum(img,2),1);
I = [zeros(1,size(I,2)+2); [zeros(size(I,1),1) I zeros(size(I,1),1)]; zeros(1,size(I,2)+2)];

% initialize result matrix
[n,m] = size(img);
C = zeros(n-n_p+1,m-m_p+1);
%C = zeros(n,m);

jump_x = 1;
jump_y = 1;

x_start = ceil(n_p/2);
x_end = n-x_start+mod(n_p,2);
x_span = x_start:jump_x:x_end;

y_start = ceil(m_p/2);
y_end = m-y_start+mod(m_p,2);
y_span = y_start:jump_y:y_end;

arr_a = box_arr(:,1) - x_start;
arr_b = box_arr(:,2) - x_start+1;
arr_c = box_arr(:,3) - y_start;
arr_d = box_arr(:,4) - y_start+1;

% cumulate box responses
k = size(box_arr,1); % == numel(w_arr)
for i = 1:k
    a = arr_a(i);
    b = arr_b(i);
    c = arr_c(i);
    d = arr_d(i);

    C = C ...
        + w_arr(i) * ( I(x_span+b,y_span+d) ...
                       - I(x_span+b,y_span+c) ...
                       - I(x_span+a,y_span+d) ...
                       + I(x_span+a,y_span+c) );
end

end