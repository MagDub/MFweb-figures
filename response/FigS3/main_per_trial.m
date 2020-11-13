
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(3,1,1)
min_ = 0.5;
max_ = 6.5;
indexation_ = 2;
render_score_pertrial_SH(min_, max_, indexation_);

subplot(3,1,2)
min_ = 0.5;
max_ = 6.5;
indexation_ = 2;
render_score_pertrial_LH_1st(min_, max_, indexation_);

subplot(3,1,3)
min_ = 0.5;
max_ = 6.5;
indexation_ = 2;
render_score_pertrial_LH_all(min_, max_, indexation_);

% % Export
% addpath('../../../export_fig')
% export_fig(['FigS3_trial.tif'],'-nocrop','-r200')