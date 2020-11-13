
function [] = plot_IG(ybounds, increment, signif, hight_signif)

    load('../../../data_analysis/usermat_completed.mat')
    data_fold = ('../../../data/');
    numel = size(usermat_completed,2);

    load(strcat(data_fold, 'data_for_figs/IS_SH_mat.mat'))
    load(strcat(data_fold, 'data_for_figs/IS_LH_mat.mat'))

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    IS_SH_mat(to_del,:) = nan;
    IS_LH_mat(to_del,:) = nan;

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(IS_SH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); hold on;

    % first LH
    b1Lf = bar(x_ax(6),nanmean(IS_LH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    for n = 1:size(IS_LH_mat,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[IS_SH_mat(n) IS_LH_mat(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([3 6])+noise_plot(n),...
        [nanmean(IS_SH_mat) nanmean(IS_LH_mat)], ...
        [nanstd(IS_SH_mat)./sqrt(numel) nanstd(IS_LH_mat)./sqrt(numel)],'.','color','k');

    set(h,'Marker','none')

    xlim([0 2.8])   
    set(gca,'XTick',[x_ax(3) x_ax(6)])

    labels = {'Short horizon', 'Long horizon'};

    a = gca;
    a.XTickLabel = labels;
    set(gca,'box','off')

    ylabel({'Number of initial samples','of chosen bandit'},'FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:3)
    ylim(ybounds)
    
    % Title and letter
    text(0-0.2, 1+0.2,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Information seeking','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');


end

