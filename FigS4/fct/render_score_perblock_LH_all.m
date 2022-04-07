function [p] = render_score_perblock_LH_all(to_del)

    % data
    load('../../data_analysis/usermat_completed.mat')   
    data_fold = ('../../data/');

    load(strcat(data_fold, 'data_for_figs/score_desc.mat'))
    
    b1=load(strcat(data_fold, 'data_for_figs/score_block1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/score_block2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/score_block3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/score_block4.mat'));

    score_SH = [b1.score(:,2), b2.score(:,2), b3.score(:,2), b4.score(:,2)];
    first_LH = [b1.score(:,3), b2.score(:,3), b3.score(:,3), b4.score(:,3)];
    score_LH = [b1.score(:,4), b2.score(:,4), b3.score(:,4), b4.score(:,4)];

    % Remove ID
    score_SH(to_del,:) = nan;
    score_LH(to_del,:) = nan;
    first_LH(to_del,:) = nan;
    n = size(score_LH,1)-size(to_del,2);

    % Figure
    col(1,:) = [4.366786594847170133e-01 7.114212963902242226e-01 8.027769966740599950e-01];
    col(2,:) = [1.302307935855599175e-01 1.261348273230401829e-01 2.555217697948003464e-01];

    % plot
    
    n_blocks = 4;
    [beta_all_LH, stats_slope, p] = fct_compute_coeff(score_LH, n_blocks);
    
    disp('Block - All LH')
    disp(stats_slope)
    disp('--------------')
    
    fct_plot_score(n_blocks, nanmean(score_LH,1), beta_all_LH, {'Long horizon','average sample'}, 'c', 'NorthWest', score_LH)
    
    xlabel({'Block'}','FontName','Arial','Fontweight','bold','FontSize',12);
 
    set(gca,'box','off')

end

