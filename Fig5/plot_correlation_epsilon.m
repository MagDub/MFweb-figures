load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

addpath('../FigS13')

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

%%% Plot

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(3,2,1);
var1 = T.scores_f3;
var2 = T.xi_mean;
param_bounds_var1 = [-3,4]; 
param_bounds_var2 = [0,0.52];  
title_ = 'Model parameter';
corr_string_x=0+0.7;
corr_string_y=1-0.1;
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthOutside', 'Factor score', {'\epsilon-greedy parameter'}, corr_string_x, corr_string_y);
disp('a')
disp(p)
disp(p*12)
disp('---------')

subplot(3,2,2);
var1 = T.scores_f3;
var2 = T.pickedD_mean;
param_bounds_var1 = [-3,4]; 
param_bounds_var2 = [0,22];  
title_ = 'Behaviour';
corr_string_x=0+0.7;
corr_string_y=1-0.1;
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthOutside', 'Factor score', {'Low-value bandit frequency'}, corr_string_x, corr_string_y);
disp('b')
disp(p)
disp(p*9)
disp('---------')

subplot(3,2,3);
var1 = T.scores_f1;
var2 = T.eta_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,5.2];  
title_ = 'Model parameter';
corr_string_x=0+0.7;
corr_string_y=1-0.55;
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthOutside', 'Factor score', {'Novelty bonus \eta'}, corr_string_x, corr_string_y);
disp('c')
disp(p)
disp(p*12)
disp('---------')

subplot(3,2,4);
var1 = T.scores_f1;
var2 = T.pickedC_mean;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,82];  
title_ = 'Behaviour';
corr_string_x=0+0.7;
corr_string_y=1-0.55;
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'NorthOutside', 'Factor score', {'Novel bandit frequency'}, corr_string_x, corr_string_y);
disp('d')
disp(p)
disp(p*9)
disp('---------')

annotation(f1,'textbox',...
    [0.13 0.93 0.77 0.04],...
    'String','Impulsivity factor',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);

annotation(f1,'textbox',...
    [0.13 0.62 0.77 0.04],...
    'String','Anxious-Depression factor',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);

% c_ax = [0 0.31];
% inc = 0.1;
% 
% subplot(3,2,5)
% main_mat_param_allF(c_ax, inc)
% 
% subplot(3,2,6)
% main_mat_behav_allF(c_ax, inc)
% 
% 
% %Export
% addpath('../../export_fig')
% export_fig(['Fig5.tif'],'-nocrop','-r200')

