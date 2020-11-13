
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1)
plot_score_exclusion();

subplot(1,2,2)
plot_RT_exclusion();

% Export
addpath('../../../export_fig')
export_fig(['FigS1.tif'],'-nocrop','-r200')
