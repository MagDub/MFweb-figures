
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1)
plot_time();

subplot(1,3,2)
plot_score_exclusion();

subplot(1,3,3)
plot_RT_exclusion();

% % Export 
% addpath('../../../export_fig')
% export_fig(['FigS1.tif'],'-nocrop','-r200')
