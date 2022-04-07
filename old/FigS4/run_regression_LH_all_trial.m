
addpath('./computeCohen_d/')
close all;

%%% Data
load('../../../data_analysis/usermat_completed.mat')   
data_fold = ('../../../data/');

tmp_desc=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH_desc.mat'));

tmpSH=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH.mat'));
tmpLHall=load(strcat(data_fold, 'data_for_figs/per_trial_score_LH_all.mat'));
tmpLH1st=load(strcat(data_fold, 'data_for_figs/per_trial_score_LH_1st.mat'));

score_SH = tmpSH.per_trial_score(:,2:end);
first_LH = tmpLHall.per_trial_score(:,2:end);
score_LH = tmpLH1st.per_trial_score(:,2:end);

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
score_SH(to_del,:) = nan;
score_LH(to_del,:) = nan;
first_LH(to_del,:) = nan;
n = size(first_LH,1)-size(to_del,2);

x = [1:200]';
X = [ones(length(x),1) x];

for id = 1:size(score_LH,1)
    
    t_score_LH(id,:) = X\score_LH(id,:)';
    
end


% %%% Plot
% 
% % plot true values
% plot(x, nanmean(score_SH)); hold on;
% 
% % mean b0 and b1
% b0 = nanmean(t_score_LH(:,1));
% b1 = nanmean(t_score_LH(:,2));
% 
% % plot linear reg
% plot(x, b0+x*b1)
% 
% % param
% set(gca,'YTick',1:0.5:10)
% set(gca,'XTick',1:1:400)
% ylabel({'Reward'}','FontName','Arial','Fontweight','bold','FontSize',12);
% xlabel({'Block'}','FontName','Arial','Fontweight','bold','FontSize',12);
% min_ = floor(min(min([score_SH, first_LH, score_LH]))*10)/10;
% max_ = floor(max(max([score_SH, first_LH, score_LH]))*10)/10;
% ylim([min_ max_])


%%%% Stats
reward_slopes = t_score_LH(:,2);
null_slopes = zeros(size(t_score_LH,1),1);
[h,p,ci,stats] = ttest(reward_slopes,null_slopes); % paired samples t-test
d = computeCohen_d(reward_slopes,null_slopes, 'paired'); 

stats_slope = strcat('  t(',num2str(stats.df),')=',num2str(round(stats.tstat,3)),...
                     ', p=', num2str(round(p,3)),...
                     ', d=', num2str(round(d,3)),...
                     ', 95%CI=[',num2str(round(ci(1),4)),',',num2str(round(ci(2),4)),']')


