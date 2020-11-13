
function [] = plot_model_comparison_AIC_per_pp_extended_B(letter, subplot_title)

    load('../../../data/data_for_figs/mle_mat_all_extended.mat')
    
    mle_mat_all(:,[6,8]) = []; % rm per trial

    n_model = size(mle_mat_all,2);

    mle_mat_all(4,:) = nan(1,n_model);
    mle_mat_all(32,:) = nan(1,n_model);
    mle_mat_all(36,:) = nan(1,n_model);
    
    AIC_all = 2*mle_mat_all + 2*[3, 5, 5, 7,    9, 9]; %mle is NLL

    [highest_acc_pp,best_model_ind_pp] = min(AIC_all,[],2);
    [val]=hist(best_model_ind_pp,1:1:n_model);

    % Legend
    legend_all{1} = 'thompson';
    legend_all{2} = 'thompson + \epsilon'; 
    legend_all{3} = 'thompson + \eta';
    legend_all{4} = 'thompson + \eta + \epsilon'; 
    legend_all{5} = 'thompson + \eta + \eta_B + \epsilon';
    legend_all{6} = 'thompson + \eta + \epsilon + \epsilon_B' ;

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; 

    x = [1:6];

    b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;
    
    % best model
    [~, ind_best] = max(val);
    bw = bar(x(ind_best),val(ind_best),'FaceColor',col_(2,:), 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
    legend([bw],{'Winning model'}, 'Location','NorthWest');
    legend boxoff  

    txt_val = val';
    ind_notnul = find(val~=0);

    text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
    box off

    ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
    set(gca,'YTick',0:10:100)
    ylim([0  42])

    xticks(x);
    xticklabels([legend_all(1:6)]);
    xlim([0,n_model+1])

    xtickangle(45)
    
    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');
    
end