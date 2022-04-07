
function [] = plot_score_exclusion(col_)

    load('../../../data/data_for_figs/score_SH.mat')
    load('../../../data/data_for_figs/score_LH.mat')

    score = (score_SH+score_LH)/2;

    n = size(score,1);

    noise_plot = (rand(1,n)-0.5);

    % mean
    bar_plot = bar(1,nanmean(score), 'FaceAlpha', 0.2, 'BarWidth',.5, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    % individual dots
    h = scatter(ones(1,n)+noise_plot, score, 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.3); hold on;

    % exclusion line
    ex = plot(-10:10, 5.5*ones(1,21), ':k');

    % legend([ex],{'Exclusion threshold'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
    % legend boxoff  
    
    % CI
    [neg, pos, mean_] = get_bounds_normal_dist(score);
    h = errorbar(1,mean_,...
        neg,pos,'.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

%     % variance
%     h = errorbar(1,[nanmean(score)],...
%         [nanstd(score)./sqrt(n)],'.','color',col_(2,:),'LineWidth',1.2);
%     set(h,'Marker','none')

    % parameters
    xlim([1-0.75 1+0.75])   
    ylim([4.3 max(score)+0.3])
    ylabel({'Value'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xticks('')
    
    set(gca,'box','off')
    
    % Number and title
    text(0-0.2, 1+0.2,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Score','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end