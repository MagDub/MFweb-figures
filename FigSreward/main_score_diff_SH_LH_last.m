close all;

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

x_ax = 0:0.4:4;

% Figure
col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

x_ax = 0:0.5:4;

% plot bars
ph = plot_score_bars_2(score_H(:,2)-score_H(:,3), score_H(:,14)-score_H(:,6), [3,7]-1, x_ax, 0.05);
pc = plot_score_bars_2(score_C(:,2)-score_C(:,3), score_C(:,14)-score_C(:,6), [4,8]-1, x_ax, 0.4);
pd = plot_score_bars_2(score_D(:,2)-score_D(:,3), score_D(:,14)-score_D(:,6), [5,9]-1, x_ax, 0.8);

tmp = [score_H(:,2)-score_H(:,3), score_C(:,2)-score_C(:,3), score_D(:,2)-score_D(:,3), ...
        score_H(:,14)-score_H(:,6), score_C(:,14)-score_C(:,6), score_D(:,14)-score_D(:,6)];

legend([ph, pc, pd], {'High-value bandit', 'Novel bandit', 'Low-value bandit'},'Orientation','vertical', ...
                        'Position',[0.15 0.77 0.33 0.18])
legend boxoff;

xlim([x_ax(1) x_ax(end)])   
set(gca,'XTick',[x_ax(3) x_ax(7)])
xtickangle(0);
labels = {strcat(32,32,32,32,'Reward \newlineshort horizon'),'  Last reward \newline long horizon'};
a = gca;
a.XTickLabel = labels;

ylabel({'Reward difference';' (w.r.t. best initial sample)'},'FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',-10:1:10)

max_y = 2.5; 
min_y = -2.5;

ylim([min_y max_y])

% Export
addpath('../../export_fig')
export_fig(['Fig_score_diff_SH_LH_last.tif'],'-nocrop','-r200')


