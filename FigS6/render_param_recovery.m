
function [] = render_param_recovery()

    n_sim = 20000;
    thompson_file = 'D:\MFweb\data\sim_recov\thompson_rand_Norm\';
    saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

    load(strcat(saving_dir, 'out_sim_thompson.mat'))
    
    out.org = [out.org(:,4:7), out.org(:,3), out.org(:,1:2)];
    out.fitted = [out.fitted(:,4:7), out.fitted(:,3), out.fitted(:,1:2)];
    
    % Parameter and parameter names

    n_param = 7;

    param_legends{1} = '\sigma_0_,_{SH}';
    param_legends{2} = '\sigma_0_,_{LH}';
    param_legends{3} = 'Q_0';
    param_legends{4} = '\epsilon_{SH}';
    param_legends{5} = '\epsilon_{LH}';
    param_legends{6} = '\eta_{SH}';
    param_legends{7} = '\eta_{LH}';
    
    param_legends = [param_legends(:,4:7), param_legends(:,3), param_legends(:,1:2)];


    %% Figure
    set(gca,'FontName','Arial','FontSize',10)
    set(gca,'TickLabelInterpreter','tex')
    hold on

        for j = 1:n_param 
            for i = 1:n_param 
                rho = corr(out.fitted(:,i),out.org(:,j), 'rows','complete', 'Type','Pearson');
                parameter_recov_mat(j,i) = rho;
            end
        end
        
    parameter_recov_mat = flipud(parameter_recov_mat);

    imagesc(abs(parameter_recov_mat))
    
    xticks([1 2 3 4 5 6 7])
    xlim([0.5 7.5])
    xticklabels({param_legends{1}, param_legends{2}, param_legends{3}, param_legends{4}, param_legends{5}, param_legends{6}, param_legends{7}})
    yticks([1 2 3 4 5 6 7])
    ylim([0.5 7.5])
    yticklabels({param_legends{7}, param_legends{6}, param_legends{5}, param_legends{4}, param_legends{3}, param_legends{2}, param_legends{1}})

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',10, 'YDir', 'reverse')

    cmap=cmocean('matter'); % ice or dense 
    %colormap( cmap );
    colormap( flipud(cmap) );
    
    caxis([0 1])
    h = colorbar('Ticks',0:0.2:1); 
    title(h,'r','Interpreter','tex')

    textStrings = num2str(parameter_recov_mat(:), '%0.2f');       % Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
    [x, y] = meshgrid(1:n_param);  % Create x and y coordinates for the strings

    % Upper diag
    for i_=1:size(x,1)-1
        x(1:size(x,1)-i_,i_)=nan;
    end
   
    % Lower diag
    for i_=1:size(x,1)-1
        x(size(x,1)-(i_-1),(i_+1):size(x,1)) = nan;
    end
    
    ylabel('Simulated parameter','FontName','Arial','Fontweight','bold','FontSize',12);
    xlh = xlabel('Recovered parameter','FontName','Arial','Fontweight','bold','FontSize',12);
    
    xlh.Position(2) = xlh.Position(2) + 2;

    textStrings_=textStrings(:);

    for i=1:size(textStrings_,1)
        a=textStrings_{i};
        if strcmp(a,'0.00')   
            textStrings_{i}='';
        elseif strcmp(a,'1.00')   
            textStrings_{i}='1.0';
        else
            tmp = textStrings_{i};
            textStrings_{i}=tmp(2:end);
        end
    end
    
    hStrings = text(x(:), y(:), textStrings_(:),'HorizontalAlignment', 'center', 'Color', 'k','FontSize', 11);
    midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range;
    
    % Number and title
    text(0-0.15, 1+0.17,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Confusion matrix','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end


