
load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

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

subplot(1,3,1)
ybounds = [0 100];
increment = 20;
signif = '***';
hight_signif = 80;
plot_high_value(to_del, col_, ybounds, increment, signif, hight_signif);

subplot(1,3,2)
ybounds = [0 100];
increment = 20;
signif = '***';
hight_signif = 65;
plot_novel_value(to_del, col_, ybounds, increment, signif, hight_signif);
 
subplot(1,3,3)
ybounds = [0 30];
increment = 10;
signif = '***';
hight_signif = 15;
plot_low_value(to_del, col_, ybounds, increment, signif, hight_signif);

%Export
addpath('../../../export_fig')
export_fig(['Fig5.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig5.png'],'-nocrop','-r200')
