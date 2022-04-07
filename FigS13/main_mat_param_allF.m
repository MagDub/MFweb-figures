function [] = main_mat_param_allF(c_ax, inc)  

    addpath('../cmocean/')

    path = '../../data_analysis/10_stats/corr_bonferroni/corr_allQ/';
    file_r = 'allF_param_r.csv';
    file_pc = 'allF_param_pval_corr.csv';
    file_pu = 'allF_param_pval_uncorr.csv';

    T_r = readtable(strcat(path, file_r));
    T_pc = readtable(strcat(path, file_pc));
    T_pu = readtable(strcat(path, file_pu));

    % Plot
    mat_r = table2array(T_r);
    mat_pc = table2array(T_pc);
    mat_pu = table2array(T_pu);

    imagesc(abs(mat_r')); 
        
    pause(0.1); %Just to make sure that the plot is made before the next step
    hAxes = gca;     
    hAxes.XRuler.Axle.LineStyle = 'none'; 
    hAxes.YRuler.Axle.LineStyle = 'none'; 
    a = get(gca,'XTickLabel');
    set(gca, 'Ticklength', [0 0])
        
    xticks([1:3])
    xlim([0.5 3.5])
    xticklabels({'Anxious-Depression', 'Uncertainty-related',  'Impulsivity'})

    yticks([1:4])
    ylim([0.5 4.5])
    yticklabels({...
        strcat(32,32,'\epsilon-greedy \newline parameter'), ...
        strcat(32,32,'Novelty \newline bonus \eta'), ...
        strcat(32,32,32,32,32,32,32,32,32,32,'Prior \newline variance \sigma_0'), ...
        strcat(32,32,32,32,32,32,32,32,32,32,'Prior \newline ',32,32,32,32,'mean Q_0')}) 
   
    cmap=cmocean('matter'); % ice or dense 
    colormap( cmap );
    caxis(c_ax)
    h = colorbar('Ticks',0:inc:1); 
    title(h,'r','Interpreter','tex')
    
    box off;

    for col_ = 1:4
        textStrings = num2str(mat_r(:,col_), '%0.2f');       % Create strings from the matrix values
        textStrings = strtrim(cellstr(textStrings));  % Remove any space padding

        for row_ = 1:3


            % significance of p uncorrected
            if mat_pu(row_,col_)<0.05
                string_ = textStrings(row_);
            else
                string_ = '';
            end

            % significance of p corrected
            if mat_pc(row_,col_)<0.001
                hStrings = text(row_, col_, strcat(string_, '***'),'HorizontalAlignment', 'center', 'Color', 'w','FontSize', 12, 'FontWeight', 'normal');
            elseif mat_pc(row_,col_)<0.01
                hStrings = text(row_, col_, strcat(string_, '**'),'HorizontalAlignment', 'center', 'Color', 'w','FontSize', 12, 'FontWeight', 'normal');
            elseif mat_pc(row_,col_)<0.05
                hStrings = text(row_, col_, strcat(string_, '*'),'HorizontalAlignment', 'center', 'Color', 'w','FontSize', 12, 'FontWeight', 'normal');
            else
                hStrings = text(row_, col_, string_,'HorizontalAlignment', 'center', 'Color', 'w','FontSize', 12, 'FontWeight', 'normal');
            end

        end
    end
    
    text(0-0.4, 1+0.25,'e','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)  
end

