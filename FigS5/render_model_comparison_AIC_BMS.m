
function [] = render_model_comparison_AIC_BMS(letter, subplot_title)

    load('../../../data/data_for_figs/mle_mat_all.mat');
    
    n_model = size(mle_mat_all,2);

    mle_mat_all(4,:) = nan(1,n_model);
    mle_mat_all(32,:) = nan(1,n_model);
    mle_mat_all(36,:) = nan(1,n_model);
    
    mle_mat_all([4,32,36],:) = [];

    AIC_all = 2*mle_mat_all + 2*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12]; % ./log(400); %mle is NLL
    
    [alpha,exp_r,xp,pxp,bor] = spm_BMS(-AIC_all);
        
    meas = xp;
    ylab_ =  {'Exceedance','probabilities'};
%     
%     meas = exp_r;
%     ylab_ = 'Expectation of the posterior p(r|y)';
%     
%     meas = alpha;
%     ylab_ = 'Model probabilities';
% 
%     meas = pxp;
%     ylab_ = 'Protected exceedance probabilities';
    
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
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; 

    x = [1:3 5:7 9:11 13:15];

    I = [1,5,9,2,6,10,3,7,11,4,8,12];

    b = bar(x,meas(I),'FaceColor',col_(1,:),'BarWidth',.7);  hold on;
    box off;

    % best model
    [~, ind_best] = max(meas(I));
    bw = bar(x(ind_best),meas(I(ind_best)),'FaceColor',col_(2,:), 'FaceAlpha', 1, 'BarWidth',0.8); hold on;
    legend([bw],{'Winning model'}, 'Location','NorthWest');
    legend boxoff 
    
    ylabel(ylab_,'FontName','Arial','Fontweight','bold','FontSize',11);
    set(gca,'YTick',0:0.2:1)
    ylim([0  1.05])

    xticks(x)
    xlim([0 x(end)+1])
    xticklabels(legend_all(I));

    xtickangle(45)

    % Number and title
    text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(subplot_title,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end