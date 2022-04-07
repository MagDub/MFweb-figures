function [] = render_score_perblock_SH()

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
    n = size(score_SH,1)-size(to_del,2);

    % Figure
    col(1,:) = [4.366786594847170133e-01 7.114212963902242226e-01 8.027769966740599950e-01];
    col(2,:) = [1.302307935855599175e-01 1.261348273230401829e-01 2.555217697948003464e-01]; 
    
%     col(1,:) = [4.366786594847170133e-01 7.114212963902242226e-01 8.027769966740599950e-01];
%     col(2,:) = [1.302307935855599175e-01 1.261348273230401829e-01 2.555217697948003464e-01];

    % plot
    %p_l = plot([1:4], score_SH, 'Color',[col(1,:) 0.2]); hold on;
    %plot([1:4],nanmean(score_SH,1),'LineWidth',3, 'Color',[col(2,:) 1]); 
    %errorbar([1:4],nanmean(score_SH),nanstd(score_SH)./sqrt(n),'.','color','k'); 
    
    n_blocks = 4;
    
    beta_SH = fct_compute_coeff(score_SH, n_blocks);
    
    fct_plot_score(n_blocks, nanmean(score_SH,1), beta_SH, {'Short horizon'}, 'a', 'NorthWest', score_SH)
    
    xlabel({'Block'}','FontName','Arial','Fontweight','bold','FontSize',12);


end

