
addpath('./computeCohen_d/')
close all;

%%% Data
load('../../../data_analysis/usermat_completed.mat')   
data_fold = ('../../../data/');

load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

load(strcat(data_fold, 'data_for_figs/score_desc.mat'))

b1=load(strcat(data_fold, 'data_for_figs/score_block1.mat'));
b2=load(strcat(data_fold, 'data_for_figs/score_block2.mat'));
b3=load(strcat(data_fold, 'data_for_figs/score_block3.mat'));
b4=load(strcat(data_fold, 'data_for_figs/score_block4.mat'));

score_SH = [b1.score(:,2), b2.score(:,2), b3.score(:,2), b4.score(:,2)];
first_LH = [b1.score(:,3), b2.score(:,3), b3.score(:,3), b4.score(:,3)];
score_LH = [b1.score(:,4), b2.score(:,4), b3.score(:,4), b4.score(:,4)];

% Remove ID
score_SH(to_del,:) = nan;
score_LH(to_del,:) = nan;
first_LH(to_del,:) = nan;
n = size(first_LH,1)-size(to_del,2);

x = [1:4]';
X = [ones(length(x),1) x];

for id = 1:size(score_LH,1)
    
    b_score_LH(id,:) = X\score_LH(id,:)';
    
end


% %%% Plot
% 
% % plot true values
% plot(x, nanmean(score_SH)); hold on;
% 
% % mean b0 and b1
% b0 = nanmean(b_score_LH(:,1));
% b1 = nanmean(b_score_LH(:,2));
% 
% % plot linear reg
% plot(x, b0+x*b1)
% 
% % param
% set(gca,'YTick',1:0.5:10)
% set(gca,'XTick',1:1:4)
% ylabel({'Reward'}','FontName','Arial','Fontweight','bold','FontSize',12);
% xlabel({'Block'}','FontName','Arial','Fontweight','bold','FontSize',12);
% min_ = floor(min(min([score_SH, first_LH, score_LH]))*10)/10;
% max_ = floor(max(max([score_SH, first_LH, score_LH]))*10)/10;
% ylim([min_ max_])


%%%% Stats
reward_slopes = b_score_LH(:,2);
null_slopes = zeros(size(b_score_LH,1),1);
[h,p,ci,stats] = ttest(reward_slopes,null_slopes); % paired samples t-test
d = computeCohen_d(reward_slopes,null_slopes, 'paired'); 

beta = nanmean(reward_slopes);

stats_slope = strcat('  t(',num2str(stats.df),')=',num2str(round(stats.tstat,3)),...
                     ', p=', num2str(round(p,3)),...
                     ', d=', num2str(round(d,3)),...
                     ', 95%CI=[',num2str(round(ci(1),4)),',',num2str(round(ci(2),4)),']');


