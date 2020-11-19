
function [] = plot_RT_exclusion()

    load('../../../data/data_for_figs/task_RT_1st_in_sec.mat')

    task_RT_1st_in_ms = task_RT_1st_in_sec*1000;

    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; 

    n = size(task_RT_1st_in_ms,2);

    noise_plot = (rand(1,n)-0.5)/5;

    % mean
    bar_plot = bar(1,nanmean(task_RT_1st_in_ms), 'FaceAlpha', 1, 'BarWidth',.5, 'FaceColor',col_(1,:)); hold on;

    % individual dots
    plot(ones(1,n)+noise_plot, task_RT_1st_in_ms,'.','MarkerSize',5,'MarkerEdgeColor',col_(2,:)); hold on;

    % exclusion line
    ex = plot(-10:10, 1500*ones(1,21), ':k');

    % legend([ex],{'Exclusion threshold'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
    % legend boxoff  

    % variance
    h = errorbar(1,[nanmean(task_RT_1st_in_ms)],...
        [nanstd(task_RT_1st_in_ms)./sqrt(n)],'.','color','k');
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