
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% subplot(2,3,1)
% render_score_perblock_SH();
% 
% subplot(2,3,2)
% render_score_perblock_LH_1st();
% 
% subplot(2,3,3)
% render_score_perblock_LH_all();

subplot(2,3,4)
render_score_pertrial_SH();

% subplot(2,3,5)
% render_score_perblock_LH_1st();
% 
% subplot2,3,6)
% render_score_perblock_LH_all();

% % Export
% addpath('../../../export_fig')
% export_fig(['FigS3.tif'],'-nocrop','-r200')