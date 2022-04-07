
% Factor loadings on each item from R
T = readtable('../../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 37 25]);
set(gca,'FontName','Arial','FontSize',10);
hold on;

% F1
subplot(3,1,1)
title_ = 'Factor 1: Depression - Anxiety';
plot_factor_loads_v1(T.loading_F1, T.Item, title_);

% F2
subplot(3,1,2)
title_ = 'Factor 2: OCD - Uncertainty';
plot_factor_loads_v1(T.loading_F2, T.Item, title_);

% F2
subplot(3,1,3)
title_ = 'Factor 3: Impulsivity';
plot_factor_loads_v1(T.loading_F3, T.Item, title_);

%Export
addpath('../../../export_fig')
export_fig(['Fig_items_v1.tif'],'-nocrop','-r200')