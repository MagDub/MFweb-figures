
addpath('./computeCohen_d/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1)
render_score_perblock_SH();

subplot(2,3,2)
render_score_perblock_LH_1st();

subplot(2,3,3)
render_score_perblock_LH_all();
 
subplot(2,3,4)
render_score_pertrial_SH_1st();

subplot(2,3,5)
render_score_pertrial_LH_1st();

subplot(2,3,6)
render_score_pertrial_LH_all();

% % Export
% addpath('../../../export_fig')
% export_fig(['FigS4.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig4.png'],'-nocrop','-r200')