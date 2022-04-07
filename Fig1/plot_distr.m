function [] = plot_distr(samples_1, samples_2, samples_3, samples_4, title_)

    x_values = 1:0.1:10;

    y1 = pdf(fitdist(samples_1,'Normal'),x_values);
    y2 = pdf(fitdist(samples_2,'Normal'),x_values);
    y3 = pdf(fitdist(samples_3,'Normal'),x_values);
    y4 = pdf(fitdist(samples_4,'Normal'),x_values);

    hold all;
    plot(x_values,y1,'LineWidth',2); 
    plot(x_values,y2,'LineWidth',2); 
    plot(x_values,y3,'LineWidth',2); 
    plot(x_values,y4,'LineWidth',2); 
    xlim([1 10])
    xticks(1:10)
    ylim([0 1.1])
    h = gca; 
    h.YAxis.Visible = 'off';
    set(gca,'YTickLabel',[]);
    title(title_,'FontSize', 16, 'FontName','Arial', 'Fontweight','normal');
    xlabel('Value','FontName','Arial','Fontweight','bold','FontSize',12);

    legend({'Certain-standard bandit', 'Certain bandit', 'Novel bandit', 'Low-value bandit'}, 'Location','NorthWest');
    legend boxoff 
    hold off;

end

