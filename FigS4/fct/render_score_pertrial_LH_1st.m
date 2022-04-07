function [] = render_score_pertrial_LH_1st(to_del)

    data_fold = ('../../data/');
    dir_ = (strcat(data_fold,'data_for_figs/'));

    %%% Load data

    load('../../data_analysis/usermat_completed.mat')

    LH_1st_desc = load(strcat(dir_, 'per_trial_score_LH_1st_desc.mat'));
    LH_1st = load(strcat(dir_, 'per_trial_score_LH_1st.mat'));
    first_LH = LH_1st.per_trial_score(:,2:end);

    % Remove ID
    first_LH(to_del,:) = nan;

    %%% Concat

    n_part = size(first_LH,1)-size(to_del,2);
    n_trials = size(first_LH,2);

    mean_LH_1st = nanmean(first_LH,1);
    sem_LH_1st = nanstd(first_LH,1)/sqrt(n_part);
    
    [beta_first_LH, stats_slope] = fct_compute_coeff(first_LH, n_trials);
    
    disp('Trial - 1st LH')
    disp(stats_slope)
    disp('--------------')

    %%% Plot

    fct_plot_score(n_trials, mean_LH_1st, beta_first_LH, {'Long horizon','1st sample'}, 'e', 'NorthWest')

end

