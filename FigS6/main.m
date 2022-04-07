
addpath('../cmocean/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 43 13]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1)
render_param_recovery();

subplot(1,3,2)
render_model_recovery_conf();

subplot(1,3,3)
render_model_recovery_inv();
 
% Export
addpath('../../export_fig')
export_fig(['FigS6.tif'],'-nocrop','-r200')

