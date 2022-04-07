function [] = render_corr(var1, var2, param_bounds_var1, param_bounds_var2, title_, letter, legend_position, var1_label, var2_label)

% sort them out
[var1,I] = sort(var1);
var2 = var2(I);

col_(1,:) = [0.6278    0.1425    0.3855];
col_(2,:) = [0.3687    0.0925    0.3491];
cols(3,:) = [0.4941    0.4941    0.4941]; 

set(gca,'TickLabelInterpreter','tex')

scatter(var1, var2, 6, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.24); hold on;
b1 = plot(-5,-5,'w*'); hold on;
b2 = plot(-5,-5,'w*'); hold on;
[r,p] = corr(var1,var2, 'rows','complete', 'Type','Pearson');

% regression line
mdl = fitlm(var1,var2,'linear'); hold on;
[ypred,yci] = predict(mdl,var1);
lower_conf_y = yci(:,1)';
upper_conf_y = yci(:,2)';

% Plot line and filled CI
x_plot = [var1', fliplr(var1')];
y_plot = [lower_conf_y, fliplr(upper_conf_y)];
plot(var1, ypred, 'Color',cols(3,:));
fill(x_plot, y_plot, cols(3,:), 'FaceAlpha',0.2, 'edgecolor', 'none');


% string output
if p<0.001
    l = legend([b1, b2],{strcat('r=',num2str(round(r,2))),strcat('p<.001')}); 
else
    l = legend([b1, b2],{strcat('r=',num2str(round(r,2))),strcat('p=',num2str(round(p,3)))}); 
end

legend boxoff;

set(l,'Location',legend_position, 'FontSize',16);

xlim(param_bounds_var1);
ylim(param_bounds_var2);

xlabel(var1_label,'FontName','Arial','Fontweight','bold','FontSize',12);
ylabel(var2_label,'FontName','Arial','Fontweight','bold','FontSize',12);

% Number and title
%text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)     
text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)  
title(title_,'FontSize', 17, 'FontName','Arial', 'Fontweight','normal');

set(gca,'box','off')

hold off;


end