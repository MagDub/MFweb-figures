function [] = plot_bar(meas_1, meas_2, y_label_)

    x_ax = 0:0.4:4;

    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

    bar(x_ax(3), mean(meas_1), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;
    bar(x_ax(6), mean(meas_2), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5);

    [neg_1, pos_1, mean_1] = get_bounds_binomial_dist(meas_1);
    [neg_2, pos_2, mean_2] = get_bounds_binomial_dist(meas_2);
    h = errorbar(x_ax([3 6]),...
        [mean_1 mean_2],...
        [neg_1 neg_2],...
        [pos_1 pos_2],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {strcat(32,32,32,32,32,32,'Low \newline','anxious-dep'), strcat(32,32,32,32,32,32,'High \newline','anxious-dep')};
    set(gca,'box','off')

    ylabel(y_label_,'FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',2:2:10)
    ylim([3 10])

end

