
function [] = plot_time(col_)

    load('../../../data/data_for_figs/time_interval_in_hours.mat')
    load('../../../data_analysis/usermat_completed.mat')  

    n = size(time_interval_in_hours,2);

    noise_plot = (rand(1,n)-0.5);

    % mean
    bar_plot = bar(1,nanmean(time_interval_in_hours), 'FaceAlpha', 0.2, 'BarWidth',.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;
    
    disp(nanmean(time_interval_in_hours))
    disp(nanstd(time_interval_in_hours))

    % individual dots
    h = scatter(ones(1,n)+noise_plot, time_interval_in_hours, 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.3); hold on;

    % exclusion line
    %ex = plot(-10:10, 1500*ones(1,21), ':k');
    
    % CI
    [neg, pos, mean_] = get_bounds_normal_dist(time_interval_in_hours);
    h = errorbar(1,mean_,...
        neg,pos,'.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

%     % variance
%     h = errorbar(1,[nanmean(time_interval_in_hours)],...
%         [nanstd(time_interval_in_hours)./sqrt(n)],'.','color',col_(2,:),'LineWidth',1.2);
%     set(h,'Marker','none')

    % parameters
    xlim([1-0.75 1+0.75])   
    ylim([0 2.5])
    ylabel({'Time (hours)'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xticks('')
    
    set(gca,'box','off')
    
    % Number and title
    text(0-0.2, 1+0.2,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Total duration','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end