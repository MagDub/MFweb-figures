function [] = fct_plot_score(n_, data_, beta_, title_, letter_, loc_, indiv_)
    
    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

    if n_ == 4 
        start_=1;
        MarkerSize_ = 100;
        alpha_ = 0.7;
        legend_ = 'Mean block reward';
        p_l = plot(-3:-2, 10:11, 'Color',[col_(1,:) 0.6]); hold on; % less transparent for the legend
        plot(1:n_, indiv_, 'Color',[col_(1,:) 0.05]); hold on;
    else
        start_=0;
        MarkerSize_ = 30;
        alpha_ = 0.3;
        legend_ = 'Mean trial reward';
    end
    
    % Individual dots
    %p_i = plot(1:n_, data_, 'o', 'Color',[col_(1,:) 1],'LineWidth',LineWidth_,'MarkerSize',MarkerSize_); hold on;
    p_i = scatter(1:n_, data_, MarkerSize_, col_(2,:), 'filled', 'MarkerFaceAlpha', alpha_); hold on;

    % Mean
    %p_m = plot(1:n_, mean(data_)*ones(1,n_), ':', 'Color', [0.20392157137394 0.301960796117783 0.494117647409439]); hold on;
    
    % Linear regression
    intercept_ = nanmean(beta_(1,:));
    slope_ = nanmean(beta_(2,:));
    x = 1:n_;
    p_lr = plot(x, intercept_+slope_*x, '-','LineWidth',3, 'Color',[col_(2,:) 1]); 
    
    % stats
    slopes_all = beta_(2,:)';
    [~,p,~,~] = ttest(slopes_all);
    if p<0.001
        txt_ = {strcat('$\bar{\beta_1}$=', num2str(slope_,'%.2e'));'p$<$0.001'};
    else
        txt_ = {strcat('$\bar{\beta_1}$=', num2str(slope_,'%.2e'));strcat('p=', num2str(p,2))};
    end

    text(0.6, 0.25,txt_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 12, 'Interpreter','Latex')
    %legend([p_m, p_lr], {'mean (averaged over trials)', 'y = $\bar{\beta_0}$ + $\bar{\beta_1}*x$'}, 'Location', loc_, 'Interpreter','Latex','FontSize', 12); 
    if n_ == 4
        legend([p_l, p_i, p_lr], {'Individual block rewards', legend_, 'y = $\bar{\beta_0}$ + $\bar{\beta_1}*x$'}, 'Location', loc_, 'Interpreter','Latex','FontSize', 12); 
    else
        legend([p_i, p_lr], {legend_, 'y = $\bar{\beta_0}$ + $\bar{\beta_1}*x$'}, 'Location', loc_, 'Interpreter','Latex','FontSize', 12); 
    end
    
    legend boxoff;
    box off;
    
    ylabel('Reward','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('Trial','FontName','Arial','Fontweight','bold','FontSize',12);
    
    yticks(1:1:10)
    ylim([4.4 7.8]);
    
    xticks(start_:(n_/4):n_)
    xlim([start_ n_]);

    text(0-0.2, 1+0.25,letter_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
end

