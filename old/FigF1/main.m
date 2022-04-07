
addpath('../fcts/')

% For exclusion
load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Load data
T1 = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');
T2 = readtable('../../../data_analysis/10_stats/web_data_completed.xlsx');

age = T2.age;
age(to_del) = [];

IQ = T2.IQscore;
IQ(to_del) = [];

f_anxiety = T1.scores_f1;

eta = T1.eta_mean;
eta_SH = T1.eta_SH;
eta_LH = T1.eta_LH;

score_SH = T1.average_first_apple_SH ;
score_LH_1 = T1.average_first_apple_LH ;
score_LH_all = T1.average_all_apple_LH;

% % correlation eta f1
[r,p] = corr(eta, f1);
[r_SH,p_SH] = corr(eta_SH, f1);
[r_LH,p_LH] = corr(eta_LH, f1);
T_eta_f1 = table([r, r_SH, r_LH]',[p, p_SH, p_LH]', ...
    'VariableNames',{'R' 'pval'},...
    'RowNames',{'eta_mean' 'eta_SH' 'eta_LH'});

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1);
var1 = f1;
var2 = eta;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,5];  
title_ = 'F1 and mean \eta correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'Anxious-depression factor', {'mean \eta'})

subplot(1,3,2);
var1 = f1;
var2 = eta_SH;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,5];  
title_ = 'F1 and SH \eta correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'Anxious-depression factor', {'Short horizon \eta'})

subplot(1,3,3);
var1 = f1;
var2 = eta_LH;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [0,5];  
title_ = 'F1 and LH \eta correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthEast', 'Anxious-depression factor', {'Long horizon \eta'})

%Export
addpath('../../../export_fig')
export_fig(['Fig_corr_f1_eta.tif'],'-nocrop','-r200')



% correlation score f1
[r_SH,p_SH] = corr(score_SH, f1);
[r_LH_1,p_LH_1] = corr(score_LH_1, f1);
[r_LH_all,p_LH_all] = corr(score_LH_all, f1);
T_score_f1 = table([r_SH, r_LH_1, r_LH_all]',[p_SH, p_LH_1, p_LH_all]', ...
    'VariableNames',{'R' 'pval'},...
    'RowNames',{'score_SH' 'score_LH_1' 'score_LH_all'});

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1);
var1 = f1;
var2 = score_SH;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [5.2,6.6];  
title_ = 'F1 and SH score correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthEast', 'Anxious-depression factor', {'Short horizon score'})

subplot(1,3,2);
var1 = f1;
var2 = score_LH_1;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [5.2,6.6];  
title_ = 'F1 and LH 1st score correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthEast', 'Anxious-depression factor', {'Long horizon 1st score'})

subplot(1,3,3);
var1 = f1;
var2 = score_LH_all;
param_bounds_var1 = [-3,3]; 
param_bounds_var2 = [5.2,6.6];  
title_ = 'F1 and LH mean score correl';
render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'SouthEast', 'Anxious-depression factor', {'Long horizon mean score'})

%Export
addpath('../../../export_fig')
export_fig(['Fig_corr_f1_score.tif'],'-nocrop','-r200')

% median split

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

[f_anxiety_sorted, f_anxiety_sorted_ind] = sort(f_anxiety, 'ascend');
Nmed = size(f_anxiety_sorted_ind,1)/2;

subplot(1,3,1);
meas_low = score_SH(f_anxiety_sorted_ind(1:Nmed));
meas_high = score_SH(f_anxiety_sorted_ind(Nmed+1:end));
y_label_ = 'score SH';
plot_bar(meas_low, meas_high, y_label_)

subplot(1,3,2);
meas_low = score_LH_1(f_anxiety_sorted_ind(1:Nmed));
meas_high = score_LH_1(f_anxiety_sorted_ind(Nmed+1:end));
y_label_ = 'score LH 1st';
plot_bar(meas_low, meas_high, y_label_)

subplot(1,3,3);
meas_low = score_LH_all(f_anxiety_sorted_ind(1:Nmed));
meas_high = score_LH_all(f_anxiety_sorted_ind(Nmed+1:end));
y_label_ = 'score LH all';
plot_bar(meas_low, meas_high, y_label_)

%Export
addpath('../../../export_fig')
export_fig(['Fig_f1_med_split_score.tif'],'-nocrop','-r200')





