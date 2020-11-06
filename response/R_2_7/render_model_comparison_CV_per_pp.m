
function [] = render_model_comparison_CV_per_pp(letter, subplot_title)

    load('../../../data/data_for_figs/mod.mat')
    load('../../../data/data_for_figs/mean_all_pp.mat')
    
    all_models = mean_all_pp';

    mean_all_pp(4,:) = nan(1,12);
    mean_all_pp(32,:) = nan(1,12);
    mean_all_pp(36,:) = nan(1,12);

    mean_all = [];

    for model = 1:12

        mod.mean_all{model} = nanmean(mean_all_pp(:,model));
        mod.stderror_all{model} = nanstd(mean_all_pp(:,model)) / sqrt(mod.number_par{model});

        mean_all(model) = mod.mean_all{model};
        stderror_all(model) = mod.stderror_all{model};
    end

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

    col_(1,:) = [0.729411780834198 0.831372559070587 0.95686274766922];
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x = [1:3 5:7 9:11 13:15];

    I = [1,5,9,2,6,10,3,7,11,4,8,12];

    [highest_acc_pp,best_model_ind_pp] = max(all_models,[],1);

    [val]=hist(best_model_ind_pp,1:1:size(mod.mean_pp,2));
    
    val=val(I);

    b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

    txt_val = val';
    ind_notnul = find(val~=0);

    text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
    box off

    ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
    set(gca,'YTick',0:10:100)
    ylim([0 45])

    xticks(x)
    xlim([0 x(end)+1])
    xticklabels(legend_all(I));

    xtickangle(45)
    
    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end


