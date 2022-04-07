
% Factor loadings on each item from R
T = readtable('../../../data_analysis/10_stats/FA/loadingsplot.csv');
T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};


[data_load_F1, I] = sort(T.loading_F1, 'descend');
data_item = T.Item(I);

T2 = table(data_item, data_load_F1);

BIS_ind = []; ASRS_ind = []; AQ10_ind = []; CFS_ind = []; OCIR_ind = [];
SDS_ind = []; STAI_ind = []; IUS_ind = []; LSAS_ind = [];

for i=1:size(T2,1)
    if ~isempty(strfind(T2.data_item{i,:},'BIS_'))
        BIS_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'ASRS_'))
        ASRS_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'AQ10_'))
        AQ10_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'CFS_'))
        CFS_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'OCIR_'))
        OCIR_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'SDS_'))
        SDS_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'STAI_'))
        STAI_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'IUS_'))
        IUS_ind(end+1) = i;
    elseif ~isempty(strfind(T2.data_item{i,:},'LSAS_'))
        LSAS_ind(end+1) = i;
    end
end

% colors matchign with R
col_desc = {'BIS', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'SDS', 'STAI', 'IUS', 'LSAS'};
col_R = {'#999999', '#E69F00','#000000', '#76EE00','#F0E442','#0072B2','#D55E00', '#56B4E9', '#009E73'};

col_ = [];
for c=1:size(col_R,2)
    str_ = col_R{c};
    col_(end+1,1:3) = sscanf(str_(2:end),'%2x%2x%2x',[1 3])/255;
end

% x axis
item_no = 1:size(T2,1);

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 25 25]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

% bar plots
subplot(2,1,1)
hold all;
bar(item_no(BIS_ind), T2.data_load_F1(BIS_ind), 'FaceColor', col_(contains(col_desc,'BIS'),:));
bar(item_no(ASRS_ind), T2.data_load_F1(ASRS_ind), 'FaceColor', col_(contains(col_desc,'ASRS'),:));
bar(item_no(AQ10_ind), T2.data_load_F1(AQ10_ind), 'FaceColor', col_(contains(col_desc,'AQ10'),:));
bar(item_no(CFS_ind), T2.data_load_F1(CFS_ind), 'FaceColor', col_(contains(col_desc,'CFS'),:));
bar(item_no(OCIR_ind), T2.data_load_F1(OCIR_ind), 'FaceColor', col_(contains(col_desc,'OCIR'),:));
bar(item_no(SDS_ind), T2.data_load_F1(SDS_ind), 'FaceColor', col_(contains(col_desc,'SDS'),:));
bar(item_no(STAI_ind), T2.data_load_F1(STAI_ind), 'FaceColor', col_(contains(col_desc,'STAI'),:));
bar(item_no(IUS_ind), T2.data_load_F1(IUS_ind), 'FaceColor', col_(contains(col_desc,'IUS'),:));
bar(item_no(LSAS_ind), T2.data_load_F1(LSAS_ind), 'FaceColor', col_(contains(col_desc,'LSAS'),:));
hold off;

% properties
ylim([-0.7, 0.7])
xlabel('Items','FontName','Arial','Fontweight','bold','FontSize',12);
ylabel('Loading','FontName','Arial','Fontweight','bold','FontSize',12);
legend(col_desc,'Orientation','horizontal', 'Location', 'SouthEast');
legend boxoff;
title('Factor 1 item loads','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
set(gca,'box','off')

subplot(2,1,2)

% sort with absolute value this time
[data_load_F1, I] = sort(abs(T.loading_F1), 'descend');
data_item = T.Item(I);
Tabs = table(data_item, data_load_F1);

n_max = 20;
items_txt = Tabs.data_item(1:n_max);

for i=1:size(items_txt,1)
    str_ = items_txt{i};
    str_ = strrep(str_,'_item_',' ');
    [~, idx] = ismember(str_, ' ');
    [~, id] = find(idx==1);
    quest_name = str_(1:id-1);
    load(strcat('items_string/items_', quest_name));
    item_ = items_str{str2num(str_(id+1:end))};
    text(-0.05,1.05-(0.065*i),strcat(num2str(i), '.',32, quest_name, item_), 'Color', col_(contains(col_desc,quest_name),:));
end

title(strcat(num2str(n_max), 32, 'most loading items'),'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
axis off

%Export
addpath('../../../export_fig')
export_fig(['Fig_items_F1.tif'],'-nocrop','-r200')