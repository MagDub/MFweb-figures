
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1)
ybounds = [0 0.7];
increment = 0.2;
signif = {'', '', '', ''};
hight_signif = [0.44, 0.32, 0.37, 0.44];
render_epsilonB(ybounds, increment, signif, hight_signif);

subplot(1,2,2)
ybounds = [0 5.4];
increment = 1;
signif = {'', '', '', ''};
hight_signif = [0.44, 0.32, 0.37, 0.44];
render_etaB(ybounds, increment, signif, hight_signif);


% % Export
% addpath('../../export_fig')
% export_fig(['FigUCB.tif'],'-nocrop','-r200')

