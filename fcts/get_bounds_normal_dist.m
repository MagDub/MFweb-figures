function [ci_low, ci_upp, mean_] = get_bounds_normal_dist(data_)

    mean_ = nanmean(data_);
    
    ci = paramci(fitdist(data_,'Normal'));
    ci_mean = ci(:,1);
    ci_std = ci(:,2);
    
    ci_low = ci_mean(1)-mean_;
    ci_upp = ci_mean(2)-mean_;

end

