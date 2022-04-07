function [] = plot_score_diff(to_del, col_, ybounds, increment, signif, hight_signif)

    addpath('../fcts/')
    
    % Data
    dir_ = '../../data/data_for_figs/';
    
    load(strcat(dir_, 'score_desc.mat'))
    load(strcat(dir_, 'score_C.mat'))
    load(strcat(dir_, 'score_D.mat'))
    load(strcat(dir_, 'score_H.mat'))
    
    load('../../data_analysis/usermat_completed.mat')
    
        % Remove ID
    score_H(to_del,:) = [];
    score_C(to_del,:) = [];
    score_D(to_del,:) = [];
    
    %
    numel_n = size(score_H,1);
    
    x_ax = 0:0.4:4;
    
    % Figure
    col_(1,:) = [0.6278    0.1425    0.3855]; % bar
    col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines
    
    x_ax = 0:0.5:4;
    
    % plot bars
    ph = plot_score_bars_2(score_H(:,2)-score_H(:,3), score_H(:,14)-score_H(:,6), [2,6], x_ax, 0.05);
    pc = plot_score_bars_2(score_C(:,2)-score_C(:,3), score_C(:,14)-score_C(:,6), [3,7], x_ax, 0.4);
    pd = plot_score_bars_2(score_D(:,2)-score_D(:,3), score_D(:,14)-score_D(:,6), [4,8], x_ax, 0.8);
    
    tmp = [score_H(:,2)-score_H(:,3), score_C(:,2)-score_C(:,3), score_D(:,2)-score_D(:,3), ...
            score_H(:,14)-score_H(:,6), score_C(:,14)-score_C(:,6), score_D(:,14)-score_D(:,6)];
    
    
    xlim([x_ax(1) x_ax(end)])   
    set(gca,'XTick',[x_ax(3) x_ax(7)])
    xtickangle(0);
    labels = {strcat(32,32,32,32,'Reward \newlineshort horizon'),'  Last reward \newline long horizon'};
    a = gca;
    a.XTickLabel = labels;
    
    ylabel({'Reward difference';' (w.r.t. best initial sample)'},'FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',-10:increment:10)
    
    ylim(ybounds)

    box off;

    % Significance
    plot(x_ax([3 7]),[1;1]*hight_signif(1),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 7])), hight_signif(1), signif{1},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(3),[hight_signif(1)*0.85,hight_signif(1)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(7),[hight_signif(1)*0.85,hight_signif(1)*1],'-k', 'LineWidth',1.5);%right edge drop

    plot(x_ax([4 8]),[1;1]*hight_signif(2),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([4 8])), hight_signif(2), signif{2},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(4),[hight_signif(2)*0.85,hight_signif(2)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(8),[hight_signif(2)*0.85,hight_signif(2)*1],'-k', 'LineWidth',1.5);%right edge drop

    plot(x_ax([6 7])+[0,-0.05],[1;1]*hight_signif(3),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([6 7])+[0,-0.05]), hight_signif(3), signif{3},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(6),[hight_signif(3)*0.9,hight_signif(3)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*(x_ax(7)-0.05),[hight_signif(3)*0.9,hight_signif(3)*1],'-k', 'LineWidth',1.5);%right edge drop

    plot(x_ax([7 8])+[0.05,0],[1;1]*hight_signif(4),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([7 8])+[0.05,0]), hight_signif(4), signif{4},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*(x_ax(7)+0.05),[hight_signif(4)*0.9,hight_signif(4)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(8),[hight_signif(4)*0.9,hight_signif(4)*1],'-k', 'LineWidth',1.5);%right edge drop

    plot(x_ax([6 8]),[1;1]*hight_signif(5),'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([6 8])), hight_signif(5), signif{5},'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    plot([1;1]*x_ax(6),[hight_signif(5)*0.9,hight_signif(5)*1],'-k', 'LineWidth',1.5);%left edge drop
    plot([1;1]*x_ax(8),[hight_signif(5)*0.9,hight_signif(5)*1],'-k', 'LineWidth',1.5);%right edge drop

  
    % Legend
    legend([ph, pc, pd], {'High-value bandit', 'Novel bandit', 'Low-value bandit'},'Orientation','vertical', ...
                            'Position',[0.58 0.37 0.19 0.08])
    legend boxoff;

    % Number and title
    text(0-0.2, 1+0.2,'d','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Performance per bandit','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');


end