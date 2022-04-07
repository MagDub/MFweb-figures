
function [] = render_mod8_tau(ybounds, increment, signif, hight_signif)

    % Data
    load('../../../data/data_for_figs/model_parameters_mod8_newB.mat')
    load('../../../data/data_for_figs/model_parameters_mod8_newB_desc.mat')
    ind_SH = find(contains(model_parameters_desc,'tau_short'));
    ind_LH = find(contains(model_parameters_desc,'tau_long'));
    param_SH = model_parameters(:,ind_SH);
    param_LH = model_parameters(:,ind_LH);

    load('../../../data_analysis/usermat_completed.mat')

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    param_SH(to_del,:) = nan;
    param_LH(to_del,:) = nan;

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; 

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(model_parameters,1),1)-0.5)/5;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); hold on;
    % plot(x_ax(3)*ones(1,size(param_SH,1)), param_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    % Long horizon
    b2L = bar(x_ax(6),nanmean(param_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    % plot(x_ax(6)*ones(1,size(param_LH,1)), param_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(param_SH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[param_SH(n) param_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax([3 6]),[nanmean(param_SH) nanmean(param_LH)], ...
        [nanstd(param_SH)./sqrt(size(param_SH,1)) nanstd(param_LH)./sqrt(size(param_SH,1))],'.','color','k');
    set(h,'Marker','none')

    % Number and title
    text(0-0.2, 1+0.2,'d','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title(['\fontsize{18} Softmax temperature{\fontsize{22} \tau}'],'interpreter','tex','Fontweight','normal','FontName','Arial');
    
    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};
    set(gca,'box','off')

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:increment:100)
    ylim(ybounds)

end