load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../data/questionnaire/all/BIS11_all.mat')
load('../../data/questionnaire/all/OCIR_all.mat')
load('../../data/questionnaire/all/ASRS_all.mat')
BIS11_all(to_del,:) = [];
ASRS_all(to_del,:) = [];

% FA
T = readtable('../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');
diff_xi = T.xi_LH - T.xi_SH;
diff_eta = T.eta_LH - T.eta_SH;

% Quest
load('../../data/questionnaire/all/AQ10_all.mat')
load('../../data/questionnaire/all/ASRS_all.mat')
load('../../data/questionnaire/all/BIS11_all.mat')
load('../../data/questionnaire/all/CFS_all.mat')
AQ10_all(to_del,:) = [];
ASRS_all(to_del,:) = [];
BIS11_all(to_del,:) = [];
CFS_all(to_del,:) = [];


%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,4,1);
var1 = CFS_all;
var2 = diff_xi;
param_bounds_var1 = [25,75]; 
param_bounds_var2 = [-0.5,0.5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'CFS score', {'\epsilon-greedy parameter difference'})

subplot(2,4,2);
var1 = BIS11_all(:,1);
var2 = diff_xi;
param_bounds_var1 = [30,105]; 
param_bounds_var2 = [-0.5,0.5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'BIS11 score', {'\epsilon-greedy parameter difference'})

subplot(2,4,3);
var1 = ASRS_all(:,1);
var2 = diff_xi;
param_bounds_var1 = [15,90]; 
param_bounds_var2 = [-0.5,0.5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthEast', 'ASRS score', {'\epsilon-greedy parameter difference'})

subplot(2,4,4);
var1 = AQ10_all;
var2 = diff_xi;
param_bounds_var1 = [0,10]; 
param_bounds_var2 = [-0.5,0.5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'NorthEast', 'AQ10 score', {'\epsilon-greedy parameter difference'})


subplot(2,4,5);
var1 = CFS_all;
var2 = diff_eta;
param_bounds_var1 = [25,75]; 
param_bounds_var2 = [-2,5];   
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'e', 'NorthEast', 'CFS score', {'Novelty bonus \eta difference'})

subplot(2,4,6);
var1 = BIS11_all(:,1);
var2 = diff_eta;
param_bounds_var1 = [30,105]; 
param_bounds_var2 = [-2,5];   
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'f', 'NorthEast', 'BIS11 score', {'Novelty bonus \eta difference'})

subplot(2,4,7);
var1 = ASRS_all(:,1);
var2 = diff_eta;
param_bounds_var1 = [15,90]; 
param_bounds_var2 = [-2,5];   
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'g', 'NorthEast', 'ASRS score', {'Novelty bonus \eta difference'})

subplot(2,4,8);
var1 = AQ10_all;
var2 = diff_eta;
param_bounds_var1 = [0,10]; 
param_bounds_var2 = [-2,5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'h', 'NorthEast', 'AQ10 score', {'Novelty bonus \eta difference'})

%Export
addpath('../../export_fig')
export_fig(['Fig_corr_diff.tif'],'-nocrop','-r200')

