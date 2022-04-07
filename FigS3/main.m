addpath('../fcts/')


load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

% subplot(2,2,1)
% ybounds = [4.8 7.1];
% increment = 0.5;
% signif = '***';
% hight_signif = 6.9;
% plot_EV(to_del, col_, ybounds, increment, signif, hight_signif);
% 
% subplot(2,2,2)
% ybounds = [0.2 2.2];
% increment = 0.5;
% signif = '***';
% hight_signif = 1.8;
% plot_IG(to_del, col_, ybounds, increment, signif, hight_signif);
%   
% subplot(2,2,3)
% ybounds = [4.9 6.7];
% increment = 0.5;
% signif = {'***', '***', '***'};
% hight_signif = [6.1, 6.3, 6.5];
% plot_score(to_del, col_, ybounds, increment, signif, hight_signif);

subplot(2,2,4)
ybounds = [-3.5 4.5];
increment = 2;
signif = {'***', '***', '***', '***', '***'};
hight_signif = [1.2, 1.8, 2.6, 2.6, 3.3];
plot_score_diff(to_del, col_, ybounds, increment, signif, hight_signif);

% % Export 
% addpath('../../export_fig')
% export_fig(['FigS3.png'],'-nocrop','-r200')


