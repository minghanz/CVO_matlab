function [pcd1, pcd2, f1, f2] = generate_pcd(opt)

if strcmp(opt.p_shape, 'line')
    % piecewise line
    x1 = 1:100;
    y1 = zeros(1, 100);
    for i = 1:2:10
        y1(10*(i-1)+1:10*i) = 10;
    end
    x2 = x1;
    y2 = y1;
elseif strcmp(opt.p_shape, 'sin')
    % sin wave
    x1 = 1:100;
    y1 = sin(x1);
    x2 = x1;
    y2 = y1;
elseif strcmp(opt.p_shape, 'step')
    % steps
    seg_w1 = 20;
    inc1 = 2/seg_w1;
    n_pt1 = seg_w1 * 10;
    k1 = 0;
    [x1, y1, f1] = gen_pcd_steps(n_pt1, inc1, seg_w1, k1, 0, 0, opt);
    seg_w2 = opt.p_density;
    inc2 = 2/seg_w2;
    n_pt2 = seg_w2 * 10;
    k2 = 2;
    [x2, y2, f2] = gen_pcd_steps(n_pt2, inc2, seg_w2, k2, 0, 0, opt);
end

pcd1 = [x1; y1]; % 2*N
pcd2 = [x2; y2];