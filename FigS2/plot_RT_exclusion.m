
function [] = plot_RT_exclusion(col_)

    load('../../data/data_for_figs/task_RT_1st_in_sec.mat')

    task_RT_1st_in_ms = task_RT_1st_in_sec*1000;

    n = size(task_RT_1st_in_ms,2);

    noise_plot = normrnd(0,1,[1,n])/10;


    % mean
    bar_plot = bar(1,nanmean(task_RT_1st_in_ms), 'FaceAlpha', 0.2, 'BarWidth',.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',0.5); hold on;

    % individual dots
    h = scatter(ones(1,n)+noise_plot, task_RT_1st_in_ms, 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.1); hold on;

    % exclusion line
    ex = plot(-10:10, 1500*ones(1,21), ':k');

    % legend([ex],{'Exclusion threshold'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
    % legend boxoff  

    % variance
    h = errorbar(1,[nanmean(task_RT_1st_in_ms)],...
        [nanstd(task_RT_1st_in_ms)./sqrt(n)],'.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

    % parameters
    xlim([1-0.75 1+0.75])   
    ylim([500 5500])
    ylabel({'Time (ms)'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xticks('')
    
    set(gca,'box','off')
    
    % Number and title
    text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Reaction time','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end