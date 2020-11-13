
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1)
ybounds = [0 80];
increment = 15;
signif = '***';
hight_signif = 65;
plot_high_value(ybounds, increment, signif, hight_signif);

subplot(1,3,2)
ybounds = [0 80];
increment = 15;
signif = '***';
hight_signif = 60;
plot_novel_value(ybounds, increment, signif, hight_signif);
 
subplot(1,3,3)
ybounds = [0 22];
increment = 5;
signif = '***';
hight_signif = 12;
plot_low_value(ybounds, increment, signif, hight_signif);

% Export
addpath('../../../export_fig')
export_fig(['FigS4.tif'],'-nocrop','-r200')
