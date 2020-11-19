function [] = render_score_LH_RT()

    load('../../../data_analysis/usermat_completed.mat') 
    load('../../../data/data_for_figs/RT_all_LH_desc.mat')
    load('../../../data/data_for_figs/RT_all_LH.mat')
    
    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    RT_all_LH(to_del,:) = nan;
    n = size(RT_all_LH,1)-size(to_del,2);

    % Figure
    col(1,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; % indiv lines
    col(2,:) = [0.20392157137394 0.301960796117783 0.494117647409439]; % mean

    noise_plot = (rand(size(RT_all_LH,1),1)-0.5)/5;

    plot([1:6],nanmean(RT_all_LH,1),'LineWidth',1, 'Color',[col(2,:) 1]); hold on;

    errorbar([1:6],[nanmean(RT_all_LH)],[nanstd(RT_all_LH)./sqrt(n)],'.','color','k');

    plot(1*ones(1,60)+noise_plot, RT_all_LH(:,1),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3); hold on;
    plot(2*ones(1,60)+noise_plot, RT_all_LH(:,2),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3); hold on;
    plot(3*ones(1,60)+noise_plot, RT_all_LH(:,3),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3); hold on;
    plot(4*ones(1,60)+noise_plot, RT_all_LH(:,4),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3); hold on;
    plot(5*ones(1,60)+noise_plot, RT_all_LH(:,5),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3); hold on;
    plot(6*ones(1,60)+noise_plot, RT_all_LH(:,6),'.','MarkerEdgeColor',col(1,:), 'MarkerSize',3);

    ylim([0 4700])
    xlim([0 7])
    set(gca,'YTick',0:1000:10000)
    set(gca,'XTick',1:6)
    ylabel({'Time (ms)'}','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('Draw','FontName','Arial','Fontweight','bold','FontSize',12);
    
    set(gca,'box','off')

    % Number and title
    text(0-0.2, 1+0.2,'','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Long horizon reaction times','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end

