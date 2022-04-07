
addpath('../../cmocean/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 28 12]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1)
render_param_recovery();

subplot(1,2,2)
render_model_identification();

% % Export
addpath('../../../export_fig')
% export_fig(['FigS7.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig7.png'],'-nocrop','-r200')
