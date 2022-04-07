
% Factor loadings on each item from R
T = readtable('../../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 26 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% F1
subplot(3,4,1:3)
title_ = 'Factor 1: Depression - Anxiety';
[~, ~, leg_desc]=plot_factor_loads(T.loading_F1, T.Item, title_);

% F2
subplot(3,4,5:7)
title_ = 'Factor 2: OCD - Uncertainty';
plot_factor_loads(T.loading_F2, T.Item, title_);

% F2
subplot(3,4,9:11)
title_ = 'Factor 3: Impulsivity';
[col_, col_desc]=plot_factor_loads(T.loading_F3, T.Item, title_);

% F1
subplot(3,4,[4,8,12])
for i=1:size(col_,1)
   bar(nan, nan, 'FaceColor', col_(i,:)); hold on;
end

legend(leg_desc,'Orientation','vertical', 'Position',[0.748110831234257 0.396761133603239 0.209068010075567 0.289473684210526], 'FontSize', 12)
legend boxoff;
box off;
axis off;

% %Export
% addpath('../../../export_fig')
% export_fig(['Fig_items_v3.tif'],'-nocrop','-r200')