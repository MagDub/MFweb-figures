load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../../data/questionnaire/all/STAI_all.mat')
load('../../../data/questionnaire/all/CFS_all.mat')
CFS_all(to_del,:) = [];

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1);
var1 = T.scores_f1;
var2 = T.eta_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,5];  
title_ = 'Anxious-depression factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'SouthEast', 'Factor score', {'Novelty exploration'})

subplot(1,2,2);
var1 = CFS_all(:,1);
var2 = T.eta_mean;
param_bounds_var1 = [15,85]; 
param_bounds_var2 = [0,5];  
title_ = 'Trait anxiety Q';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'SouthEast', 'STAI score', {'Novelty exploration'})

% %Export
% addpath('../../../export_fig')
% export_fig(['Fig_corr_Q_eta.tif'],'-nocrop','-r200')
