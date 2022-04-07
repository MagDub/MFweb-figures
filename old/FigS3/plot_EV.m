
function [] = plot_EV(col_, ybounds, increment, signif, hight_signif)

    load('../../../data_analysis/usermat_completed.mat')    
    data_fold = ('../../../data/');
    numel = size(usermat_completed,2);

    load(strcat(data_fold, 'data_for_figs/EV_SH_mat.mat'))
    load(strcat(data_fold, 'data_for_figs/EV_LH_mat.mat'))

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    EV_SH_mat(to_del,:) = nan;
    EV_LH_mat(to_del,:) = nan;

    % Figure
    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/3;

    % SH
    bar(x_ax(3),nanmean(EV_SH_mat), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    %b1S= bar(x_ax(3),nanmean(EV_SH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 0.5, 'BarWidth',1); hold on;

    % first LH
    bar(x_ax(6),nanmean(EV_LH_mat), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    %b1Lf = bar(x_ax(6),nanmean(EV_LH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 0.5, 'BarWidth',1);

    for n = 1:size(EV_LH_mat,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[EV_SH_mat(n) EV_LH_mat(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    % CI
    [neg_SH, pos_SH, mean_SH] = get_bounds_normal_dist(EV_SH_mat);
    [neg_LH, pos_LH, mean_LH] = get_bounds_normal_dist(EV_LH_mat);
    h = errorbar(x_ax([3 6]),...
        [mean_SH mean_LH],...
        [neg_SH neg_LH],...
        [pos_SH pos_LH],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')
    
%     h = errorbar(x_ax([3 6]),...
%         [nanmean(EV_SH_mat) nanmean(EV_LH_mat)], ...
%         [nanstd(EV_SH_mat)./sqrt(numel) nanstd(EV_LH_mat)./sqrt(numel)],'.','color',col_(2,:),'LineWidth',2);
%    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};
    set(gca,'box','off')

    ylabel({'Expected value','of chosen bandit'}','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:10)
    ylim(ybounds)
    
    % Title and letter
    text(0-0.2, 1+0.2,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Exploitation','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');

end


