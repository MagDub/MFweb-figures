
function [] = plot_novel_value(to_del, col_, ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/pickedC_SH.mat')
    load('../../../data/data_for_figs/pickedC_LH.mat')
    load('../../../data_analysis/usermat_completed.mat') 

    % Remove ID
    pickedC_SH(to_del,:) = [];
    pickedC_LH(to_del,:) = [];

    % Figure
    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/3;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(pickedC_SH), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    % Long horizon
    b2L = bar(x_ax(6),nanmean(pickedC_LH), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    for n = 1:size(pickedC_SH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedC_SH(n) pickedC_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.1];
    end

    % error bar
%     h = errorbar(x_ax([3 6]),[nanmean(pickedC_SH) nanmean(pickedC_LH)], ...
%         [nanstd(pickedC_SH)./sqrt(size(pickedC_SH,1)) nanstd(pickedC_LH)./sqrt(size(pickedC_SH,1))],'.','color','k');
%     set(h,'Marker','none')

    [neg_SH, pos_SH, mean_SH] = get_bounds_binomial_dist(pickedC_SH);
    [neg_LH, pos_LH, mean_LH] = get_bounds_binomial_dist(pickedC_LH);
    h = errorbar(x_ax([3 6]),...
        [mean_SH mean_LH],...
        [neg_SH neg_LH],...
        [pos_SH pos_LH],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')
    
    %
    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};
    set(gca,'box','off')

    ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)
    
    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    
    % Title and letter
    text(0-0.2, 1+0.2,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Novel bandit ','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end