load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% FA
T = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

max_1 = 2.8;
max_2 = 3.72;

subplot(2,4,1);
var1 = T.scores_f1;
var2 = T.scores_f2;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2]; 
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'SouthEast', 'Depression-Anxiety', 'OCD-Uncertainty')

subplot(2,4,2);
var1 = T.scores_f1;
var2 = T.scores_f3;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2];
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'SouthEast', 'Depression-Anxiety', 'Impulsivity')

subplot(2,4,3);
var1 = T.scores_f2;
var2 = T.scores_f3;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2];
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'SouthEast', 'OCD-Uncertainty', 'Impulsivity')

% %Export
% addpath('../../../export_fig')
% export_fig(['FigFAcorrel_factors.tif'],'-nocrop','-r200')

