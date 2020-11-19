
function [] = plot_time()

    load('../../../data/data_for_figs/time_interval_in_hours.mat')
    load('../../../data_analysis/usermat_completed.mat')  

    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; 

    n = size(time_interval_in_hours,2);

    noise_plot = (rand(1,n)-0.5)/5;

    % mean
    bar_plot = bar(1,nanmean(time_interval_in_hours), 'FaceAlpha', 1, 'BarWidth',.5, 'FaceColor',col_(1,:)); hold on;
    
    disp(nanmean(time_interval_in_hours))
    disp(nanstd(time_interval_in_hours))

    % individual dots
    plot(ones(1,n)+noise_plot, time_interval_in_hours,'.','MarkerSize',5,'MarkerEdgeColor',col_(2,:)); hold on;

    % exclusion line
    %ex = plot(-10:10, 1500*ones(1,21), ':k');

    % variance
    h = errorbar(1,[nanmean(time_interval_in_hours)],...
        [nanstd(time_interval_in_hours)./sqrt(n)],'.','color','k');
    set(h,'Marker','none')

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