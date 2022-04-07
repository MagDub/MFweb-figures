

data_fol = '../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');
n_sim = 100;

model_mat = [9,5,10,6,11,7,12,8];
n_models = size(model_mat,2);

perc = nan(n_models,n_models);
mean_BIC = nan(n_models,n_models);
std_BIC = nan(n_models,n_models);

for mod_n=1:n_models
    
    mod = model_mat(mod_n);
    
    if mod == 8
       file_BIC = strcat(sim_fol,'mod',num2str(mod),'_normal_Q0fixed_gamma_0_0.5_tau_20_70_sgm0_1_300_Q055_sgm014_newB/n_sim_',num2str(n_sim),'/results/all_BIC_mat.mat');
    else
       file_BIC = strcat(sim_fol,'mod',num2str(mod),'_normal/n_sim_',num2str(n_sim),'/results/all_BIC_mat.mat');
    end
    
    if exist(file_BIC)

        occur = nan(1,n_models);
       
        tmp = load(file_BIC);
        
        % keep only important models
        BIC_mat = tmp.all_BIC_mat(:,model_mat);
        
        % find best models (lowest BIC) for each sim
        [min_val, ind_min_val] = min(BIC_mat');
        min_val = min_val';
        ind_min_val = ind_min_val';
        
        % count occurences of each model
        uv = unique(ind_min_val);
        n  = histc(ind_min_val,uv);
        occur(:,[uv]) = n; 
        
        % compute percentage
        perc(mod_n,:) = occur/n_sim;
        
    end

end

save('./model_recov_conf.mat', 'perc');

