data_fold = ('../../../data/');
load('../../../data_analysis/usermat_completed.mat')  

tmp_desc=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH_desc.mat'));
tmpSH=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH.mat'));

score_SH = tmpSH.per_trial_score(:,2:end);

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
score_SH(to_del,:) = nan;
n = size(score_SH,1)-size(to_del,2);

n_trials = 200;

%% (a) SH - run regression SH trial

% betas
x = [1:n_trials]';
X = [ones(length(x),1) x];

for id = 1:size(score_SH,1)
    
    beta_SH_1(id,:) = X\score_SH(id,:)';
    
end


%% (d) render_score_pertrial_SH_1st, fct_plot_score

%%% Load data

beta_SH_2 = fct_compute_coeff(tmpSH.per_trial_score(:,2:end), n_trials);