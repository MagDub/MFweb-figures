function [b, stats_slope] = fct_compute_coeff(data_, n_trials)

    % Linear regression
    % score(=y) = bo + b1 * trial(=x)
    % Y = XB 
    % B = X\Y (mldivide operator = solves linear equation)
    
    x = (1:n_trials)';
    X = [ones(length(x),1) x]; % to have 2 coeff
    y = data_';
    b = X\y;
    
    %%%% Stats
    reward_slopes = b(2,:);
    null_slopes = zeros(size(reward_slopes));
    [h,p,ci,stats] = ttest(reward_slopes,null_slopes); % paired samples t-test
    d = computeCohen_d(reward_slopes,null_slopes, 'paired'); 

    stats_slope = strcat('  t(',num2str(stats.df),')=',num2str(round(stats.tstat,3)),...
                         ', p=', num2str(round(p,3)),...
                         ', d=', num2str(round(d,3)),...
                         ', 95%CI=[',num2str(round(ci(1),4)),',',num2str(round(ci(2),4)),']');

end

