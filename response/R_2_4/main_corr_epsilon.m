
%%% Data web
    
load('../../../data/data_for_figs/model_parameters_mod12_etaB_desc.mat')
load('../../../data/data_for_figs/model_parameters_mod12_etaB.mat');
mod12B_SH = model_parameters(:,9);
mod12B_LH = model_parameters(:,10);

load('../../../data/data_for_figs/mod12_xi_SH.mat');
mod12_SH = xi_SH;

load('../../../data/data_for_figs/mod12_xi_LH.mat');
mod12_LH = xi_LH;

% Remove ID

load('../../../data_analysis/usermat_completed.mat')

to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

mod12B_SH(to_del,:) = nan;
mod12B_LH(to_del,:) = nan;
mod12_SH(to_del,:) = nan;
mod12_LH(to_del,:) = nan;

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(1,3,1);
title_ = '\fontsize{22}\epsilon_{SH}';
render_corr(mod12B_SH, mod12_SH, param_bounds_xi, [0:0.1:0.5], title_, 'a', []);

subplot(1,3,2);
title_ = '\fontsize{22}\epsilon_{LH}';
render_corr(mod12B_LH, mod12_LH, param_bounds_xi, [0:0.1:0.5], title_, 'b', []);

subplot(1,3,3);
title_ = 'Both \fontsize{22}\epsilon';
render_corr([mod12B_SH; mod12B_LH], [mod12_SH; mod12_LH], param_bounds_xi, [0:0.1:0.5], title_, 'c', []);

% Export
addpath('../../../export_fig')
export_fig(['./Fig_corr_epsilon.tif'],'-nocrop','-r200')

