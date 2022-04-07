
load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

%%%

subplot(1,3,1)
subplot_title = 'Best fitting model';
[BIC_all] = render_model_comparison_BIC_etaB(to_del, col_, 'a', subplot_title);

%%%

subplot(1,3,2)
subplot_title = 'Best fitting model';
[n_part]=render_model_comparison_BIC_per_pp_etaB(to_del, col_, 'b', subplot_title);
  
%%%

subplot(1,3,3)
subplot_title = 'Best fitting model';
render_model_comparison_BIC_BMS_etaB(to_del, col_, 'c', subplot_title);
 
 
% %Export
% addpath('../../export_fig')
% export_fig(['FigS5_etaB.tif'],'-nocrop','-r200')


% paired t_test
x = BIC_all(:,4); % thompson+eta+xi
y = BIC_all(:,17); % thompson+eta+xi+etaB
[h,p,ci,stats] = ttest(x,y);

% correlation
load('../../data/modelfit/mod12/concatenated/model_parameters_desc.mat');
ind_xi_sh = find(strcmp(model_parameters_desc,'xi_short'));
ind_xi_lh = find(strcmp(model_parameters_desc,'xi_long'));
load('../../data/modelfit/mod12/concatenated/model_parameters.mat');
xi_mod12_sh = model_parameters(:,ind_xi_sh);
xi_mod12_lh = model_parameters(:,ind_xi_lh);

load('../../data/modelfit/mod12_etaB/concatenated/model_parameters_mod12etaB_desc.mat');
ind_xi_sh = find(strcmp(model_parameters_desc,'xi_short'));
ind_xi_lh = find(strcmp(model_parameters_desc,'xi_long'));
load('../../data/modelfit/mod12_etaB/concatenated/model_parameters_mod12etaB.mat');
xi_mod12_etaB_sh = model_parameters(:,ind_xi_sh);
xi_mod12_etaB_lh = model_parameters(:,ind_xi_lh);

[r_sh,p_sh] = corr(xi_mod12_sh,xi_mod12_etaB_sh, 'Type', 'Pearson');
[r_lh,p_lh] = corr(xi_mod12_lh,xi_mod12_etaB_lh, 'Type', 'Pearson');

% Text
strcat('paired-samples t-test: t(', num2str(stats.df), ')=', num2str(stats.tstat), ', p=', num2str(p,3), ', 95%CI=[', num2str(ci(1)), ',', num2str(ci(2)), ']')
strcat('Thompson sampling+\epsilon+\eta: Number of subjects: ',32, num2str(n_part(13)),'; Thompson sampling+\epsilon+\eta+\eta_B: Number of subjects: ', 32, num2str(n_part(16)))
strcat('correlation between \epsilon from the Thompson sampling+\epsilon+\eta model and \epsilon from the Thompson sampling+\epsilon+\eta+\eta_B model:',...
        'short horizon: r=',num2str(r_sh,3),', p=',num2str(p_sh,3),'; ',...
         'long horizon: r=',num2str(r_lh,3),', p=',num2str(p_lh,3),')')




