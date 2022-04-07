addpath('../fcts/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

subplot(1,3,1)
plot_time_task(col_);

subplot(1,3,2)
plot_score_exclusion(col_);

subplot(1,3,3)
plot_RT_exclusion(col_);

% % Export 
% addpath('../../../export_fig')
% export_fig(['FigS2.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig2.png'],'-nocrop','-r200')