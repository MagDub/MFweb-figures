
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 28 12]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,2,1)
render_param_recovery();

subplot(1,2,2)
text(0-0.15, 1+0.15,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
t=title('Model recovery','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');


% Export
addpath('../../../export_fig')
export_fig(['FigS6.tif'],'-nocrop','-r200')
