

data_fol = '../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');
n_sim = 100;

model_string={'mod5', 'mod6', 'mod7', 'mod8', ... % 5:8
                'mod9', 'mod10', 'mod11', 'mod12', ... % 9:12
                    'mod5_t1', 'mod6_t1', 'mod7_t1', 'mod8_t1'}; % 13:16
                
model_mat = 5:16; 

n_models = size(model_string,2);

winning_mod_mat = nan(n_sim,n_models);

perc = nan(n_models,n_models);
mean_BIC = nan(n_models,n_models);
std_BIC = nan(n_models,n_models);

for mod_n=1:n_models
    
    mod_s = model_string{mod_n};
    
    file_BIC = strcat(sim_fol,mod_s,'_normal/n_sim_',num2str(n_sim),'/results/all_BIC_mat.mat');
      
    if exist(file_BIC)

        occur = nan(1,n_models);
       
        tmp = load(file_BIC);
        
        % keep only important models
        BIC_mat = tmp.all_BIC_mat(:,model_mat);
        
        % find best models (lowest BIC) for each sim
        [min_val, ind_min_val] = min(BIC_mat');
        min_val = min_val';
        ind_min_val = ind_min_val';
        
        winning_mod_mat(:,mod_n) = ind_min_val;
        
    end

end


for mod_n_f=1:n_models
    
    [fitted,simulated]=find(winning_mod_mat==mod_n_f);
    
    for mod_n_s=1:n_models

        N_sim_mod = size(find(simulated==mod_n_s),1);
        N_fit_mod = size(simulated,1);

        perc(mod_n_s,mod_n_f)= N_sim_mod/N_fit_mod;
    
    end

end


save('./model_recov_inv.mat', 'perc');














