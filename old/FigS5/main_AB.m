
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1)
ybounds = [0 61];
increment = 15;
signif = '***';
hight_signif = 50;
plot_A(ybounds, increment, signif, hight_signif);

subplot(1,2,2)
ybounds = [0 61];
increment = 15;
signif = '***';
hight_signif = 37;
plot_B(ybounds, increment, signif, hight_signif);

% Export
addpath('../../../export_fig')
export_fig(['FigS5_AB.tif'],'-nocrop','-r200')
