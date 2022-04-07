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
ASRS_all(to_del,:) = [];

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

var1 = T.scores_f3;
var2 = T.xi_mean;
param_bounds_var1 = [-3,4]; 
param_bounds_var2 = [0,0.5];  
title_ = 'Impulsivity factor';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, '', 'NorthEast', 'Factor score', {'\epsilon-greedy parameter'})

%Export
addpath('../../../export_fig')
export_fig(['Fig_correl_epsilon_F1.tif'],'-nocrop','-r200')

