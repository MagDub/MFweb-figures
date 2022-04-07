
function [] = plot_param_mod12_Q0(to_del, col_,ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/mod12_Q0.mat')
    load('../../../data_analysis/usermat_completed.mat')
    param = Q0;

    % Remove ID
    param(to_del,:) = nan;

    % Figure

    x_ax = [1];

    noise_plot = (rand(size(usermat_completed,2),1)-0.5);

    b2S = bar(x_ax(1),nanmean(param), 'FaceAlpha', 0.1, 'BarWidth',0.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    
    param = param';
    scatter(x_ax(1)*ones(1,size(param,1))+noise_plot, param', 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.1); hold on;

    [neg_, pos_, mean_] = get_bounds_normal_dist(param');
    h = errorbar(x_ax,...
        mean_,...
        neg_,...
        pos_,...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')
    
%     h = errorbar(x_ax,[nanmean(param)], ...
%         [nanstd(param)./sqrt(size(param,2))],'.','color',col_(2,:),'LineWidth',1.2);
%     set(h,'Marker','none')

    xlim([x_ax(1)-0.75 x_ax(1)+0.75])   
    set(gca,'XTick',[mean(x_ax)])
    set(gca,'XTickLabel',{''});
    set(gca,'box','off')

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)
    
    % Title and letter
    text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(['\fontsize{18} Prior mean Q_0'],'interpreter','tex','Fontweight','normal','FontName','Arial');

end
