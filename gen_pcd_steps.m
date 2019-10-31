function [x1, y1] = gen_pcd_steps(n_pt, x0, y0, seg_w, k)
% For generating 2d point cloud of shape
%     ___     ___
% ___|   |___|   |___

% steps
inc = 0.1;
x1 = zeros(1, n_pt);
y1 = zeros(1, n_pt);
x1(1) = x0 + k*inc;
y1(1) = y0;
i = 2;
k = k + 2;
i_cycle = 1;
while i <= n_pt
    switch mod(i_cycle, 4)
        case 1
            x1(i) = x1(i-1) + inc;
            y1(i) = y1(i-1);
        case 2
            x1(i) = x1(i-1);
            y1(i) = y1(i-1) + inc;
        case 3
            x1(i) = x1(i-1) + inc;
            y1(i) = y1(i-1);
        case 0
            x1(i) = x1(i-1);
            y1(i) = y1(i-1) - inc;
    end

    if mod(k, seg_w) == 0
        i_cycle = i_cycle + 1;
    end
    i = i + 1;
    k = k + 1;
end