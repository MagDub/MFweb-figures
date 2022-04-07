load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../data/questionnaire/all/BIS11_all.mat')
load('../../data/questionnaire/all/OCIR_all.mat')
load('../../data/questionnaire/all/ASRS_all.mat')
BIS11_all(to_del,:) = [];
ASRS_all(to_del,:) = [];

% FA
T = readtable('../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');

%%% Plot

f1=figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,4,1);
var1 = BIS11_all(:,1);
var2 = T.xi_mean;
param_bounds_var1 = [30,100]; 
param_bounds_var2 = [0,0.5];  
title_ = 'Model parameter';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'a', 'NorthOutside', 'BIS score', {'\epsilon-greedy parameter'});
disp('a')
disp(p)
disp('---------')

subplot(2,4,2);
var1 = BIS11_all(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [30,100]; 
param_bounds_var2 = [0,20];  
title_ = 'Behaviour';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'b', 'NorthOutside', 'BIS score', {'Low-value bandit frequency'});
disp('b')
disp(p)
disp('---------')


subplot(2,4,3);
var1 = BIS11_all(:,3); % motor
var2 = T.xi_mean;
param_bounds_var1 = [10,35]; 
param_bounds_var2 = [0,0.5];  
title_ = 'Model parameter';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'c', 'NorthOutside', 'BIS motor subscore', {'\epsilon-greedy parameter'});
disp('c')
disp(p)
disp(p*3)
disp('---------')


subplot(2,4,4);
var1 = BIS11_all(:,3);
var2 = T.pickedD_mean;
param_bounds_var1 = [10,35]; 
param_bounds_var2 = [0,20];  
title_ = 'Behaviour';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'd', 'NorthOutside', 'BIS motor subscore', {'Low-value bandit frequency'});
disp('d')
disp(p)
disp(p*3)
disp('---------')



subplot(2,4,5);
var1 = ASRS_all(:,1);
var2 = T.xi_mean;
param_bounds_var1 = [10,100]; 
param_bounds_var2 = [0,0.5];  
title_ = 'Model parameter';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'e', 'NorthOutside', 'ASRS score', {'\epsilon-greedy parameter'});
disp('e')
disp(p)
disp('---------')

 
subplot(2,4,6);
var1 = ASRS_all(:,1);
var2 = T.pickedD_mean;
param_bounds_var1 = [10,100]; 
param_bounds_var2 = [0,20];  
title_ = 'Behaviour';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'f', 'NorthOutside', 'ASRS score', {'Low-value bandit frequency'});
disp('f')
disp(p)
disp('---------')



subplot(2,4,7);
var1 = ASRS_all(:,7);
var2 = T.xi_mean;
param_bounds_var1 = [5,45]; 
param_bounds_var2 = [0,0.5];  
title_ = 'Model parameter';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'g', 'NorthOutside', {'ASRS hyperactivity-';'impulsivity subscore'}, {'\epsilon-greedy parameter'});
disp('g')
disp(p)
disp(p*2)
disp('---------')

 
subplot(2,4,8);
var1 = ASRS_all(:,7);
var2 = T.pickedD_mean;
param_bounds_var1 = [5,45]; 
param_bounds_var2 = [0,20];  
title_ = 'Behaviour';
p=render_corr(var1,var2, param_bounds_var1, param_bounds_var2, title_, 'h', 'NorthOutside', {'ASRS hyperactivity-';'impulsivity subscore'}, {'Low-value bandit frequency'});
disp('h')
disp(p)
disp(p*2)
disp('---------')



annotation(f1,'textbox',...
    [0.13 0.9 0.36 0.06],...
    'String','General impulsivity',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);

annotation(f1,'textbox',...
    [0.54 0.9 0.36 0.06],...
    'String','Motor impulsivity',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);

annotation(f1,'textbox',...
    [0.13 0.43 0.36 0.06],...
    'String','ADHD',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);

annotation(f1,'textbox',...
    [0.54 0.43 0.36 0.06],...
    'String','ADHD hyperactivity-impulsivity',...
    'FitBoxToText','off', ...
    'EdgeColor', 'none', ...
    'BackgroundColor', [0.6278    0.1425    0.3855], 'FaceAlpha', 0.07, ...
    'VerticalALignment', 'middle', 'HorizontalALignment', 'center', ...
    'FontName','Arial','Fontweight','normal','FontSize',18);


% %Export
% addpath('../../export_fig')
% export_fig(['Fig3.tif'],'-nocrop','-r200')

