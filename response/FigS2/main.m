
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1)
ybounds = [4.8 7.1];
increment = 0.5;
signif = '***';
hight_signif = 6.9;
plot_EV(ybounds, increment, signif, hight_signif);

subplot(1,3,2)
ybounds = [0.2 2.2];
increment = 0.5;
signif = '***';
hight_signif = 2;
plot_IG(ybounds, increment, signif, hight_signif);
 
subplot(1,3,3)
ybounds = [4.9 6.7];
increment = 0.5;
signif = {'***', '***', '***'};
hight_signif = [6.1, 6.3, 6.5];
plot_score(ybounds, increment, signif, hight_signif);

% Export
addpath('../../../export_fig')
export_fig(['FigS2.tif'],'-nocrop','-r200')
