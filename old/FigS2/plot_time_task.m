
function [] = plot_time_task(col_)

    load('../../../data/data_for_figs/sum_dur_4blocks_s.mat')
    load('../../../data_analysis/usermat_completed.mat')  
    
    sum_dur_4blocks_m = sum_dur_4blocks_s/60;

    n = size(sum_dur_4blocks_m,2);

    noise_plot = (rand(1,n)-0.5);

    % mean
    bar_plot = bar(1,nanmean(sum_dur_4blocks_m), 'FaceAlpha', 0.2, 'BarWidth',.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;
    
    disp(nanmean(sum_dur_4blocks_m))
    disp(nanstd(sum_dur_4blocks_m))

    % individual dots
    h = scatter(ones(1,n)+noise_plot, sum_dur_4blocks_m, 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.3); hold on;
    
    % exclusion line
    % ex = plot(-10:10, 1500*ones(1,21), ':k');
    
    % CI
    [neg, pos, mean_] = get_bounds_normal_dist(sum_dur_4blocks_m');
    h = errorbar(1,mean_,...
        neg,pos,'.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

%     % variance
%     h = errorbar(1,[nanmean(sum_dur_4blocks_m)],...
%         [nanstd(sum_dur_4blocks_m)./sqrt(n)],'.','color',col_(2,:),'LineWidth',1.2);
%     set(h,'Marker','none')

    % parameters
    xlim([1-0.75 1+0.75])   
    set(gca,'YTick',0:30:100)
    ylim([0 98])
    ylabel({'Time (min)'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xticks('')
    
    set(gca,'box','off')
    
    % Number and title
    text(0-0.2, 1+0.2,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Total duration','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end