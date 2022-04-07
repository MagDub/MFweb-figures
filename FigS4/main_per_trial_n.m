
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% param
min_ = 2.5;
max_ = 3.5;
n_trials_to_av = 20;
indexation_y = 0.3;
indexation_x = 60;

%
subplot(3,1,1)
render_score_pertrial_SH(min_, max_, indexation_y, indexation_x, n_trials_to_av);

%
subplot(3,1,2)
render_score_pertrial_LH_1st(min_, max_, indexation_y, indexation_x, n_trials_to_av);

%
subplot(3,1,3)
render_score_pertrial_LH_all(min_, max_, indexation_y, indexation_x, n_trials_to_av);

% Export
addpath('../../../export_fig')
export_fig(['FigS3_trial.tif'],'-nocrop','-r200')