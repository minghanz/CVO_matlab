clearvars

opt.p_shape = 'step'; % 'sin', 'step', 'line'
opt.p_density = 5;
opt.feat_func = 'sin'; % 'sin', 'const'
opt.feat_prod = 'rbf'; % 'dot' 'rbf'

%% create 2D point cloud
[xy1, xy2_, f1_, f2_] = generate_pcd(opt); % options 1,2,3
figure(3)
plot(xy1(1,:), f1_);
hold on
plot(xy2_(1,:), f2_);
hold off
%% calculate the function corresponding to a point cloud
to_min = 'dist'; %'dist' or 'inner_prod'
l = 0.3;
n_change = 5;
step = 0.1;
prods = zeros(1,n_change);
prods1 = prods;
prods2 = prods;

changes = zeros(1,n_change);
for i = 1:n_change
    changes(i) = ( i-(n_change+1)/2 )*step;
    xy2 = xy2_;
    xy2(1,:) =xy2(1,:) -0.000;
    xy2(2,:) =xy2(2,:) + changes(i);
    [prods(i), grad2, grad_pose12] = inner_prod(xy1, xy2, l, f1_, f2_, opt);
    [prods1(i), ~, ~] = inner_prod(xy1, xy1, l, f1_, f1_, opt);
    [prods2(i), grad2_self, ~] = inner_prod(xy2, xy2, l, f2_, f2_, opt);
    grad2_dist = grad2 - grad2_self;
    
    figure(1);
    plot(xy1(1,:), xy1(2,:));%,'bx');
    hold on;
    plot(xy2(1,:), xy2(2,:));%, 'ro');
    if to_min == 'dist'
        arrow(xy2', (xy2 + grad2_dist*0.2)'); % arrow([x1, y1],[x2,y2])
    elseif to_min == 'inner_prod'
        arrow(xy2', (xy2 + grad2*0.2)');
    else
        disp('Not recognized');
    end
    arrow([0,0], grad_pose12'/norm(grad_pose12), 'Color' ,'r');
%     arrow([0,0], grad_pose12', 'Color' ,'r');
    hold off;
    title(sprintf(' %f: [%f, %f], \\theta =%f ', changes(i), grad_pose12(1), grad_pose12(2), rad2deg(atan2(grad_pose12(1), grad_pose12(2))) ) ); 
    % Option 'interpreter','latex' added to title will make the whole
    % string in latex style, in this way the \\theta should be $\\theta$
    
    axis equal
    pause(0.1);
end
%% 
func_dist = prods1 + prods2 - 2*prods;
figure(2);
if to_min == 'dist'
    plot(changes, func_dist);
elseif to_min == 'inner_prod'
    plot(changes, prods);
end