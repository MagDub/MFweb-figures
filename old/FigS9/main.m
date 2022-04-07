addpath('../fcts/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

subplot(2,2,1)
ybounds = [0 0.52];
increment = 0.1;
signif = '**';
hight_signif = 0.25;
plot_param_mod12_epsilon(col_, ybounds, increment, signif, hight_signif);

subplot(2,2,2)
ybounds = [0 5.2];
increment = 1;
signif = '***';
hight_signif = 4;
plot_param_mod12_eta(col_,ybounds, increment, signif, hight_signif);
 
subplot(2,2,3)
ybounds = [0 6.2];
increment = 2;
plot_param_mod12_Q0(col_,ybounds, increment, signif, hight_signif);

subplot(2,2,4)
ybounds = [0 3.2];
increment = 1;
signif = '***';
hight_signif = 2;
plot_param_mod12_sgm0(col_,ybounds, increment, signif, hight_signif);

% % Export
% addpath('../../../export_fig')
% export_fig(['FigS9.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig9.png'],'-nocrop','-r200')
