

load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data

load('../../data/data_for_figs/model_parameters_mod8.mat')
load('../../data/data_for_figs/model_parameters_mod8_desc.mat')
ind_SH = find(contains(model_parameters_desc,'eta_short'));
ind_LH = find(contains(model_parameters_desc,'eta_long'));
mod8SH = model_parameters(:,ind_SH);
mod8LH = model_parameters(:,ind_LH);

load('../../data/data_for_figs/mod12_eta_SH.mat');
mod12SH = eta_SH;

load('../../data/data_for_figs/mod12_eta_LH.mat');
mod12LH = eta_LH;

% Remove ID
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
title_ = '\fontsize{22}\eta_{SH}';
p=render_corr(mod12SH,mod8SH, param_bounds_eta, [0:1:5], title_, 'a', 'SouthEast');
disp('a')
disp(p)
disp('---------')

subplot(1,3,2);
title_ = '\fontsize{22}\eta_{LH}';
p=render_corr(mod12LH,mod8LH, param_bounds_eta, [0:1:5], title_, 'b', 'SouthEast');
disp('b')
disp(p)
disp('---------')

subplot(1,3,3);
title_ = 'Both \fontsize{22}\eta';
p=render_corr([mod12SH; mod12LH],[mod8SH; mod8LH], param_bounds_eta, [0:1:5], title_, 'c', 'SouthEast');
disp('c')
disp(p)
disp('---------')

%Export
addpath('../../export_fig')
export_fig(['FigS9.tif'],'-nocrop','-r200')

