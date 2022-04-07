close all;

% D:\MFweb\data_analysis\5_concatBehav/main_score_pertree

addpath('../fcts/')

% Data
dir_ = '../../data/data_for_figs/';

load(strcat(dir_, 'score_desc.mat'))
load(strcat(dir_, 'score_A.mat'))
load(strcat(dir_, 'score_B.mat'))
load(strcat(dir_, 'score_C.mat'))
load(strcat(dir_, 'score_D.mat'))
load(strcat(dir_, 'score_H.mat'))
load(strcat(dir_, 'score_M.mat'))

load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 12 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Remove ID
score_A(to_del,:) = [];
score_B(to_del,:) = [];
score_H(to_del,:) = [];
score_M(to_del,:) = [];
score_C(to_del,:) = [];
score_D(to_del,:) = [];

%
numel_n = size(score_H,1);

score_diff_D = [score_D(:,5), score_D(:,10:14)] - score_D(:,6);
score_diff_H = [score_H(:,5), score_H(:,10:14)] - score_H(:,6);
score_diff_C = [score_C(:,5), score_C(:,10:14)] - score_C(:,6);

MarkerSize_ = 100;
alpha_ = 0.7;

col_1 = [0, 0.4470, 0.7410];
col_2 = [0.4660, 0.6740, 0.1880];
col_3 = [0.8500, 0.3250, 0.0980];

plot(1:6, score_diff_H, 'Color',[col_1 0.05]); hold on;
plot(1:6, score_diff_C, 'Color',[col_2 0.05]); hold on;
plot(1:6, score_diff_D, 'Color',[col_3 0.05]); hold on;

ph = plot(1:6, nanmean(score_diff_H), 'Color',[col_1 1], 'LineWidth',2); hold on;
pc = plot(1:6, nanmean(score_diff_C), 'Color',[col_2 1], 'LineWidth',2); hold on;
pd = plot(1:6, nanmean(score_diff_D), 'Color',[col_3 1], 'LineWidth',2); hold on;

scatter(1:6, nanmean(score_diff_H), MarkerSize_, col_1, 'filled', 'MarkerFaceAlpha', alpha_); 
scatter(1:6, nanmean(score_diff_C), MarkerSize_, col_2, 'filled', 'MarkerFaceAlpha', alpha_); 
scatter(1:6, nanmean(score_diff_D), MarkerSize_, col_3, 'filled', 'MarkerFaceAlpha', alpha_); 

legend([ph, pc, pd], {'High-value bandit', 'Novel bandit', 'Low-value bandit'},'Orientation','vertical', ...
                        'Location','NorthEast')
legend boxoff;

ylim([-3,3])

ylabel({'Reward difference';' (w.r.t. best initial sample)'},'FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',-10:1:10)
 
xlabel({'Sample'},'FontName','Arial','Fontweight','bold','FontSize',12);

% Export
addpath('../../export_fig')
export_fig(['Fig_score_perB_diff_per_sample_mean.tif'],'-nocrop','-r200')



