
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,2,1)
ybounds = [0 0.52];
increment = 0.1;
signif = '**';
hight_signif = 0.25;
plot_param_mod12_epsilon(ybounds, increment, signif, hight_signif);

subplot(2,2,2)
ybounds = [0 5.2];
increment = 1;
signif = '***';
hight_signif = 4;
plot_param_mod12_eta(ybounds, increment, signif, hight_signif);
 
subplot(2,2,3)
ybounds = [0 6.2];
increment = 2;
plot_param_mod12_Q0(ybounds, increment, signif, hight_signif);

subplot(2,2,4)
ybounds = [0 3.2];
increment = 1;
signif = '***';
hight_signif = 2;
plot_param_mod12_sgm0(ybounds, increment, signif, hight_signif);

% Export
addpath('../../../export_fig')
export_fig(['FigS9.tif'],'-nocrop','-r200')
