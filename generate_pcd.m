function [pcd1, pcd2] = generate_pcd()
x1 = 1:100;
x2 = 1:100;
% piecewise line
y1 = zeros(1, 100);
for i = 1:2:10
    y1(10*(i-1)+1:10*i) = 10;
end

% % sin wave
% y1 = sin(x1);

y2 = y1;
pcd1 = [x1; y1]; % 2*N
pcd2 = [x2; y2];