
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
 
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;


%%% means
subplot(1,2,1);

x_values = 1:0.1:10;

y1 = pdf(fitdist(samples(:,1),'Normal'),x_values);
y2 = pdf(fitdist(samples(:,2),'Normal'),x_values);
y3 = pdf(fitdist(samples(:,3),'Normal'),x_values);
y4 = pdf(fitdist(samples(:,4),'Normal'),x_values);

hold all;
h1=plot(x_values,y1,'LineWidth',2); 
h2=plot(x_values,y2,'LineWidth',2); 
h3=plot(x_values,y3,'LineWidth',2); 
h4=plot(x_values,y4,'LineWidth',2); 
xlim([1 10])
xticks(1:10)
ylim([0 0.4])
h = gca; 
h.YAxis.Visible = 'off';
set(gca,'YTickLabel',[]);
title('Bandits'' means','FontSize', 16, 'FontName','Arial', 'Fontweight','normal');
xlabel('Value','FontName','Arial','Fontweight','bold','FontSize',12);

legend({'Certain-standard bandit (CS)', 'Certain bandit (C)', 'Novel bandit (N)', 'Low-value bandit (L)'}, 'Location','NorthEast');
legend boxoff 
hold off;


%%% number
subplot(1,2,2);

x_val=1:4;
initial_samples_counts=[3,1,0,1];

ylim([0.5 5.5]);
yticks(1:3)
xlim([0 5]);
xticks(1:4)
xticklabels({'CS', 'C', 'N', 'L'})

hold on;
h1=plot(nan(size(y1)),y1,'LineWidth',2); 
h2=plot(nan(size(y2)),y2,'LineWidth',2); 
h3=plot(nan(size(y3)),y3,'LineWidth',2); 
h4=plot(nan(size(y4)),y4,'LineWidth',2); 
plot([1 1 1], 1:3, 'bo'); 
plot([2], 1, 'ro'); 
plot([4], 1, 'o', 'Color', [0.4940, 0.1840, 0.5560]); 

hold off;

% legend([h1, h2, h3, h4], {'Certain-standard bandit', 'Certain bandit', 'Novel bandit', 'Low-value bandit'}, 'Location','NorthEast');
% legend boxoff;

box off;

h = gca; 
h.YAxis.Visible = 'off';
set(gca,'YTickLabel',[]);

title('Bandits'' initial samples Nb','FontSize', 16, 'FontName','Arial', 'Fontweight','normal');


