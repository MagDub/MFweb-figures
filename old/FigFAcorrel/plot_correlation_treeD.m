load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../../data/questionnaire/all/BIS11_all.mat')
load('../../../data/questionnaire/all/OCIR_all.mat')
load('../../../data/questionnaire/all/ASRS_all.mat')
BIS11_all(to_del,:) = [];
OCIR_all(to_del,:) = [];
ASRS_all(to_del,:) = [];

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

% scores
T_q = readtable('../../../data_analysis/10_stats/web_data_completed.xlsx');
BIS11_motor = T_q.BIS11_Motor;
BIS11_motor(to_del,:) = [];
BIS11_motor_motor = T_q.BIS11_Motor_Motor;
BIS11_motor_motor(to_del,:) = [];
BIS11_motor_perseverance = T_q.BIS11_Motor_Perseverance;
BIS11_motor_perseverance(to_del,:) = [];
ASRS_HypImp = T_q.ASRS_SumHyperImpuls;
ASRS_HypImp(to_del,:) = [];


%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,4,1);
var1 = BIS11_all(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [30,100]; 
param_bounds_var2 = [0,20];  
title_ = 'Impulsivity';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'BIS score', {'Low-value bandit frequency'})

subplot(2,4,2);
var1 = BIS11_motor(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [10,35]; 
param_bounds_var2 = [0,20];  
title_ = 'Impulsivity motor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'BIS motor subscore', {'Low-value bandit frequency'})

subplot(2,4,3);
var1 = BIS11_motor_motor(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [5,28]; 
param_bounds_var2 = [0,20];  
title_ = 'Impulsivity motor - motor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthEast', 'BIS motor subscore - motor', {'Low-value bandit frequency'})

subplot(2,4,4);
var1 = OCIR_all(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [0,70]; 
param_bounds_var2 = [0,20];  
title_ = 'OCD';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'NorthEast', 'OCIR score', {'Low-value bandit frequency'})

subplot(2,4,5);
var1 = ASRS_all(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [10,100]; 
param_bounds_var2 = [0,20];  
title_ = 'ADHD';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'e', 'NorthEast', 'ASRS score', {'Low-value bandit frequency'})

subplot(2,4,6);
var1 = ASRS_HypImp(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [5,45]; 
param_bounds_var2 = [0,20];  
title_ = 'ADHD hyper-impuls';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'f', 'NorthEast', 'ASRS hyper-impuls subscore', {'Low-value bandit frequency'})

subplot(2,4,7);
var1 = T.scores_f3;
var2 = T.pickedD_mean;
param_bounds_var1 = [-3,4]; 
param_bounds_var2 = [0,20];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'g', 'NorthEast', 'Factor score', {'Low-value bandit frequency'})

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_F3_lowTree.tif'],'-nocrop','-r200')

