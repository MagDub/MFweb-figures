
function [] = render_model_comparison_BIC_per_pp_g1(col_, letter, subplot_title)

    load('../../../data/data_for_figs/mle_mat_all_g1.mat');    
    load('../../../data_analysis/usermat_completed.mat')
    n_model = size(mle_mat_all,2);

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    mle_mat_all(to_del,:) = nan;

    BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12,      3, 5, 5, 7]; %mle is NLL

    [highest_acc_pp,best_model_ind_pp] = min(BIC_all,[],2);
    [val]=hist(best_model_ind_pp,1:1:n_model);
    
    
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
    
    legend_all{13} = 'UCB (\gamma=1)';
    legend_all{14} = 'UCB (\gamma=1) + \epsilon';
    legend_all{15} = 'UCB (\gamma=1) + \eta';
    legend_all{16} = 'UCB (\gamma=1) + \epsilon + \eta';

    % Figure
    x = [1:4 6:9 11:14 16:19];
    
    I = [1,13,5,9, ... % plain
            2,14,6,10, ... % + epsilon
                3,15,7,11, ... % + eta
                    4,16,8,12]; % + epsilon + eta
    val=val(I);

    % plot
    b = bar(x,val, 'FaceAlpha', 0.2, 'BarWidth',.7, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.5); hold on;
    
    % best model
    [~, ind_best] = max(val);
    bw = bar(x(ind_best),val(ind_best), 'FaceAlpha', 0.8, 'BarWidth',.7,'FaceColor',col_(2,:), 'EdgeColor', col_(2,:),'LineWidth',1.5); hold on;
    legend([bw],{'Winning model'}, 'Location','NorthWest');
    legend boxoff  

    txt_val = val';
    ind_notnul = find(val~=0);

    text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
    box off

    ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
    set(gca,'YTick',0:10:100)
    ylim([0  45])

    xticks(x)
    xlim([0 x(end)+1])
    xticklabels(legend_all(I));

    xtickangle(45)

    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end