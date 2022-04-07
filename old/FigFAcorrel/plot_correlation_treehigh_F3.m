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
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1);
var1 = ASRS_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [15,90]; 
param_bounds_var2 = [15,95];
title_ = 'ADHD';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'ASRS score', {'High-value bandit frequency'})

subplot(1,3,2);
var1 = BIS11_all(:,1);
var2 = T.pickedhigh_mean;
param_bounds_var1 = [30,110]; 
param_bounds_var2 = [15,95];
title_ = 'Impulsivity';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'BIS score', {'High-value bandit frequency'})

subplot(1,3,3);
var1 = T.scores_f3;
var2 = T.pickedhigh_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [15,95];
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthEast', 'Factor score', {'High-value bandit frequency'})

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_F3_highTree.tif'],'-nocrop','-r200')

