function [] = render_score_pertrial_SH(min_, max_, indexation_y, indexation_x, n_trials)

    % data
    load('../../../data_analysis/usermat_completed.mat')   
    data_fold = ('../../../data/');
    
    tmp_desc=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH_desc.mat'));
    
    tmpSH=load(strcat(data_fold, 'data_for_figs/per_trial_score_SH.mat'));
    tmpLHall=load(strcat(data_fold, 'data_for_figs/per_trial_score_LH_all.mat'));
    tmpLH1st=load(strcat(data_fold, 'data_for_figs/per_trial_score_LH_1st.mat'));

    score_SH = tmpSH.per_trial_score(:,2:end);
    first_LH = tmpLHall.per_trial_score(:,2:end);
    score_LH = tmpLH1st.per_trial_score(:,2:end);

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    score_SH(to_del,:) = nan;
    score_LH(to_del,:) = nan;
    first_LH(to_del,:) = nan;
    n = size(score_SH,1)-size(to_del,2);
    
    % average
    score_SH_av=[];
    for i_ = 1:n_trials:400
        score_SH_av(:,end+1) = sum(score_SH(:,i_:(i_+(n_trials-1))),2)/n_trials;
    end

    % Figure
    col(1,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; % indiv lines
    col(2,:) = [0.20392157137394 0.301960796117783 0.494117647409439]; % mean

    % plot
    plot([n_trials:n_trials:400],nanmean(score_SH_av,1)-nanstd(score_SH_av)./sqrt(n),'LineWidth',1, 'Color',[col(2,:) 0.3]); hold on;
    plot([n_trials:n_trials:400],nanmean(score_SH_av,1)+nanstd(score_SH_av)./sqrt(n),'LineWidth',1, 'Color',[col(2,:) 0.3]); hold on;
    plot([n_trials:n_trials:400],nanmean(score_SH_av,1),'LineWidth',2,'Color',[col(2,:) 1]); hold on;
    
    % figure param
    ylim([min_ max_])
    xlim([n_trials/2 400+n_trials/2])
    
    set(gca,'YTick',0:indexation_y:10)
    set(gca,'XTick',0:indexation_x:400)
    
    ylabel({'Reward'}','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel({'Trial'}','FontName','Arial','Fontweight','bold','FontSize',12);
 
    set(gca,'box','off')

    % Number and title
    text(0-0.2, 1+0.25,'a','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title('Short horizon','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end

