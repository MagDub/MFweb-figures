
function [] = render_model_comparison_BIC(col_, letter, subplot_title)

    load('../../../data/data_for_figs/mle_mat_all.mat');
    load('../../../data_analysis/usermat_completed.mat')

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    mle_mat_all(to_del,:) = nan;

    BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12]; %mle is NLL

    mean_all = nanmean(BIC_all,1);
    n_part = sum(~isnan(BIC_all));
    stderror_all = nanstd(BIC_all,1)./n_part;

    % Legend
    legend_all{1} = 'thompson';
    legend_all{2} = 'thompson + \epsilon';
    legend_all{3} = 'thompson + \eta';
    legend_all{4} = 'thompson + \epsilon + \eta';

    legend_all{5} = 'UCB';
    legend_all{6} = 'UCB + \epsilon';
    legend_all{7} = 'UCB + \eta';
    legend_all{8} = 'UCB + \epsilon + \eta';

    legend_all{9} = 'hybrid';
    legend_all{10} = 'hybrid + \epsilon';
    legend_all{11} = 'hybrid + \eta';
    legend_all{12} = 'hybrid + \epsilon + \eta';

    % Figure
    x = [1:3 5:7 9:11 13:15];

    I = [1,5,9, ... % plain
            2,6,10, ... % + epsilon
                3,7,11, ... % + eta
                    4,8,12]; % + epsilon + eta

    % plot
    bar(x,mean_all(I), 'FaceAlpha', 0.2, 'BarWidth',.7, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;
    
    % best model
    [~, ind_best] = min(mean_all(I));
    bw = bar(x(ind_best),mean_all(I(ind_best)), 'FaceAlpha', 0.8, 'BarWidth',.7,'FaceColor',col_(2,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;
    legend([bw],{'Winning model'}, 'Location','NorthEast');
    legend boxoff  

    er = errorbar(x,mean_all(I),stderror_all(I),stderror_all(I),'.','color',col_(2,:),'LineWidth',1.2); set(er,'Marker','none')                            
    er.LineStyle = 'none';  
    ylabel('BIC score','FontName','Arial','Fontweight','bold','FontSize',11);
    yrange = [510 595];
    ylim(yrange)
    xticks(x)
    xlim([0 x(end)+1])
    xticklabels(legend_all(I));
    xtickangle(45)
    set(gca,'YTick',0:20:1000);
    box off;

    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end