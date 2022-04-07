addpath('../fcts/')

load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

%%% Behaviour

subplot(1,7,1)
ybounds = [0 100];
% increment = 20;
signif = '***';
hight_signif = 80;
x_tick_ = strcat('High-value \newline', 32, 32, 32, 'bandit');
plot_high_value_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);

% subplot(1,7,2)
% ybounds = [0 100];
% increment = 20;
% signif = '***';
% hight_signif = 65;
% x_tick_ = strcat(32, 'Novel \newline', 32, 'bandit');
% plot_novel_value_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
%  
% subplot(1,7,3)
% ybounds = [0 25];
% increment = 5;
% signif = '***';
% hight_signif = 15;
% x_tick_ = strcat(32, 32, 32, 'Low-value \newline', 32,32,32,32,32,32, 'bandit');
% plot_low_value_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
% 
% text(0-3, 1+0.37,'Behaviour','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 22)
% 
% 
% %%% Model parameters
% 
% subplot(1,7,5)
% ybounds = [0 0.5];
% increment = 0.1;
% signif = '***';
% hight_signif = 0.35;
% x_tick_ = strcat(32, '\fontsize{14} \epsilon{\fontsize{12}-greedy} \newline', 32, '{\fontsize{12}parameter}');
% %title(['\fontsize{22} \epsilon{\fontsize{18}-greedy parameter}'],'interpreter','tex','Fontweight','normal','FontName','Arial');
% plot_param_mod12_epsilon_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
% 
% subplot(1,7,6)
% ybounds = [0 5.2];
% increment = 1;
% signif = '***';
% hight_signif = 4;
% x_tick_ = strcat(32, '{\fontsize{12}Novelty}\newline', '\fontsize{12}bonus {\fontsize{14}\eta}');
% plot_param_mod12_eta_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
%  
% subplot(1,7,7)
% ybounds = [0 2.5];
% increment = 0.5;
% signif = '***';
% hight_signif = 2;
% x_tick_ = strcat(32, 32, 32, 32, 32, 'Prior \newline', 'variance \sigma_0');
% plot_param_mod12_sgm0_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
% 
% % subplot(1,7,8)
% % ybounds = [0.8 8];
% % increment = 2;
% % signif = '***';
% % hight_signif = 2;
% % x_tick_ = strcat(32, 32, 32, 32, 'Prior \newline', 32,'mean Q_0');
% % plot_param_mod12_Q0_2(to_del, col_, ybounds, increment, signif, hight_signif, x_tick_);
% 
% text(0-3, 1+0.37,'Model parameters','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 22)
% 
% %Export
% addpath('../../export_fig')
% export_fig(['Fig2.tif'],'-nocrop','-r200')

