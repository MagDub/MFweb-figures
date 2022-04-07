close all

path = '../../data_analysis/10_stats/corr_bonferroni/corr_allQ/';
file_r = 'behav_r.csv';
file_pc = 'behav_pval_corr.csv';
file_pu = 'behav_pval_uncorr.csv';

T_r = readtable(strcat(path, file_r));
T_pc = readtable(strcat(path, file_pc));
T_pu = readtable(strcat(path, file_pu));


% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10])
set(gca,'FontName','Arial','FontSize',10)
hold on;

mat_r = table2array(T_r);
mat_pc = table2array(T_pc);
mat_pu = table2array(T_pu);

imagesc(abs(mat_r'))

xticks([1:9])
xlim([0.5 9.5])
xticklabels({'BIS11', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'STAI', 'IUS', 'SDS', 'LSAS'})

yticks([1:3])
ylim([0.5 3.5])
yticklabels({'Low-value bandit', 'Novel bandit', 'High-value bandit'})

cmap=cmocean('matter'); % ice or dense 
colormap( cmap );
caxis([0 0.21])
h = colorbar('Ticks',0:0.05:1); 
title(h,'r','Interpreter','tex')

for col_ = 1:3
    textStrings = num2str(mat_r(:,col_), '%0.2f');       % Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
    
    for row_ = 1:9
        
        string_ = textStrings(row_);
        
        % significance of p uncorrected
        if mat_pu(row_,col_)<0.001
            string_ = strcat([string_; strcat('***','p_u')]);
        elseif mat_pu(row_,col_)<0.01
            string_ = strcat([string_; strcat('**','p_u')]);
        elseif mat_pu(row_,col_)<0.05
            string_ = strcat([string_; strcat('*','p_u')]);
        else
            string_ = '';
        end
        
        % significance of p corrected
        if mat_pc(row_,col_)<0.001
            string_ = strcat([string_; strcat('°°°','p_c')]);
        elseif mat_pc(row_,col_)<0.01
            string_ = strcat([string_; strcat('°°','p_c')]);
        elseif mat_pc(row_,col_)<0.05
            string_ = strcat([string_; strcat('°','p_c')]);
        else
            string_ = strcat(string_,'');
        end
        
        hStrings = text(row_, col_, string_,'HorizontalAlignment', 'center', 'Color', 'w','FontSize', 12);
        
    end
end

%Export
addpath('../../export_fig')
export_fig(['Fig_v1.tif'],'-nocrop','-r200')
