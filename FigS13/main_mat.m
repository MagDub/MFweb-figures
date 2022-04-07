


figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 30])
set(gca,'FontName','Arial','FontSize',10)
hold on;

c_ax = [0 0.31];
%% 
inc = 0.1;

subplot(3,2,1:2)
main_mat_behav(c_ax, inc)

subplot(3,2,3:4)
main_mat_param(c_ax, inc)

subplot(3,2,5)
main_mat_behav_allF(c_ax, inc)

subplot(3,2,6)
main_mat_param_allF(c_ax, inc)

%Export
addpath('../../export_fig')
export_fig(['Fig_S13.tif'],'-nocrop','-r200')