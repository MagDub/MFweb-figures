
function [] = render_model_comparison_CV(letter, subplot_title)

    load('../../data/data_for_figs/mod.mat')
    load('../../data/data_for_figs/mean_all_pp.mat')

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
    
    % Figure
    col_(1,:) = [0.729411780834198 0.831372559070587 0.95686274766922];
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x = [1:4 6:9 11:14];

    I = 1:1:size(mean_all,2); 

    bar(x,mean_all(I)*100,'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;

    er = errorbar(x,mean_all(I)*100,stderror_all(I)*100,stderror_all(I)*100);    
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    ylabel({'Held-out data','likelihood [%]'},'FontName','Arial','Fontweight','bold','FontSize',11);
    yrange = [48 56]; %grid on;
    box off;
    ylim(yrange)
    xticks(x)
    xticklabels(legend_all(I));
    xtickangle(45)
    set(gca,'YTick',0:2:100)

    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end
