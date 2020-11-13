function [] = render_score_perblock_LH_all()

    % data
    load('../../../data_analysis/usermat_completed.mat')   
    data_fold = ('../../../data/');

    load(strcat(data_fold, 'data_for_figs/score_desc.mat'))
    
    b1=load(strcat(data_fold, 'data_for_figs/score_block1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/score_block2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/score_block3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/score_block4.mat'));

    score_SH = [b1.score(:,2), b2.score(:,2), b3.score(:,2), b4.score(:,2)];
    first_LH = [b1.score(:,3), b2.score(:,3), b3.score(:,3), b4.score(:,3)];
    score_LH = [b1.score(:,4), b2.score(:,4), b3.score(:,4), b4.score(:,4)];

    % Remove ID
    to_del = [];
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);
    score_SH(to_del,:) = nan;
    score_LH(to_del,:) = nan;
    first_LH(to_del,:) = nan;
    n = size(score_LH,1)-size(to_del,2);

    % Figure
    col(1,:) = [0.39215686917305 0.474509805440903 0.635294139385223]; % indiv lines
    col(2,:) = [0.20392157137394 0.301960796117783 0.494117647409439]; % mean

    % plot
    plot([1:4], score_LH, 'Color',[col(1,:) 0.3]); hold on;
    plot([1:4],nanmean(score_LH,1),'LineWidth',3, 'Color',[col(2,:) 1]); 
    errorbar([1:4],nanmean(score_LH),nanstd(score_LH)./sqrt(n),'.','color','k'); 
    
    % figure param
    min_ = floor(min(min([score_SH, first_LH, score_LH]))*10)/10;
    max_ = floor(max(max([score_SH, first_LH, score_LH]))*10)/10;
    ylim([min_ max_])
    
    set(gca,'YTick',1:0.5:10)
    set(gca,'XTick',1:1:4)
    
    ylabel({'Reward'}','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel({'Block'}','FontName','Arial','Fontweight','bold','FontSize',12);
 
    set(gca,'box','off')

    % Number and title
    text(0-0.2, 1+0.3,'c','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title({'Long horizon','average sample'},'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end

