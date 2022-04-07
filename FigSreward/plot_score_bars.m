function [b1S] = plot_score_bars(score_SH, first_LH, score_LH, x_locations, x_ax, transp_)

    % Figure
    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines
        
    noise_plot = (rand(size(score_SH,1),1)-0.5)/5;
    
    % SH
    b1S= bar(x_ax(x_locations(1)),nanmean(score_SH), 'FaceAlpha', transp_, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    % first LH
    b1Lf = bar(x_ax(x_locations(2)),nanmean(first_LH), 'FaceAlpha', transp_, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    % LH
    b1L = bar(x_ax(x_locations(3)),nanmean(score_LH), 'FaceAlpha', transp_, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([x_locations(1:2)])+noise_plot(n),[score_SH(n) first_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.02]; % transparency
    end
    
    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([x_locations(2:3)])+noise_plot(n),[first_LH(n) score_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.02]; % transparency
    end
    
    % CI
    [neg_SH, pos_SH, mean_SH] = get_bounds_normal_dist(score_SH);
    [neg_LH_1, pos_LH_1, mean_LH_1] = get_bounds_normal_dist(first_LH);
    [neg_LH_all, pos_LH_all, mean_LH_all] = get_bounds_normal_dist(score_LH);
    h = errorbar(x_ax([x_locations]),...
        [mean_SH mean_LH_1 mean_LH_all],...
        [neg_SH neg_LH_1 neg_LH_all],...
        [pos_SH pos_LH_1 pos_LH_all],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')


end