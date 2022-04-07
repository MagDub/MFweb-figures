
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.6278    0.1425    0.3855]; % bar
col_(2,:) = [0.3687    0.0925    0.3491]; % individual lines

subplot(1,2,1)
ybounds = [0 80];
increment = 15;
signif = '***';
hight_signif = 65;
plot_banditA(col_, ybounds, increment, signif, hight_signif);

subplot(1,2,2)
ybounds = [0 80];
increment = 15;
signif = '***';
hight_signif = 45;
plot_banditB(col_, ybounds, increment, signif, hight_signif);

% % Export
% addpath('../../../export_fig')
% export_fig(['FigS12.tif'],'-nocrop','-r200')

export_fig(['/Users/magdadubois/GoogleDrive/UCL/MFweb/figures/Fig12.png'],'-nocrop','-r200')
