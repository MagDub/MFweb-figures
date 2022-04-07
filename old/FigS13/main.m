
addpath('../../cmocean/')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

n_sim = 20000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

load(strcat(saving_dir, 'inp_params_thompson.mat'))
load(strcat(saving_dir, 'out_sim_thompson.mat'))

%{'sgm0', 'sgm0', 'Q0','xi', '', 'eta', ''};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

% Figure 

subplot(2,4,1)
title_ = '\fontsize{22} \epsilon_{SH}';
render_corr(para_vals_fitted(:,4),para_vals_generated(:,4), param_bounds_xi, [0:0.1:0.5], title_, 'a');

subplot(2,4,2)
title_ = '\fontsize{22} \epsilon_{LH}';
render_corr(para_vals_fitted(:,5),para_vals_generated(:,5), param_bounds_xi, [0:0.1:0.5], title_, 'b');

subplot(2,4,3)
title_ = '\fontsize{22} \eta_{SH}';
render_corr(para_vals_fitted(:,6),para_vals_generated(:,6), param_bounds_eta, [0:1:5], title_, 'c');

subplot(2,4,4)
title_ = '\fontsize{22} \eta_{LH}';
render_corr(para_vals_fitted(:,7),para_vals_generated(:,7), param_bounds_eta, [0:1:5], title_, 'd');

subplot(2,4,5)
title_ = '\fontsize{18} Q_0';
render_corr(para_vals_fitted(:,3),para_vals_generated(:,3), param_bounds_Q0, [1:2:6], title_, 'e');

subplot(2,4,6)
title_ = '\fontsize{22} \sigma_{0,SH}';
render_corr(para_vals_fitted(:,1),para_vals_generated(:,1), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'f');
  
subplot(2,4,7)
title_ = '\fontsize{22} \sigma_{0,LH}';
render_corr(para_vals_fitted(:,2),para_vals_generated(:,2), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'g');

subplot(2,4,8)
render_param_recovery();

% %% Export
% addpath('../../../export_fig')
% export_fig(['Fig_S13.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig13.png'],'-nocrop','-r200')