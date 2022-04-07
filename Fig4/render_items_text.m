function [] = render_items_text(col_name)

    % Factor loadings on each item from R
    T = readtable('../../data_analysis/10_stats/FA/loadingsplot.csv');
    T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

    [data_load_F, I] = sort(T.(col_name), 'descend');
    data_item = T.Item(I);

    T2 = table(data_item, data_load_F);

    % colors matchign with R
    col_desc = {'BIS', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'SDS', 'STAI', 'IUS', 'LSAS'};
    col_R = {'#999999', '#E69F00','#000000', '#4daf4a','#984ea3','#0072B2','#D55E00', '#56B4E9', '#f781bf'};
    %col_R = {'#e41a1c'	'#377eb8'	'#4daf4a'	'#984ea3'	'#ff7f00'	'#ffff33'	'#a65628'	'#f781bf'	'#999999'};

    col_ = [];
    for c=1:size(col_R,2)
        str_ = col_R{c};
        col_(end+1,1:3) = sscanf(str_(2:end),'%2x%2x%2x',[1 3])/255;
    end

    % sort with absolute value this time
    [data_load_F, I] = sort(abs(T.(col_name)), 'descend');
    data_item = T.Item(I);
    Tabs = table(data_item, data_load_F);

    n_max = 10;
    items_txt = Tabs.data_item(1:n_max);

    for i=1:size(items_txt,1)
        str_ = items_txt{i};
        str_ = strrep(str_,'_item_',' ');
        [~, idx] = ismember(str_, ' ');
        [~, id] = find(idx==1);
        quest_name = str_(1:id-1);
        load(strcat('./items_string/items_', quest_name));
        item_ = items_str{str2num(str_(id+1:end))};
        k = strfind(item_,'.');
        item_=item_(k:end);
        if strcmp(col_name, 'loading_F1') 
            if i==4
                item_ = '. I have the self-confidence to try different ways of behaving';
            end
        elseif strcmp(col_name, 'loading_F3') 
            if i==3
                item_ = '. How often do you leave your seat in meetings (...) ?';
            elseif i==4
                item_ = '. I get nasty thoughts and have difficulty getting rid of them';
            elseif i==7
                item_ = '. I am upset by unpleasant thoughts that come against my will';
            elseif i==8
                item_ = '. How often do you have difficulty waiting your turn (...) ?';
            end
        end
        %text(-0.25,1.05-(0.13*i),strcat(num2str(i), '.',32, quest_name, item_), 'Color', col_(contains(col_desc,quest_name),:));
        text(-0.21,1.35-(0.13*i),strcat(num2str(i), '.',32, quest_name, item_), 'Color', col_(contains(col_desc,quest_name),:));
    end

    %title(strcat(num2str(n_max), 32, 'most loading items'),'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
   axis off

end