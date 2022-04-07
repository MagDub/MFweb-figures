
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 11]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

%%%

subplot(1,2,1)
subplot_title = 'Best fitting model';
plot_model_comparison_BIC_extended('a', subplot_title);

% subplot(2,2,2)
% subplot_title = 'Best fitting model (AIC)';
% plot_model_comparison_AIC_extended('b', subplot_title);

%%%
 
subplot(1,2,2)
subplot_title = 'Best fitting model';
plot_model_comparison_BIC_per_pp_extended_B('b', subplot_title);

% subplot(2,2,4)
% subplot_title = 'Best fitting model (AIC)';
% plot_model_comparison_AIC_per_pp_extended_B('d', subplot_title);


% TODO: exceedance prob??

% Export
addpath('../../../export_fig')
export_fig(['Fig_model_selection.tif'],'-nocrop','-r200')
