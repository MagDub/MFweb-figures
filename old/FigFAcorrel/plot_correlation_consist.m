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
BIS11_all(to_del,:) = [];
OCIR_all(to_del,:) = [];

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
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1);
var1 = OCIR_all(:,1);
var2 = T.consistent_mean;
param_bounds_var1 = [0,70]; 
param_bounds_var2 = [25,70];  
title_ = 'OCD';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'SouthEast', 'OCIR score', {'Consistency [%]'})

subplot(2,3,2);
var1 = BIS11_motor(:,1);
var2 = T.consistent_mean;
param_bounds_var1 = [10,35]; 
param_bounds_var2 = [25,70];  
title_ = 'Impulsivity - motor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'SouthEast', 'BIS motor subscore', {'Consistency [%]'})

subplot(2,3,3);
var1 = BIS11_motor_motor(:,1);
var2 = T.consistent_mean;
param_bounds_var1 = [5,28]; 
param_bounds_var2 = [25,70];   
title_ = 'Impulsivity motor - motor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'SouthEast', 'BIS motor subscore - motor', {'value-free','random exploration'})

subplot(2,3,4);
var1 = ASRS_HypImp(:,1);
var2 = T.consistent_mean;
param_bounds_var1 = [5,45]; 
param_bounds_var2 = [25,70];  
title_ = 'ADHD hyper-impuls';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'SouthEast', 'ASRS hyper-impuls subscore', {'Consistency [%]'})

subplot(2,3,5);
var1 = T.scores_f3;
var2 = T.consistent_mean;
param_bounds_var1 = [-3,4]; 
param_bounds_var2 = [25,70];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'e', 'SouthEast', 'Factor score', {'Consistency [%]'})

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_F3_consist.tif'],'-nocrop','-r200')

