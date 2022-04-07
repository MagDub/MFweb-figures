function [] = render_corr(fitted, generated, param_bounds, ticks_, title_, letter, legend_position)

col_(1,:) = [0.6278    0.1425    0.3855];
col_(2,:) = [0.3687    0.0925    0.3491];

set(gca,'TickLabelInterpreter','tex')

b1 = plot(0.5,0.5,'w*'); hold on;
b2 = plot(0.5,0.5,'w*'); hold on;
scatter(fitted, generated, 18, col_(2,:), 'filled', 'MarkerFaceAlpha', 0.02);
%scatter(fitted, generated,'o','MarkerEdgeColor',col_(2,:), 'MarkerEdgeAlpha',0.05); hold on;
plot([-12 12],[-12 12],':k')
[r,p] = corr(fitted,generated, 'rows','complete', 'Type','Pearson');

if p<0.001
    l = legend([b1, b2],{strcat('r=',num2str(round(r,2))),strcat('p<.001')}); 
else
    l = legend([b1, b2],{strcat('r=',num2str(round(r,2))),strcat('p=',num2str(round(p,2)))}); 
end

legend boxoff;

set(l,'Position',legend_position, 'FontSize',16);

xlim([param_bounds(1) param_bounds(2)])
ylim([param_bounds(1) param_bounds(2)])
xticks([ticks_])
yticks([ticks_])

ylabel('Original value','FontName','Arial','Fontweight','bold','FontSize',12);
xlabel('Fitted value','FontName','Arial','Fontweight','bold','FontSize',12);

% Number and title
text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)     
title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

set(gca,'box','off')

end

