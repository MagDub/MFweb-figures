
function [] = plot_param_mod12_Q0(ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/mod12_Q0.mat')
    load('../../../data_analysis/usermat_completed.mat')
    param = Q0;

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    param(to_del,:) = nan;

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x_ax = [1];

     noise_plot = (rand(size(param,1),1)-0.5)/5;

    b2S = bar(x_ax(1),nanmean(param),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',.5); hold on;
    plot(x_ax(1)*ones(1,size(param,1))+noise_plot, param','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',5);

    h = errorbar(x_ax,[nanmean(param)], ...
        [nanstd(param)./sqrt(size(param,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([x_ax(1)-0.75 x_ax(1)+0.75])   
    set(gca,'XTick',[mean(x_ax)])
    set(gca,'XTickLabel',{''});
    set(gca,'box','off')

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)
    
    % Title and letter
    text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(['\fontsize{18} Prior mean Q_0'],'interpreter','tex','Fontweight','normal','FontName','Arial');

end
