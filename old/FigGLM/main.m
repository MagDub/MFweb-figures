
% For exclusion
load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Load data
T1 = readtable('../../../data_analysis/10_stats/FA/all_behav_and_FAscores.csv');
T2 = readtable('../../../data_analysis/10_stats/web_data_completed.xlsx');

age = T2.age;
age(to_del) = [];

IQ = T2.IQscore;
IQ(to_del) = [];

f_anxiety = T1.scores_f1;
f_uncertainty = T1.scores_f2;
f_impulsivity = T1.scores_f3;

xi = T1.xi_mean;
xi_SH = T1.xi_SH;
xi_LH = T1.xi_LH;

% concatenate
T = table(xi, xi_SH, xi_LH, f_anxiety, f_uncertainty, f_impulsivity, age, IQ);

% fit linear model
lm_mean = fitlm(T,'xi~f_anxiety+f_uncertainty+f_impulsivity+age+IQ');
lm_SH = fitlm(T,'xi_SH~f_anxiety+f_uncertainty+f_impulsivity+age+IQ');
lm_LH = fitlm(T,'xi_LH~f_anxiety+f_uncertainty+f_impulsivity+age+IQ');

