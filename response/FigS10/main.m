
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1)
ybounds = [0 0.63];
increment = 0.2;
signif = {'', '', '', ''};
hight_signif = [0.44, 0.32, 0.37, 0.44];
render_mod8_epsilon(ybounds, increment, signif, hight_signif);

subplot(2,3,2)
ybounds = [0 5.2];
increment = 1;
signif = {'', '', '', ''};
hight_signif = [5.2, 4, 4, 4];
render_mod8_eta(ybounds, increment, signif, hight_signif);

subplot(2,3,3)
ybounds = [0 3.1];
increment = 1;
signif = {'', '', '', ''};
hight_signif = [5.2, 4, 4, 4];
render_mod8_gamma(ybounds, increment, signif, hight_signif);

subplot(2,3,4)
ybounds = [0 2.1];
increment = 0.5;
signif = {'', '', '', ''};
hight_signif = [5.2, 4, 4, 4];
render_mod8_tau(ybounds, increment, signif, hight_signif);

subplot(2,3,5)
ybounds = [0.5 5.5];
increment = 1;
signif = {'', '', '', ''};
hight_signif = [5.2, 4, 4, 4];
render_mod8_Q0(ybounds, increment, signif, hight_signif);

% Export
addpath('../../../export_fig')
export_fig(['FigUCB.tif'],'-nocrop','-r200')

