   

    % Factor loadings on each item from R
    T = readtable('../../data_analysis/10_stats/FA/loadingsplot.csv');
    T.Properties.VariableNames = {'Item', 'loading_F1', 'loading_F2', 'loading_F3'};

    items_txt = T.Item;

    % colors matchign with R
    col_desc = {'BIS', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'SDS', 'STAI', 'IUS', 'LSAS'};
    col_R = {'#999999', '#E69F00','#000000', '#4daf4a','#984ea3','#0072B2','#D55E00', '#56B4E9', '#f781bf'};   

    for i=1:size(items_txt,1)
        str_ = items_txt{i};
        str_ = strrep(str_,'_item_',' ');
        [~, idx] = ismember(str_, ' ');
        [~, id] = find(idx==1);
        quest_name = str_(1:id-1);
        load(strcat('./items_string/items_', quest_name));
        item_ = items_str{str2num(str_(id+1:end))};

        tmp_item = strcat(quest_name,'_', item_);

        T.Item{i} = tmp_item;

    end
