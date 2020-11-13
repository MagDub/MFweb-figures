
function [] = plot_param_mod12_epsilon(ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/mod12_xi_SH.mat')
    load('../../../data/data_for_figs/mod12_xi_LH.mat')
    load('../../../data_analysis/usermat_completed.mat')
    param_SH = xi_SH;
    param_LH = xi_LH;

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    param_SH(to_del,:) = nan;
    param_LH(to_del,:) = nan;

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x_ax = 0:0.4:4;

     noise_plot = (rand(size(param_SH,1),1)-0.5)/5;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); hold on;

    % Long horizon
    b2L = bar(x_ax(6),nanmean(param_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);

    for n = 1:size(param_SH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[param_SH(n) param_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax([3 6]),[nanmean(param_SH) nanmean(param_LH)], ...
        [nanstd(param_SH)./sqrt(size(param_SH,1)) nanstd(param_LH)./sqrt(size(param_SH,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};
    set(gca,'box','off')

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)
    
    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    
    % Title and letter
    text(0-0.2, 1+0.2,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(['\fontsize{22} \epsilon{\fontsize{18}-greedy parameter}'],'interpreter','tex','Fontweight','normal','FontName','Arial');

end