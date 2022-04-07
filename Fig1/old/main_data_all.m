

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,3,1)
[samples_1, samples_2, samples_3, samples_4] = make_sample_data('SH_1');
title_ = 'Distributions of SH 1st sample';
plot_distr(samples_1, samples_2, samples_3, samples_4, title_)

subplot(1,3,2)
[samples_1, samples_2, samples_3, samples_4] = make_sample_data('LH_1');
title_ = 'Distributions of LH 1st sample';
plot_distr(samples_1, samples_2, samples_3, samples_4, title_)

subplot(1,3,3)
[samples_1, samples_2, samples_3, samples_4] = make_sample_data('LH_26');
title_ = 'Distributions of LH next samples';
plot_distr(samples_1, samples_2, samples_3, samples_4, title_)



