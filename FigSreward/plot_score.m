
clear;

%% Data behaviour
load('/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/data_for_figs_2/score_mat_all_apples.mat')
load('/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/data_for_figs_2/score_mat_all_apples_desc.mat')

n = size(score_mat_all_apples,2);

%%

% split in 2 matrices (2 conditions) and average within participants
mean_exploited = nan(n,6);
mean_explored = nan(n,6);

for part=1:n
    tmp = score_mat_all_apples{part};

    score_exploited = tmp(tmp(:,2)==1,3:9);
    score_explored = tmp(tmp(:,2)==0,3:9);
    
    cumulative_score_exploited = [score_exploited(:,1) ...
                score_exploited(:,2) ...
                score_exploited(:,3)...
                score_exploited(:,4) ...
                score_exploited(:,5) ...
                score_exploited(:,6)];
    
    diff_score_exploited = cumulative_score_exploited - score_exploited(:,7);
            
    cumulative_score_explored = [score_explored(:,1) ...
                score_explored(:,2) ...
                score_explored(:,3)...
                score_explored(:,4) ...
                score_explored(:,5) ...
                score_explored(:,6)];
            
    diff_score_explored = cumulative_score_explored - score_explored(:,7);

    mean_exploited(part,:) = mean(diff_score_exploited,1);
    mean_explored(part,:) = mean(diff_score_explored,1);
end

%% Figure

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col(1,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

plot([1:6],nanmean(mean_exploited,1),'LineWidth',4, 'Color',[col(1,:) 0.5]); hold on;
plot([1:6],nanmean(mean_explored,1),'LineWidth',4, 'Color',[col(1,:) 1]); hold on;
plot([1:6],nanmean(mean_exploited,1)-nanstd(mean_exploited,1)./sqrt(n),'LineWidth',1, 'Color',[col(1,:) 0.5]); hold on;
plot([1:6],nanmean(mean_exploited,1)+nanstd(mean_exploited,1)./sqrt(n),'LineWidth',1, 'Color',[col(1,:) 0.5]); hold on;
plot([1:6],nanmean(mean_explored,1)-nanstd(mean_explored,1)./sqrt(n),'LineWidth',1, 'Color',[col(1,:) 1]); hold on;
plot([1:6],nanmean(mean_explored,1)+nanstd(mean_explored,1)./sqrt(n),'LineWidth',1, 'Color',[col(1,:) 1]); hold on;
plot([1:6], zeros(1,6),'--k', 'LineWidth',1)

legend({'starts with exploitation', 'starts with exploration'},'Position',[0.399322552900535 0.732529249423828 0.469613249871612 0.121052628441861]);
%title('Reward in the long horizon')

ylim([-0.63 0.63])
set(gca,'YTick',-0.6:0.3:0.6)
set(gca,'XTick',1:1:6)
ylabel('Increase in reward')
xlabel('trial')

%% Export
out_dir = '/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/scores/';
addpath('/Users/magdadubois/GoogleDrive/UCL/writing/export_fig/')
export_fig([out_dir 'Fig_behaviour_LH_score_diff.tif'],'-nocrop','-r200')



