function [prod, grad2_vec] = inner_prod(xy1, xy2, l)
% 2*n1, 2*n2
num1 = size(xy1, 2);
num2 = size(xy2, 2);
dim = size(xy1, 1);

%% every kernal term and every gradient term
k = zeros(num1, num2);
grad2 = zeros(num1, num2, dim);
f_d = @(d)exp(-d^2/(2*l^2));
f_x = @(x1, x2)f_d(norm(x1-x2));
for i = 1:num1
    for j = 1:num2
        k(i,j) = f_x(xy1(:,i), xy2(:,j));
        grad2(i,j,:) = xy1(:,i) - xy2(:,j);
    end
end
prod = sum(sum(k));

%% gradient term sum for each point
grad2_vec = zeros(dim, num2);
for j = 1:num2
    for i = 1:num1
        s = squeeze(grad2_vec(:, j) ) + squeeze(grad2(i,j,:) * k(i,j) );
        grad2_vec(:, j) = s;
    end
end
return