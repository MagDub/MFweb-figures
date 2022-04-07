
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,1,1)
render_score_LH_RT();

% Export
addpath('../../../export_fig')
export_fig(['Fig_RT_LH.tif'],'-nocrop','-r200')
