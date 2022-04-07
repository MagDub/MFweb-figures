
function [] = plot_model_comparison_AIC_extended(letter, subplot_title)

    load('../../../data/data_for_figs/mle_mat_all_extended.mat')

    n_model = size(mle_mat_all,2);

    mle_mat_all(4,:) = nan(1,n_model);
    mle_mat_all(32,:) = nan(1,n_model);
    mle_mat_all(36,:) = nan(1,n_model);
    
    mle_mat_all(:,[6,8]) = []; % rm per trial

    AIC_all = 2*mle_mat_all + 2*[3, 5, 5, 7,    9, 9]; %mle is NLL

    mean_all = nanmean(AIC_all,1);
    n_part = sum(~isnan(AIC_all));
    stderror_all = nanstd(AIC_all,1)./n_part;

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

    I = 1:1:size(mean_all,2); 

    % plot
    bar(x,mean_all(I),'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;
    
    [h,p] = ttest(I(4),I(5))
    
    % best model
    [~, ind_best] = min(mean_all(I));
    bw = bar(x(ind_best),mean_all(I(ind_best)),'FaceColor',col_(2,:), 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
    legend([bw],{'Winning model'}, 'Location','NorthEast');
    legend boxoff  

    er = errorbar(x,mean_all(I),stderror_all(I),stderror_all(I));    
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    ylabel('AIC score')
    yrange = [460 580];
    ylim(yrange)
    xlim([0.25 6.75])
    xticks(x)
    xticklabels(legend_all(I));
    xtickangle(45)
    set(gca,'YTick',0:30:1000);
    box off;
    
    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end