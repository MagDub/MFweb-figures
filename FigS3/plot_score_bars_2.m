function [b1S] = plot_score_bars_2(score_SH, score_LH, x_locations, x_ax, transp_)

    % Figure
    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines
        
    noise_plot = (rand(size(score_SH,1),1)-0.5)/5;
    
    % SH
    b1S= bar(x_ax(x_locations(1)),nanmean(score_SH), 'FaceAlpha', transp_, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    % LH
    b1L = bar(x_ax(x_locations(2)),nanmean(score_LH), 'FaceAlpha', transp_, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    for n = 1:size(score_LH,1)
        scatter(x_ax(x_locations(1))+noise_plot(n), score_SH(n), 3, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        scatter(x_ax(x_locations(2))+noise_plot(n), score_LH(n), 3, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        lin2 = plot(x_ax([x_locations(1:2)])+noise_plot(n),[score_SH(n) score_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.02]; % transparency
    end
    
    
    % CI
    [neg_SH, pos_SH, mean_SH] = get_bounds_normal_dist(score_SH);
    [neg_LH, pos_LH, mean_LH] = get_bounds_normal_dist(score_LH);

    h = errorbar(x_ax([x_locations]),...
        [mean_SH mean_LH],...
        [neg_SH neg_LH],...
        [pos_SH pos_LH],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')


end