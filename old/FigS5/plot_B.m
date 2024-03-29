
function [] = plot_B(ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/pickedB_SH.mat')
    load('../../../data/data_for_figs/pickedB_LH.mat')
    load('../../../data_analysis/usermat_completed.mat')

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    pickedB_SH(to_del,:) = nan;
    pickedB_LH(to_del,:) = nan;

    % Figure
    col_(1,:) = [4.366786594847170133e-01 7.114212963902242226e-01 8.027769966740599950e-01];
    col_(2,:) = [1.302307935855599175e-01 1.261348273230401829e-01 2.555217697948003464e-01]; 

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(pickedB_SH,1),1)-0.5)/5;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(pickedB_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.5, 'BarWidth',1); hold on;

    % Long horizon
    b2L = bar(x_ax(6),nanmean(pickedB_LH),'FaceColor',col_(1,:),'FaceAlpha', 0.5, 'BarWidth',1);

    for n = 1:size(pickedB_SH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedB_SH(n) pickedB_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax([3 6]),[nanmean(pickedB_SH) nanmean(pickedB_LH)], ...
        [nanstd(pickedB_SH)./sqrt(size(pickedB_SH,1)) nanstd(pickedB_LH)./sqrt(size(pickedB_SH,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};
    set(gca,'box','off')

    ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)

    % Significance
    plot(x_ax([3 6]),[1;1]*hight_signif,'-k', 'LineWidth',1.5);
    th = text(mean(x_ax([3 6])), hight_signif, signif,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');
    set(th,'visible','on','HorizontalAlignment','center');
    
    % Title and letter
    text(0-0.2, 1+0.2,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Standard bandit ','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end