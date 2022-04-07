
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

%%%

subplot(1,3,1)
subplot_title = 'Best fitting model';
render_model_comparison_BIC_t1(col_, 'a', subplot_title);

%%%

subplot(1,3,2)
subplot_title = 'Best fitting model';
render_model_comparison_BIC_per_pp_t1(col_, 'b', subplot_title);

%%%

subplot(1,3,3)
subplot_title = 'Best fitting model';
render_model_comparison_BIC_BMS_t1(col_, 'c', subplot_title);


% % Export
% addpath('../../../export_fig')
% export_fig(['Fig_model_selection_t1.tif'],'-nocrop','-r200')

% export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig14.png'],'-nocrop','-r200')

