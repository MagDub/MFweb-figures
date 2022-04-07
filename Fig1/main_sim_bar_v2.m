
addpath('../fcts/')

n=1000;
sd_ = 1.4;
sd_sampling = 0.8;
starting_means= [5, 7];
shift = [-2,-1,+1,+2];
means_desc = {};
means_overall=nan(n,4);
means=nan(n,4);
samples=nan(n,4);

for i=1:n

    % Certain-standard bandit
    means_desc{1}='Bandit_A';
    means_overall(i,1) = starting_means(randi(2));
    means(i,1) = round(sample(means_overall(i,1), sd_),0);
    samples(i,1) = round(sample(means(i,1), sd_sampling),0);

    % Standard bandit
    means_desc{2}='Bandit_B';
    means_overall(i,2) = means_overall(i,1) - shift(randi(4));
    means(i,2) = round(sample(means_overall(i,2), sd_),0);
    samples(i,2) = round(sample(means(i,2), sd_sampling),0);

    % Novel bandit
    means_desc{3}='Bandit_C';
    means_overall(i,3) = means_overall(i,randi(2)) - shift(randi(4));
    means(i,3) = round(sample(means_overall(i,3), sd_),0);
    samples(i,3) = round(sample(means(i,3), sd_sampling),0);

    % Low bandit
    means_desc{4}='Bandit_D';
    means_overall(i,4) = min(means_overall(i,:))-1;
    means(i,4) = round(sample(means_overall(i,4), sd_),0);
    samples(i,4) = round(sample(means(i,4), sd_sampling),0);

end

% truncate
samples(samples(:,1)>10,1)=10;
samples(samples(:,1)<3,1)=3;

samples(samples(:,2)>10,2)=10;
samples(samples(:,2)<3,2)=3;

samples(samples(:,3)>10,3)=10;
samples(samples(:,3)<3,3)=3;

for i=1:size(samples,1)
    if samples(i,4)~=min(samples(i,:))
        samples(i,4) = min(samples(i,:))-1;
    end
end

samples(samples(:,4)<2,4)=2;

% figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 15]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_1 = [228, 158, 73]/256;
col_2 = [0.4940, 0.1840, 0.5560];
col_3 = [200, 76, 68]/256;
col_4 = [52, 154, 152]/256;

%%% means

n = size(samples,1);
noise_plot = (rand(1,n)-0.5)/1.5;

% individual dots
scatter(1*ones(1,n)+noise_plot, samples(:,1), 16, col_1, 'filled', 'MarkerFaceAlpha', 0.05); hold on;
scatter(2*ones(1,n)+noise_plot, samples(:,2), 16, col_2, 'filled', 'MarkerFaceAlpha', 0.05); hold on;
scatter(3*ones(2,n)+noise_plot, samples(:,3), 16, col_3, 'filled', 'MarkerFaceAlpha', 0.05); hold on;
scatter(4*ones(3,n)+noise_plot, samples(:,4), 16, col_4, 'filled', 'MarkerFaceAlpha', 0.05); hold on;

hold on;

% means
y = mean(samples,1);
bar(1, y(1), 'FaceColor', col_1, 'FaceAlpha', 0.2, 'BarWidth',.5)
bar(2, y(2), 'FaceColor', col_2, 'FaceAlpha', 0.2, 'BarWidth',.5)
bar(3, y(3), 'FaceColor', col_3, 'FaceAlpha', 0.2, 'BarWidth',.5)
bar(4, y(4), 'FaceColor', col_4, 'FaceAlpha', 0.2, 'BarWidth',.5)

% CI
[neg_1, pos_1, ~] = get_bounds_normal_dist(samples(:,1));
[neg_2, pos_2, ~] = get_bounds_normal_dist(samples(:,2));
[neg_3, pos_3, ~] = get_bounds_normal_dist(samples(:,3));
[neg_4, pos_4, ~] = get_bounds_normal_dist(samples(:,4));

h = errorbar(1:4,y,[neg_1, neg_2, neg_3, neg_4],...
                    [pos_1, pos_2, pos_3, pos_4],...
                    '.','color','k','LineWidth',1.2);

set(h,'Marker','none')

xticks([1, 2, 3, 4])
xlim([0.4 4.6])
xticklabels({strcat(32,32,'Certain-\newline standard  \newline',32,32,32,'bandit'),...
                strcat(32,'Standard  \newline',32,32,32,'bandit'), strcat(32,'Novel \newline',32,'bandit'), strcat(32,'Low-value \newline',32,32,32,32,'bandit')})

a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',16)

a = get(gca,'YTickLabel');  
set(gca,'YTickLabel',a,'fontsize',16)

yticks(2:2:10)
ylabel('Value','FontName','Arial','Fontweight','bold','FontSize',20);
ylim([1,11])
yticklabels([2,4,6,8,10])

title('Bandits'' means','FontSize', 22, 'FontName','Arial', 'Fontweight','bold');

% Export
addpath('../../export_fig')
export_fig(['Fig_c.tif'],'-nocrop','-r200')

%%% number

% figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 15]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

x_val=1:4;
initial_samples_counts=[3,1,0,1];

xticks([1, 2, 3, 4])
xlim([0.4 4.6])
xticklabels({strcat(32,32,'Certain-\newline standard  \newline',32,32,32,'bandit'),...
                strcat(32,'Standard  \newline',32,32,32,'bandit'), strcat(32,'Novel \newline',32,'bandit'), strcat(32,'Low-value \newline',32,32,32,32,'bandit')})

hold on;

bar(1, 3, 'FaceColor', col_1, 'EdgeColor', col_1, 'BarWidth', 0.035);  
bar(2, 1, 'FaceColor', col_2, 'EdgeColor', col_2,'BarWidth', 0.035);   
bar(3, 0, 'FaceColor', col_3, 'EdgeColor', col_3,'BarWidth', 0.035);    
bar(4, 1, 'FaceColor', col_4, 'EdgeColor', col_4,'BarWidth', 0.035);   

scatter(1, 3, 'filled', 'MarkerEdgeColor', col_1, 'MarkerFaceColor', col_1, 'LineWidth',1.5);
scatter(2, 1, 'filled', 'MarkerEdgeColor', col_2, 'MarkerFaceColor', col_2, 'LineWidth',1.5); 
scatter(3, 0, 'filled', 'MarkerEdgeColor', col_3, 'MarkerFaceColor', col_3, 'LineWidth',1.5);  
scatter(4, 1, 'filled', 'MarkerEdgeColor', col_4, 'MarkerFaceColor', col_4, 'LineWidth',1.5);

hold off;

box off;

a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',16)

a = get(gca,'YTickLabel');  
set(gca,'YTickLabel',a,'fontsize',16)

ylabel('Number','FontName','Arial','Fontweight','bold','FontSize',20);
ylim([0 3.5]);
yticks(0:3)
yticklabels([0,1,2,3])

title('Bandits'' initial samples','FontSize', 22, 'FontName','Arial', 'Fontweight','bold');

% Export
addpath('../../export_fig')
export_fig(['Fig_d.tif'],'-nocrop','-r200')


