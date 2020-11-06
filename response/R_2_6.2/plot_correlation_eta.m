
close all;

%%% Data

load('../../../data/data_for_figs/mod8_eta8_eta_SH.mat');
mod8SH = eta_SH;

load('../../../data/data_for_figs/mod8_eta8_eta_LH.mat');
mod8LH = eta_LH;

load('../../../data/data_for_figs/mod12_eta_SH.mat');
mod12SH = eta_SH;

load('../../../data/data_for_figs/mod12_eta_LH.mat');
mod12LH = eta_LH;

%%% Data NADA

load('/Users/magdadubois/MFnada/data/modelfit/UCB_prior1normal/concatenated/model_parameters_desc.mat')
load('/Users/magdadubois/MFnada/data/modelfit/UCB_prior1normal/concatenated/model_parameters.mat')

NADA_mod8SH = model_parameters(:,9);
NADA_mod8LH = model_parameters(:,10);

load('/Users/magdadubois/MFnada/data/modelfit/Thompson_prior1normal/concatenated/model_parameters_desc.mat')
load('/Users/magdadubois/MFnada/data/modelfit/Thompson_prior1normal/concatenated/model_parameters.mat')

NADA_mod12SH = model_parameters(:,7);
NADA_mod12LH = model_parameters(:,8);

% Remove ID
load('../../../data_analysis/usermat_completed.mat')

to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

mod8SH(to_del,:) = nan;
mod8LH(to_del,:) = nan;
mod12SH(to_del,:) = nan;
mod12LH(to_del,:) = nan;

NADA_mod8SH(6,:) = nan;
NADA_mod8LH(6,:) = nan;
NADA_mod12SH(6,:) = nan;
NADA_mod12LH(6,:) = nan;

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,3,1);
title_ = 'Web: \fontsize{22}\eta_{SH}';
render_corr(mod12SH,mod8SH, param_bounds_eta, [0:1:5], title_, 'a', []);

subplot(3,3,2);
title_ = 'Web: \fontsize{22}\eta_{LH}';
render_corr(mod12LH,mod8LH, param_bounds_eta, [0:1:5], title_, 'b', []);

subplot(3,3,3);
title_ = 'Web: Both \fontsize{22}\eta';
render_corr([mod12SH; mod12LH],[mod8SH; mod8LH], param_bounds_eta, [0:1:5], title_, 'c', []);


subplot(3,3,4);
title_ = 'NADA: \fontsize{22}\eta_{SH}';
render_corr(NADA_mod12SH,NADA_mod8SH, param_bounds_eta, [0:1:5], title_, 'd', []);

subplot(3,3,5);
title_ = 'NADA: \fontsize{22}\eta_{LH}';
render_corr(NADA_mod12LH,NADA_mod8LH, param_bounds_eta, [0:1:5], title_, 'e', []);

subplot(3,3,6);
title_ = 'NADA: Both \fontsize{22}\eta';
render_corr([NADA_mod12SH; NADA_mod12LH],[NADA_mod8SH; NADA_mod8LH], param_bounds_eta, [0:1:5], title_, 'f', []);


subplot(3,3,7);
title_ = 'Web&NADA: \fontsize{22}\eta_{SH}';
render_corr([mod12SH; NADA_mod12SH],[mod8SH; NADA_mod8SH], param_bounds_eta, [0:1:5], title_, 'd', []);

subplot(3,3,8);
title_ = 'Web&NADA: \fontsize{22}\eta_{LH}';
render_corr([mod12LH; NADA_mod12LH],[mod8LH; NADA_mod8LH], param_bounds_eta, [0:1:5], title_, 'e', []);

subplot(3,3,9);
title_ = 'Web&NADA: Both \fontsize{22}\eta';
render_corr([mod12SH; NADA_mod12SH; mod12LH; NADA_mod12LH],[mod8SH; NADA_mod8SH; mod8LH; NADA_mod8LH], param_bounds_eta, [0:1:5], title_, 'f', []);

% Export
addpath('../../../export_fig')
export_fig(['./Fig_corr_eta.tif'],'-nocrop','-r200')

