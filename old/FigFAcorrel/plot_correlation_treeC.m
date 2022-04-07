load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../../data/questionnaire/all/LSAS_all.mat')
load('../../../data/questionnaire/all/STAI_all.mat')
load('../../../data/questionnaire/all/CFS_all.mat')
STAI_all(to_del,:) = [];
LSAS_all(to_del,:) = [];
CFS_all(to_del,:) = [];

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,2,1);
var1 = STAI_all(:,1);
var2 = T.pickedC_mean;
param_bounds_var1 = [15,85]; 
param_bounds_var2 = [0,80];  
title_ = 'State-Trait anxiety';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'SouthEast', 'STAI score', {'Novel bandit frequency'})

subplot(2,2,2);
var1 = LSAS_all(:,1);
var2 = T.pickedC_mean;
param_bounds_var1 = [0,150];
param_bounds_var2 = [0,80];  
title_ = 'Social anxiety';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'SouthEast', 'LSAS score', {'Novel bandit frequency'})

subplot(2,2,3);
var1 = CFS_all(:,1);
var2 = T.pickedC_mean;
param_bounds_var1 = [27,74];
param_bounds_var2 = [0,80];  
title_ = 'Cognitive flexibility';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'SouthEast', 'CFS score', {'Novel bandit frequency'})

subplot(2,2,4);
var1 = T.scores_f1;
var2 = T.pickedC_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,80];  
title_ = 'Anxiety factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'SouthEast', 'Factor score', {'Novel bandit frequency'})

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_F1_novelTree.tif'],'-nocrop','-r200')

