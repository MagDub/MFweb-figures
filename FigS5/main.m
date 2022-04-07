
load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 12 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

%%%

subplot(1,1,1)
subplot_title = 'Best fitting model';
render_model_comparison_BIC(to_del, col_, 'a', subplot_title);

% %%%
% 
% subplot(1,3,2)
% subplot_title = 'Best fitting model';
% render_model_comparison_BIC_per_pp(to_del, col_, 'b', subplot_title);
% 
% %%%
% 
% subplot(1,3,3)
% subplot_title = 'Best fitting model';
% render_model_comparison_BIC_BMS(to_del, col_, 'c', subplot_title);


%Export
addpath('../../export_fig')
export_fig(['FigS5_2.tif'],'-nocrop','-r200')
