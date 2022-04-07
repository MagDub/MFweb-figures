addpath('../../cmocean/')

load('../../../data_analysis/usermat_completed.mat')
load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%%% Data 

% Quest
load('../../../data/questionnaire/all/AQ10_all.mat')
load('../../../data/questionnaire/all/ASRS_all.mat')
load('../../../data/questionnaire/all/BIS11_all.mat')
load('../../../data/questionnaire/all/CFS_all.mat')
load('../../../data/questionnaire/all/STAI_all.mat')
load('../../../data/questionnaire/all/IUS_all.mat')
load('../../../data/questionnaire/all/LSAS_all.mat')
load('../../../data/questionnaire/all/SDS_all.mat')
load('../../../data/questionnaire/all/OCIR_all.mat')
ASRS_all(to_del,:) = [];
BIS11_all(to_del,:) = [];
CFS_all(to_del,:) = [];
STAI_all(to_del,:) = [];
IUS_all(to_del,:) = [];
LSAS_all(to_del,:) = [];
SDS_all(to_del,:) = [];
OCIR_all(to_del,:) = [];
AQ10_all(to_del,:) = [];

all= [ASRS_all(:,1), BIS11_all(:,1), CFS_all(:,1), STAI_all(:,1), IUS_all(:,1), LSAS_all(:,1), SDS_all(:,1), OCIR_all(:,1), AQ10_all(:,1)];

param_legends={'ASRS', 'BIS11', 'CFS', 'STAI', 'IUS', 'LSAS', 'SDS', 'OCIR', 'AQ10'};

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 15]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

for j = 1:size(all,2)
    for i = 1:size(all,2)
        rho = corr(all(:,i),all(:,j), 'rows','complete', 'Type','Pearson');
        parameter_recov_mat(j,i) = rho;
    end
end

parameter_recov_mat = flipud(parameter_recov_mat);

imagesc(abs(parameter_recov_mat))

xticks([1:9])
xlim([0.5 9.5])
xticklabels({param_legends{1}, param_legends{2}, param_legends{3}, param_legends{4}, param_legends{5}, param_legends{6}, param_legends{7}, param_legends{8}, param_legends{9}})
yticks([1:9])
ylim([0.5 9.5])
yticklabels({param_legends{9}, param_legends{8}, param_legends{7}, param_legends{6}, param_legends{5}, param_legends{4}, param_legends{3}, param_legends{2}, param_legends{1}})

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',10, 'YDir', 'reverse')

cmap=cmocean('matter'); % ice or dense 
%colormap( cmap );
colormap( flipud(cmap) );
    
caxis([0 1])
h = colorbar('Ticks',0:0.2:1); 
title(h,'r','Interpreter','tex')

textStrings = num2str(parameter_recov_mat(:), '%0.2f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
[x, y] = meshgrid(1:size(all,2));  % Create x and y coordinates for the strings

% % Upper diag
% for i_=1:size(x,1)-1
%     x(1:size(x,1)-i_,i_)=nan;
% end

% % Lower diag
% for i_=1:size(x,1)-1
%     x(size(x,1)-(i_-1),(i_+1):size(x,1)) = nan;
% end


hStrings = text(x(:), y(:), textStrings(:),'HorizontalAlignment', 'center', 'Color', 'k','FontSize', 11);
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range;

%Export
addpath('../../../export_fig')
export_fig(['FigFAcorrel_quest.tif'],'-nocrop','-r200')

