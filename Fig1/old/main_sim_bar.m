
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

% figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;


%%% means
subplot(1,2,1);

y = mean(samples,1);

hold on;

bar(1, y(1), 'FaceColor', [0 0.4470 0.7410]);
bar(2, y(2), 'FaceColor', [0.8500 0.3250 0.0980]);
bar(3, y(3), 'FaceColor', [0.9290 0.6940 0.1250]);
bar(4, y(4), 'FaceColor', [0.4940, 0.1840, 0.5560]);

% CI
[neg_1, pos_1, ~] = get_bounds_normal_dist(samples(:,1));
[neg_2, pos_2, ~] = get_bounds_normal_dist(samples(:,2));
[neg_3, pos_3, ~] = get_bounds_normal_dist(samples(:,3));
[neg_4, pos_4, ~] = get_bounds_normal_dist(samples(:,4));

h = errorbar(1:4,y,[neg_1, neg_2, neg_3, neg_4],...
                    [pos_1, pos_2, pos_3, pos_4],...
                    '.','color','k','LineWidth',1.2);


set(h,'Marker','none')

xticks(1:4)
xticklabels({'CS', 'C', 'N', 'L'})
ylim([2,10])

title('Bandits'' means','FontSize', 16, 'FontName','Arial', 'Fontweight','normal');


%%% number
subplot(1,2,2);

x_val=1:4;
initial_samples_counts=[3,1,0,1];

xlabel('Number','FontName','Arial','Fontweight','bold','FontSize',12);
xlim([0 3.5]);
xticks(0:3)
ylim([0.5 4.5]);
yticks(1:4)
yticklabels({'L', 'N', 'C', 'CS'})

hold on;

barh(4, 3, 'FaceColor', [0 0.4470 0.7410], 'BarWidth', 0.1);  
barh(3, 1, 'FaceColor', [0.8500 0.3250 0.0980], 'BarWidth', 0.1);   
barh(2, 0, 'FaceColor', [0.9290 0.6940 0.1250], 'BarWidth', 0.1);    
barh(1, 1, 'FaceColor', [0.4940, 0.1840, 0.5560], 'BarWidth', 0.1);   

plot(3, 4, 'o', 'Color', [0 0.4470 0.7410], 'LineWidth',5);
plot(1, 3, 'o', 'Color', [0.8500 0.3250 0.0980], 'LineWidth',5); 
plot(0, 2, 'o', 'Color', [0.9290 0.6940 0.1250], 'LineWidth',5);  
plot(1, 1, 'o', 'Color', [0.4940, 0.1840, 0.5560], 'LineWidth',5);

hold off;

box off;

title('Bandits'' initial samples','FontSize', 16, 'FontName','Arial', 'Fontweight','normal');


