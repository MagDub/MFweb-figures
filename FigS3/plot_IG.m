
function [] = plot_IG(to_del, col_, ybounds, increment, signif, hight_signif)

    load('../../data_analysis/usermat_completed.mat')
    data_fold = ('../../data/');
    numel = size(usermat_completed,2);

    load(strcat(data_fold, 'data_for_figs/IS_SH_mat.mat'))
    load(strcat(data_fold, 'data_for_figs/IS_LH_mat.mat'))

    % Remove ID
    IS_SH_mat(to_del,:) = nan;
    IS_LH_mat(to_del,:) = nan;

    % Figure
    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(IS_SH_mat), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    % first LH
    b1Lf = bar(x_ax(6),nanmean(IS_LH_mat), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    for n = 1:size(IS_LH_mat,1)
        scatter(x_ax(3)+noise_plot(n), IS_SH_mat(n), 5, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        scatter(x_ax(6)+noise_plot(n), IS_LH_mat(n), 5, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        lin2 = plot(x_ax([3 6])+noise_plot(n),[IS_SH_mat(n) IS_LH_mat(n)]); hold on;
        lin2.Color = [col_(2,:) 0.1]; % transparency
    end

    % CI
    [neg_SH, pos_SH, mean_SH] = get_bounds_normal_dist(IS_SH_mat);
    [neg_LH, pos_LH, mean_LH] = get_bounds_normal_dist(IS_LH_mat);
    h = errorbar(x_ax([3 6]),...
        [mean_SH mean_LH],...
        [neg_SH neg_LH],...
        [pos_SH pos_LH],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')
    
%     h = errorbar(x_ax([3 6])+noise_plot(n),...
%         [nanmean(IS_SH_mat) nanmean(IS_LH_mat)], ...
%         [nanstd(IS_SH_mat)./sqrt(numel) nanstd(IS_LH_mat)./sqrt(numel)],'.','color',col_(2,:),'LineWidth',2);

    set(h,'Marker','none')

    xlim([0 2.8])   
    set(gca,'XTick',[x_ax(3) x_ax(6)])

    labels = {'Short horizon', 'Long horizon'};

    a = gca;
    a.XTickLabel = labels;
    set(gca,'box','off')

    ylabel({'Number of initial samples','of chosen bandit'},'FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:3)
    ylim(ybounds)
    
    % Title and letter
    text(0-0.2, 1+0.2,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Information seeking','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');


end

