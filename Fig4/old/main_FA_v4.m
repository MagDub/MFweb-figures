
load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% FA
T2 = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

% Factor loadings on each item from R
T = readtable('../../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 27 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% F1
subplot(4,4,1:3)
title_ = 'Factor 1: Depression - Anxiety';
[~, ~, leg_desc]=plot_factor_loads(T.loading_F1, T.Item, title_, 'a');

% F2
subplot(4,4,5:7)
title_ = 'Factor 2: Certainty seeking';
plot_factor_loads(T.loading_F2, T.Item, title_, '');

% F3
subplot(4,4,9:11)
title_ = 'Factor 3: Impulsivity';
[col_, col_desc]=plot_factor_loads(T.loading_F3, T.Item, title_, '');

% correlations
max_1 = 2.8;
max_2 = 3.72;

subplot(3,4,4);
var1 = T2.scores_f1;
var2 = T2.scores_f2;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2]; 
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', [0.784260516288505 0.716599191793466 0.130257801899593 0.048582995951417], 'Depression-Anxiety', 'Certainty seeking')

subplot(3,4,8);
var1 = T2.scores_f1;
var2 = T2.scores_f3;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2];
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', [0.782903664185384 0.417004050093061 0.130257801899593 0.048582995951417], 'Depression-Anxiety', 'Impulsivity')

subplot(3,4,12);
var1 = T2.scores_f2;
var2 = T2.scores_f3;
param_bounds_var1 = [-max_1,max_2];
param_bounds_var2 = [-max_1,max_2];
title_ = '';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', [0.769335143154177 0.117408908392656 0.141112618724559 0.048582995951417], 'Certainty seeking', 'Impulsivity')

% legend
subplot(8,4,25:27)
for i=1:5
   bar(nan, nan, 'FaceColor', col_(i,:)); hold on;
end

legend(leg_desc(1:5),'Orientation','horizontal', 'Location','SouthWestOutside', 'FontSize', 10)
legend boxoff;
box off;
axis off;

subplot(8,4,29:31)
for i=6:9
   bar(nan, nan, 'FaceColor', col_(i,:)); hold on;
end

legend(leg_desc(6:9),'Orientation','horizontal', 'Location','NorthWestOutside', 'FontSize', 10)
legend boxoff;
box off;
axis off;

%Export
addpath('../../../export_fig')
export_fig(['Fig_items_v4.tif'],'-nocrop','-r200')


% 1   2  3  4 
% 5   6  7  8
% 9  10 11 12
% 13 14 15 16
% 17 18 19 20
% 21 22 23 24 
% 25 26 27 28 
% 29 30 31 32
