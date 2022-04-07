function [] = render_score_pertrial_SH_1st(to_del)

    data_fold = ('../../data/');
    dir_ = (strcat(data_fold,'data_for_figs/'));

    %%% Load data

    load('../../data_analysis/usermat_completed.mat')

    SH_desc = load(strcat(dir_, 'per_trial_score_SH_desc.mat'));
    SH = load(strcat(dir_, 'per_trial_score_SH.mat'));
    score_SH = SH.per_trial_score(:,2:end);

    % Remove ID
    score_SH(to_del,:) = nan;

    %%% Concat

    n_part = size(score_SH,1)-size(to_del,2);
    n_trials = size(score_SH,2);

    mean_SH = nanmean(score_SH,1);
    sem_SH = nanstd(score_SH,1)/sqrt(n_part);
    
    [beta_SH, stats_slope] = fct_compute_coeff(score_SH, n_trials);
    
    disp('Trial - SH')
    disp(stats_slope)
    disp('--------------')

    %%% Plot

    fct_plot_score(n_trials, mean_SH, beta_SH, {'Short horizon'}, 'd', 'NorthWest')

end

