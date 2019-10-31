%% create 2D point cloud
[xy1, xy2_] = generate_pcd();
%% calculate the function corresponding to a point cloud
l = 1;
n_pt = 60;
prods = zeros(1,n_pt);
changes = zeros(1,n_pt);
for i = 1:n_pt
    changes(i) = i*0.1-3;
    xy2 = xy2_;
%     xy2(1,:) =xy2(1,:) + changes(i);
    xy2(2,:) =xy2(2,:) + changes(i);
    [prods(i), grad2] = inner_prod(xy1, xy2, l);
    
    figure(1);
    plot(xy1(1,:), xy1(2,:));%,'bx');
    hold on;
    plot(xy2(1,:), xy2(2,:));%, 'ro');
%     hold on;
%     quiver(xy2(1,:), xy2(2,:), grad2(1,:), grad2(2,:));
    arrow(xy2', (xy2 + grad2*1e1)');
    hold off;
    pause(0.1);
end
%% 
figure(2);
plot(changes, prods);