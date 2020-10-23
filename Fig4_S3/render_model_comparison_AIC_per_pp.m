
function [] = render_model_comparison_AIC_per_pp(letter, subplot_title)

    load('../../data/data_for_figs/mle_mat_all.mat');

    n_model = size(mle_mat_all,2);

    mle_mat_all(4,:) = nan(1,n_model);
    mle_mat_all(32,:) = nan(1,n_model);
    mle_mat_all(36,:) = nan(1,n_model);

    AIC_all = 2/log(400)*mle_mat_all + 2*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12] ./log(400); %mle is NLL

    [highest_acc_pp,best_model_ind_pp] = min(AIC_all,[],2);
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

    % figure
    col_(1,:) = [0.729411780834198 0.831372559070587 0.95686274766922];
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x = 1:n_model+2;
    x =[x(1:1+3), x(6:6+3) x(11:11+3)];

    b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

    txt_val = val';
    ind_notnul = find(val~=0);

    text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
    box off

    ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
    set(gca,'YTick',0:10:100)
    ylim([0  45])

    xticks(1:n_model+2);
    xticklabels([legend_all(1:1+3),{''}, legend_all(5:5+3),{''},legend_all(9:9+3)]);
    xlim([0,n_model+3])

    xtickangle(45)
    
    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end