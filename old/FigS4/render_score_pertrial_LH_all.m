function [] = render_score_pertrial_LH_all()

    data_fold = ('../../../data/');
    dir_ = (strcat(data_fold,'data_for_figs/'));

    %%% Load data

    load('../../../data_analysis/usermat_completed.mat')

    LH_all_desc = load(strcat(dir_, 'per_trial_score_LH_all_desc.mat'));
    LH_all = load(strcat(dir_, 'per_trial_score_LH_all.mat'));
    score_LH = LH_all.per_trial_score(:,2:end);

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);

    score_LH(to_del,:) = nan;

    %%% Concat

    n_part = size(score_LH,1)-size(to_del,2);
    n_trials = size(score_LH,2);

    mean_LH_all = nanmean(score_LH,1);
    sem_LH_all = nanstd(score_LH,1)/sqrt(n_part);
    
    [beta_all_LH, stats_slope] = fct_compute_coeff(score_LH, n_trials);
    
    disp('Block - All LH')
    disp(stats_slope)
    disp('--------------')

    %%% Plot

    fct_plot_score(n_trials, mean_LH_all, beta_all_LH, {'Long horizon','average sample'}, 'f', 'NorthWest')

end

