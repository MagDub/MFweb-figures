
addpath('./fct/')
addpath('./computeCohen_d/')

load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1)
render_score_perblock_SH(to_del);

subplot(2,3,2)
render_score_perblock_LH_1st(to_del);

subplot(2,3,3)
p=render_score_perblock_LH_all(to_del);
disp('c')
disp(p)
disp('---------')
 
subplot(2,3,4)
render_score_pertrial_SH_1st(to_del);

subplot(2,3,5)
render_score_pertrial_LH_1st(to_del);

subplot(2,3,6)
p=render_score_pertrial_LH_all(to_del);
disp('f')
disp(p)
disp('---------')
 
% % Export
% addpath('../../export_fig')
% export_fig(['FigS4.tif'],'-nocrop','-r200')
