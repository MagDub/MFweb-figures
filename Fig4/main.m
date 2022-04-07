
addpath('../cmocean/')
cmap=cmocean('matter');


load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% FA
T2 = readtable('../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

% Factor loadings on each item from R
T = readtable('../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 26 22]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% F1
subplot(4,2,1)
title_ = 'Factor 1: Anxious-Depression';
[~, ~, leg_desc]=plot_factor_loads(T.loading_F1, T.Item, title_, 'a');

% F2
subplot(4,2,3)
title_ = 'Factor 2: Uncertainty-related distress';
plot_factor_loads(T.loading_F2, T.Item, title_, '');

% F3
subplot(4,2,5)
title_ = 'Factor 3: Impulsivity';
[col_, col_desc]=plot_factor_loads(T.loading_F3, T.Item, title_, '');

% Items string

subplot(4,2,2);
render_items_text('loading_F1')

subplot(4,2,4);
render_items_text('loading_F2')

subplot(4,2,6);
render_items_text('loading_F3')

% legend
subplot(8,2,13:14)
for i=1:7
   b=bar(nan, nan, 'FaceColor', col_(i,:)); hold on;
end

legend(leg_desc(1:7),'Orientation','horizontal', 'Location','SouthWestOutside', 'FontSize', 10)
legend boxoff;
box off;
axis off;
b.ShowBaseLine='off';

subplot(8,2,15:16)
for i=8:9
   b=bar(nan, nan, 'FaceColor', col_(i,:)); hold on;
end

legend(leg_desc(8:9),'Orientation','horizontal', 'Location','NorthWestOutside', 'FontSize', 10)
legend boxoff;
box off;
axis off;
b.ShowBaseLine='off';


annotation(f1,'textbox',...
    [0.07 0.98 0.06 0.03],...
    'String','a','FontSize', 26, ...
    'FitBoxToText','on', 'EdgeColor', 'w');

annotation(f1,'textbox',...
    [0.46 0.98 0.06 0.03],...
    'String','b','FontSize', 26, ...
    'FitBoxToText','on', 'EdgeColor', 'w');
 
%Export
addpath('../../export_fig')
export_fig(['Fig4.tif'],'-nocrop','-r200')

% 1   2  
% 3   4
% 5   6
% 7   8
% 9   10
% 11  12
% 13  14
% 15  16
