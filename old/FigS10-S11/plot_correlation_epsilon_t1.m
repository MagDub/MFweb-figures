
%%% Data Pilot data

load('../../../data/data_for_figs/model_parameters_mod8_t1.mat')
load('../../../data/data_for_figs/model_parameters_mod8_t1_desc.mat')
ind_SH = find(contains(model_parameters_desc,'xi_short'));
ind_LH = find(contains(model_parameters_desc,'xi_long'));
mod8SH = model_parameters(:,ind_SH);
mod8LH = model_parameters(:,ind_LH);

load('../../../data/data_for_figs/mod12_xi_SH.mat');
mod12SH = xi_SH;

load('../../../data/data_for_figs/mod12_xi_LH.mat');
mod12LH = xi_LH;

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
title_ = 'Pilot data: \fontsize{22}\epsilon_{SH}';
render_corr(mod12SH,mod8SH, param_bounds_xi, [0:0.1:0.5], title_, 'a', 'SouthEast');

subplot(1,3,2);
title_ = 'Pilot data: \fontsize{22}\epsilon_{LH}';
render_corr(mod12LH,mod8LH, param_bounds_xi, [0:0.1:0.5], title_, 'b', 'SouthEast');

subplot(1,3,3);
title_ = 'Pilot data: Both \fontsize{22}\epsilon';
render_corr([mod12SH; mod12LH],[mod8SH; mod8LH], param_bounds_xi, [0:0.1:0.5], title_, 'c', 'SouthEast');

% Export
addpath('../../../export_fig')
export_fig(['./Fig_corr_epsilon_t1.tif'],'-nocrop','-r200')

