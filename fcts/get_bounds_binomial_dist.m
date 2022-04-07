function [ci_low, ci_upp, mean_] = get_bounds_binomial_dist(data_)
    
    d = fitdist(data_/100,'Binomial');
    
    ci = paramci(d);
    ci_N = ci(:,1);
    ci_p = ci(:,2); % probability of success
    
    mean_ = d.p*100;
    
    ci_low = ci_p(1)*100-mean_;
    ci_upp = ci_p(2)*100-mean_;

end

