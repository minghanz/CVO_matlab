function [pcd1, pcd2, f1, f2] = generate_pcd(opt)

if opt == 1
    % piecewise line
    x1 = 1:100;
    y1 = zeros(1, 100);
    for i = 1:2:10
        y1(10*(i-1)+1:10*i) = 10;
    end
    x2 = x1;
    y2 = y1;
elseif opt == 2
    % sin wave
    x1 = 1:100;
    y1 = sin(x1);
    x2 = x1;
    y2 = y1;
elseif opt == 3
    % steps
    n_pt = 200;
    seg_w = 20;
    k = 0;
    [x1, y1, f1] = gen_pcd_steps(n_pt, 0, 0, seg_w, k);
    k = 10;
    [x2, y2, f2] = gen_pcd_steps(n_pt, 0, 0, seg_w, k);
end

pcd1 = [x1; y1]; % 2*N
pcd2 = [x2; y2];