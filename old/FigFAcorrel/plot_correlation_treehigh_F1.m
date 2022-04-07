load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../../data/questionnaire/all/ASRS_all.mat')
load('../../../data/questionnaire/all/BIS11_all.mat')
load('../../../data/questionnaire/all/CFS_all.mat')
load('../../../data/questionnaire/all/STAI_all.mat')
load('../../../data/questionnaire/all/IUS_all.mat')
load('../../../data/questionnaire/all/LSAS_all.mat')
load('../../../data/questionnaire/all/SDS_all.mat')
ASRS_all(to_del,:) = [];
BIS11_all(to_del,:) = [];
CFS_all(to_del,:) = [];
STAI_all(to_del,:) = [];
IUS_all(to_del,:) = [];
LSAS_all(to_del,:) = [];
SDS_all(to_del,:) = [];

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(3,2,1);
var1 = CFS_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [25,75];
param_bounds_var2 = [15,95];
title_ = 'Cognitive flexibility';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'CFS score', {'High-value bandit frequency'})

subplot(3,2,2);
var1 = STAI_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [15,80]; 
param_bounds_var2 = [15,95];
title_ = 'Trait anxiety';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'STAI score', {'High-value bandit frequency'})

subplot(3,2,3);
var1 = LSAS_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [0,150]; 
param_bounds_var2 = [15,95];
title_ = 'Social anxiety';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthEast', 'LSAS score', {'High-value bandit frequency'})

subplot(3,2,4);
var1 = SDS_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [15,75];
param_bounds_var2 = [15,95];
title_ = 'Depression';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'NorthEast', 'SDS score', {'High-value bandit frequency'})

subplot(3,2,5);
var1 = T.scores_f1;
var2 = T.pickedhigh_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [15,95];
title_ = 'Anxiety factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'e', 'NorthEast', 'Factor score', {'High-value bandit frequency'})

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_F1_highTree.tif'],'-nocrop','-r200')

