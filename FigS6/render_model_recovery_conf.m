
function [] = render_model_recovery_conf()


    %load('./model_recov_conf.mat');
    load('../../data/data_for_figs/model_recov_perc.mat')
    
    legend_all{1}  = 'UCB';
    legend_all{2}  = 'UCB + \epsilon';
    legend_all{3}  = 'UCB + \eta';
    legend_all{4}  = 'UCB + \epsilon + \eta';

    legend_all{5}  = 'thompson';
    legend_all{6}  = 'thompson + \epsilon';
    legend_all{7}  = 'thompson + \eta';
    legend_all{8}  = 'thompson + \epsilon + \eta';

    legend_all{9}  = 'UCB(\tau=1)';
    legend_all{10}  = 'UCB(\tau=1) + \epsilon';
    legend_all{11}  = 'UCB(\tau=1) + \eta';
    legend_all{12}  = 'UCB(\tau=1) + \epsilon + \eta';

    order_ = [9,5,13,...
                10,6,14,...
                    11,7,15,...
                        12,8,16]-4;

    perc = perc(order_,order_);
    legend_all = legend_all(order_);
    
%     legend_all{1}  = 'thompson';
%     legend_all{2}  = 'UCB';
%     legend_all{3}  = 'thompson + \epsilon';
%     legend_all{4}  = 'UCB + \epsilon';
%     legend_all{5}  = 'thompson + \eta';
%     legend_all{6}  = 'UCB + \eta';
%     legend_all{7}  = 'thompson + \epsilon + \eta';
%     legend_all{8}  = 'UCB + \epsilon + \eta';


    %% Figure
    set(gca,'FontName','Arial','FontSize',10)
    set(gca,'TickLabelInterpreter','tex')
    hold on
    
    perc = flipud(perc);
    
    imagesc(perc);

    n_mod = size(legend_all,2);

    yticks([1:n_mod])
    yticklabels({legend_all{12}, legend_all{11}, legend_all{10}, legend_all{9}, legend_all{8}, legend_all{7}, ...
        legend_all{6}, legend_all{5}, legend_all{4}, legend_all{3}, legend_all{2}, legend_all{1}})
    ylim([0.5 n_mod+0.5])

    xticks([1:n_mod])
    xticklabels({legend_all{1}, legend_all{2}, legend_all{3}, legend_all{4}, legend_all{5}, legend_all{6}, ...
        legend_all{7}, legend_all{8}, legend_all{9}, legend_all{10}, legend_all{11}, legend_all{12}})
    xtickangle(45)
    xlim([0.5 n_mod+0.5])

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',10, 'YDir', 'reverse')

    cmap=cmocean('matter'); % ice or dense 
    %colormap( cmap );
    colormap( flipud(cmap) );

    h = colorbar('Ticks',0:0.2:1); 
    caxis([0 1])

    title(h,'p','Interpreter','tex')

    textStrings = num2str(perc(:), '%0.2f');        % Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));    % Remove any space padding
    [x, y] = meshgrid(1:n_mod);                     % Create x and y coordinates for the strings

    % Upper diag
    for i_=1:size(x,1)-1
        x(1:size(x,1)-i_,i_)=nan;
    end
   
    % Lower diag
    for i_=1:size(x,1)-1
        x(size(x,1)-(i_-1),(i_+1):size(x,1)) = nan;
    end
    
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

    hStrings = text(x(:), y(:), textStrings_(:),'HorizontalAlignment', 'center', 'Color', 'k','FontSize', 10);
    midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range

    t=title('BIC model recovery (N_{sim}=100)','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

    ylabel('Simulated model','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('Recovered model','FontName','Arial','Fontweight','bold','FontSize',12);
   
    
    % Number and title
    text(0-0.15, 1+0.17,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Confusion matrix','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end


