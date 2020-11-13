
function [] = plot_score(ybounds, increment, signif, hight_signif)

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
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(score_SH,1),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(score_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); hold on;

    % first LH
    b1Lf = bar(x_ax(6),nanmean(first_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    % LH
    b1L = bar(x_ax(9),nanmean(score_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[score_SH(n) first_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([6 9])+noise_plot(n),[first_LH(n) score_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([3 6 9]),...
        [nanmean(score_SH) nanmean(first_LH) nanmean(score_LH)], ...
        [nanstd(score_SH)./sqrt(size(score_SH,1)) nanstd(first_LH)./sqrt(size(score_SH,1)) nanstd(score_LH)./sqrt(size(score_SH,1))],'.','color','k');

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
