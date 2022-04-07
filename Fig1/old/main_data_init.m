
% load
folder_ = '../../../data_analysis/other/initial_samples_data/concat_data/';
load(strcat(folder_, 'desc_split.mat'))

cond = 'ABC';
T=load(strcat(folder_,'split_mat_SH_init_',cond,'.mat'));
tmp_data = T.(strcat('split_mat_SH_init_', cond));
data_1 = tmp_data(:,[1,2,5,6]);
    
cond = 'ABD';
T=load(strcat(folder_,'split_mat_SH_init_',cond,'.mat'));
tmp_data = T.(strcat('split_mat_SH_init_', cond));
data_2 = tmp_data(:,[1,2,5,6]);

cond = 'ACD';
T=load(strcat(folder_,'split_mat_SH_init_',cond,'.mat'));
tmp_data = T.(strcat('split_mat_SH_init_', cond));
data_3 = tmp_data(:,[1,2,5,6]);

cond = 'BCD';
T=load(strcat(folder_,'split_mat_SH_init_',cond,'.mat'));
tmp_data = T.(strcat('split_mat_SH_init_', cond));
data_4 = tmp_data(:,[1,2,5,6]);

data_all = [data_1; data_2; data_3; data_4];

% remove nans
tmp = data_all(:,1);
tmp(isnan(tmp))=[];
samples(:,1) = tmp;

tmp = data_all(:,2);
tmp(isnan(tmp))=[];
samples(:,2) = tmp;

tmp = data_all(:,4);
tmp(isnan(tmp))=[];
samples(:,3) = tmp;

% plot  
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

x_values = 1:0.1:10;

y1 = pdf(fitdist(samples(:,1),'Normal'),x_values);
y2 = pdf(fitdist(samples(:,2),'Normal'),x_values);
y3 = pdf(fitdist(samples(:,3),'Normal'),x_values);

hold all;
plot(x_values,y1,'LineWidth',2); 
plot(x_values,y2,'LineWidth',2); 
plot(x_values,y3,'LineWidth',2); 
xlim([1 10])
xticks(1:10)
ylim([0 2.1])
h = gca; 
h.YAxis.Visible = 'off';
set(gca,'YTickLabel',[]);
title('Distributions of initial samples','FontSize', 16, 'FontName','Arial', 'Fontweight','normal');
xlabel('Value','FontName','Arial','Fontweight','bold','FontSize',12);

legend({'Certain-standard bandit', 'Certain bandit', 'Low-value bandit'}, 'Location','NorthWest');
legend boxoff 
hold off;


