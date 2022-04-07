
function [] = plot_low_value_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_)

    % Data
    load('../../data/data_for_figs/pickedD_SH.mat')
    load('../../data/data_for_figs/pickedD_LH.mat')
    load('../../data_analysis/usermat_completed.mat') 

    % Remove ID
    pickedD_SH(to_del,:) = [];
    pickedD_LH(to_del,:) = [];

    % Figure
    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/3;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(pickedD_SH), 'FaceAlpha', 0.01, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    % Long horizon
    b2L = bar(x_ax(6),nanmean(pickedD_LH), 'FaceAlpha', 0.3, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    for n = 1:size(pickedD_SH,1)
        scatter(x_ax(3)+noise_plot(n), pickedD_SH(n), 3, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        scatter(x_ax(6)+noise_plot(n), pickedD_LH(n), 3, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.09); hold on;
        lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedD_SH(n) pickedD_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.03];
    end

%     %error bar
%     h = errorbar(x_ax([3 6]),[nanmean(pickedD_SH) nanmean(pickedD_LH)], ...
%         [nanstd(pickedD_SH)./sqrt(size(pickedD_SH,1)) nanstd(pickedD_LH)./sqrt(size(pickedD_SH,1))],'.','color','k');
%     set(h,'Marker','none')

    [neg_SH, pos_SH, mean_SH] = get_bounds_binomial_dist(pickedD_SH);
    [neg_LH, pos_LH, mean_LH] = get_bounds_binomial_dist(pickedD_LH);
    h = errorbar(x_ax([3 6]),...
        [mean_SH mean_LH],...
        [neg_SH neg_LH],...
        [pos_SH pos_LH],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

    set(gca,'box','off')

    xlim([0 2.8])
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])

    xlabel(x_tick_,'FontName','Arial','Fontweight','normal','FontSize',12);
    %ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)

    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    
    % Title and letter
    %text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    %t=title('Low-value bandit ','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
    legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'Location', 'NorthOutside');
    legend boxoff;

end