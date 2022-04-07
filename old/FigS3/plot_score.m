
function [] = plot_score(col_, ybounds, increment, signif, hight_signif)

    load('../../../data_analysis/usermat_completed.mat')
    data_fold = ('../../../data/');
    load(strcat(data_fold, 'data_for_figs/score.mat'))
    load(strcat(data_fold, 'data_for_figs/score_desc.mat'))

    score_SH = score(:,2);
    first_LH = score(:,3);
    score_LH = score(:,4);

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    score_SH(to_del,:) = nan;
    score_LH(to_del,:) = nan;
    first_LH(to_del,:) = nan;

    % Figure
    x_ax = 0:0.4:4;

    noise_plot = (rand(size(score_SH,1),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(score_SH), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    % first LH
    b1Lf = bar(x_ax(6),nanmean(first_LH), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    % LH
    b1L = bar(x_ax(9),nanmean(score_LH), 'FaceAlpha', 0.2, 'BarWidth',1, 'FaceColor',col_(1,:), 'EdgeColor', col_(2,:),'LineWidth',1.2); hold on;

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[score_SH(n) first_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([6 9])+noise_plot(n),[first_LH(n) score_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end
    
    % CI
    [neg_SH, pos_SH, mean_SH] = get_bounds_normal_dist(score_SH);
    [neg_LH_1, pos_LH_1, mean_LH_1] = get_bounds_normal_dist(first_LH);
    [neg_LH_all, pos_LH_all, mean_LH_all] = get_bounds_normal_dist(score_LH);
    h = errorbar(x_ax([3 6 9]),...
        [mean_SH mean_LH_1 mean_LH_all],...
        [neg_SH neg_LH_1 neg_LH_all],...
        [pos_SH pos_LH_1 pos_LH_all],...
        '.','color',col_(2,:),'LineWidth',1.2);
    set(h,'Marker','none')

%     h = errorbar(x_ax([3 6 9]),...
%         [nanmean(score_SH) nanmean(first_LH) nanmean(score_LH)], ...
%         [nanstd(score_SH)./sqrt(size(score_SH,1)) nanstd(first_LH)./sqrt(size(score_SH,1)) nanstd(score_LH)./sqrt(size(score_SH,1))],'.','color',col_(2,:),'LineWidth',2);

    set(h,'Marker','none')

    xlim([0.15 3.85])   
    set(gca,'XTick',[x_ax(3) x_ax(6) x_ax(9)])

    labels = {strcat('Short horizon \newline',32,32,'1st sample'),strcat(' Long horizon \newline',32,32,' 1st sample'),strcat(32,32,32,32,'Long horizon \newline',32,32,'average sample')};
    a = gca;
    a.XTickLabel = labels;

    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif(1),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif(1), signif{1},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(3),[hight_signif(1)*0.99,hight_signif(1)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(6),[hight_signif(1)*0.99,hight_signif(1)*1],'-k', 'LineWidth',1.5);%right edge drop
    
    plot(x_ax([6 9]),[1;1]*hight_signif(2),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([6 9])), hight_signif(2), signif{2},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(6),[hight_signif(2)*0.99,hight_signif(2)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(9),[hight_signif(2)*0.99,hight_signif(2)*1],'-k', 'LineWidth',1.5);%right edge drop
    
    plot(x_ax([3 9]),[1;1]*hight_signif(3),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 9])), hight_signif(3), signif{3},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(3),[hight_signif(3)*0.99,hight_signif(3)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(9),[hight_signif(3)*0.99,hight_signif(3)*1],'-k', 'LineWidth',1.5);%right edge drop
    
    % Number and title
    text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Score','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

    labels = {strcat('Short horizon \newline',32,32,'1st sample'),strcat(' Long horizon \newline',32,32,' 1st sample'),strcat(32,32,32,32,'Long horizon \newline',32,32,'average sample')};
    a = gca;
    a.XTickLabel = labels; 
    set(gca,'box','off')

    ylabel('Reward','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)

end
