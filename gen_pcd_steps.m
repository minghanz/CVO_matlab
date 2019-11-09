function [x1, y1, f1] = gen_pcd_steps(n_pt, inc, seg_w, k, x0, y0, opt)
% For generating 2d point cloud of shape
%     ___     ___
% ___|   |___|   |___

% steps
% inc = 0.1;
x1 = zeros(1, n_pt);
y1 = zeros(1, n_pt);
f1 = zeros(1, n_pt);
i = 1;
k = i + k;
x1(i) = x0 + k*inc;
y1(i) = y0;
f1(i) = f(k);
i = i+1;
k = k+1;
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
    
    f1(i) = f(k);
    
    i = i + 1;
    k = k + 1;
end

function fi = f(k)
    if strcmp(opt.feat_func, 'sin')
        fi = (sin(inc*k)+1)/2;
    elseif strcmp(opt.feat_func, 'const')
        fi = 1;
    elseif strcmp(opt.feat_func, 'corner')
        if mod(k, seg_w) >= seg_w - 2 
            fi = 1;
        elseif mod(k, seg_w) <= 2
            fi = -1;
        end
    end
end
end
