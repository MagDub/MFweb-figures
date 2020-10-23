
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1)
subplot_title = 'Best fitting model (CV)';
render_model_comparison_CV('a', subplot_title);

subplot(2,3,2)
subplot_title = 'Best fitting model (BIC)';
render_model_comparison_BIC('b', subplot_title);

subplot(2,3,3)
subplot_title = 'Best fitting model (AIC)';
render_model_comparison_AIC('c', subplot_title);

subplot(2,3,4)
subplot_title = 'Best fitting model (CV)';
render_model_comparison_CV_per_pp('d', subplot_title);

subplot(2,3,5)
subplot_title = 'Best fitting model (BIC)';
render_model_comparison_BIC_per_pp('e', subplot_title);

subplot(2,3,6)
subplot_title = 'Best fitting model (AIC)';
render_model_comparison_AIC_per_pp('f', subplot_title);

% Export
addpath('../../export_fig')
export_fig(['Fig4S3.tif'],'-nocrop','-r200')
