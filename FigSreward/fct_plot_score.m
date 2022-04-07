function [] = fct_plot_score(data_, title_, letter_, loc_, indiv_)
    
    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

    start_=1;
    MarkerSize_ = 100;
    alpha_ = 0.7;
    legend_ = 'Mean block reward';
    p_l = plot(-3:-2, 10:11, 'Color',[col_(1,:) 0.6]); hold on; % less transparent for the legend
    plot(1:5, indiv_, 'Color',[col_(1,:) 0.05]); hold on;

    % Individual dots
    p_i = scatter(1:5, data_, MarkerSize_, col_(2,:), 'filled', 'MarkerFaceAlpha', alpha_); hold on;

    legend([p_l, p_i, p_lr], {'Individual block rewards', legend_, 'y = $\bar{\beta_0}$ + $\bar{\beta_1}*x$'}, 'Location', loc_, 'Interpreter','Latex','FontSize', 12); 
    
    legend boxoff;
    box off;
    
    ylabel('Reward','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('Trial','FontName','Arial','Fontweight','bold','FontSize',12);
    
    yticks(1:1:10)
    ylim([4.4 7.8]);
    
    xticks(start_:1:5)
    xlim([start_ 5]);

    text(0-0.2, 1+0.25,letter_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
end

