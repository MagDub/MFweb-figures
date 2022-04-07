
% Factor loadings on each item from R
T = readtable('../../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 28 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% F1
subplot(3,1,1)
title_ = 'Factor 1: Depression - Anxiety';
plot_factor_loads(T.loading_F1, T.Item, title_);

% F2
subplot(3,1,2)
title_ = 'Factor 2: OCD - Uncertainty';
plot_factor_loads(T.loading_F2, T.Item, title_);

% F2
subplot(3,1,3)
title_ = 'Factor 3: Impulsivity';
plot_factor_loads(T.loading_F3, T.Item, title_);

% Create textbox
xpos=0.11;
ypos=0.041;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Impulsivity'},'FitBoxToText','on');
xpos=xpos+0.085;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'ADHD'},'FitBoxToText','on');
xpos=xpos+0.06;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Autism'},'FitBoxToText','on');
xpos=xpos+0.064;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Cognitive flexibility'},'FitBoxToText','on');
xpos=xpos+0.13;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'OCD'},'FitBoxToText','on');
xpos=xpos+0.052;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Depression'},'FitBoxToText','on');
xpos=xpos+0.088;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Trait Anxiety'},'FitBoxToText','on');
xpos=xpos+0.0945;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Uncertainty intolerance'},'FitBoxToText','on');
xpos=xpos+0.155;
annotation(f1,'textbox',[xpos ypos 0.01 0.01],'String',{'Social Anxiety'},'FitBoxToText','on');

%Export
addpath('../../../export_fig')
export_fig(['Fig_items_v2.tif'],'-nocrop','-r200')