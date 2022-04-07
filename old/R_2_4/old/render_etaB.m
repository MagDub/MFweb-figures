
function [] = render_etaB(ybounds, increment, signif, hight_signif)

    
    %% Data
    load('../../../data_analysis/usermat_completed.mat')
    
    load('../../../data/data_for_figs/model_parameters_mod12_etaB.mat')
    load('../../../data/data_for_figs/model_parameters_mod12_etaB_desc.mat')
    
    ind_SH = find(contains(model_parameters_desc,'eta_short'));
    ind_LH = find(contains(model_parameters_desc,'eta_long'));
    ind_SH_B = find(contains(model_parameters_desc,'etaB_short'));
    ind_LH_B = find(contains(model_parameters_desc,'etaB_long'));
    
    param_SH = model_parameters(:,ind_SH);
    param_LH = model_parameters(:,ind_LH);
    param_SH_B = model_parameters(:,ind_SH_B);
    param_LH_B = model_parameters(:,ind_LH_B);

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    param_SH(to_del,:) = nan;
    param_LH(to_del,:) = nan;
    param_SH_B(to_del,:) = nan;
    param_LH_B(to_del,:) = nan;

    %% Figure
    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];
    
    x_ax = 0.5:0.5:10;

    N_ = size(param_SH,1);
    noise_plot = (rand(size(param_SH,1),1)-0.5)/5;
    
    % Short horizon
    b1S= bar(x_ax(4),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.3, 'BarWidth',.5); hold on;
    b2S = bar(x_ax(7),nanmean(param_SH_B),'FaceColor',col_(1,:), 'FaceAlpha', 0.3, 'BarWidth',.5);

    % Long horizon
    b1L = bar(x_ax(5),nanmean(param_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',.5);
    b2L = bar(x_ax(8),nanmean(param_LH_B),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
    
    % Line between data points
    for n = 1:size(param_SH,1)
        lin1 = plot(x_ax(4:5)+noise_plot(n),[param_SH(n) param_LH(n)]); hold on;
        lin1.Color = [col_(2,:) 0.3]; % transparency
    end

    for n = 1:size(param_SH_B,1)
        lin2 = plot(x_ax(7:8)+noise_plot(n),[param_SH_B(n) param_LH_B(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([4 5 7 8]),...
        [nanmean(param_SH) nanmean(param_LH) ...
        nanmean(param_SH_B) nanmean(param_LH_B)], ...
        [nanstd(param_SH)./sqrt(N_) nanstd(param_LH)./sqrt(N_)...
        nanstd(param_SH_B)./sqrt(N_) nanstd(param_LH_B)./sqrt(N_)],'.','color','k');
    set(h,'Marker','none')
 
    legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'Location','NorthEast');
    legend boxoff     
  
    % Number and title
    text(0-0.2, 1+0.2,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(['\fontsize{18}Block-dependent {\fontsize{22}\eta}'],'interpreter','tex','Fontweight','normal','FontName','Arial');

    xlim([1 5])   
    set(gca,'XTick',[2.25 3.75])
    set(gca,'XTickLabel',{'\fontsize{15} \eta','\fontsize{15} \eta_B'})
    set(gca,'box','off')

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)

end


