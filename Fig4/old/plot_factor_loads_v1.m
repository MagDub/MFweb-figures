function [col_, col_desc, leg_desc] = plot_factor_loads_v1(loading_data, item_desc, title_)

    BIS_ind = []; ASRS_ind = []; AQ10_ind = []; CFS_ind = []; OCIR_ind = [];
    SDS_ind = []; STAI_ind = []; IUS_ind = []; LSAS_ind = [];

    for i=1:size(item_desc,1)
        if ~isempty(strfind(item_desc{i,:},'BIS_'))
            BIS_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'ASRS_'))
            ASRS_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'AQ10_'))
            AQ10_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'CFS_'))
            CFS_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'OCIR_'))
            OCIR_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'SDS_'))
            SDS_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'STAI_'))
            STAI_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'IUS_'))
            IUS_ind(end+1) = i;
        elseif ~isempty(strfind(item_desc{i,:},'LSAS_'))
            LSAS_ind(end+1) = i;
        end
    end

    % Colors matchign with R
    col_desc = {'BIS', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'SDS', 'STAI', 'IUS', 'LSAS'};
    col_R = {'#999999', '#E69F00','#000000', '#76EE00','#F0E442','#0072B2','#D55E00', '#56B4E9', '#009E73'};

    col_ = [];
    for c=1:size(col_R,2)
        str_ = col_R{c};
        col_(end+1,1:3) = sscanf(str_(2:end),'%2x%2x%2x',[1 3])/255;
    end

    % Plot
    hold all;
    
    % x axis
    item_no = 1:size(loading_data,1);

    % bars
    bar(item_no(BIS_ind), loading_data(BIS_ind), 'FaceColor', col_(contains(col_desc,'BIS'),:));
    bar(item_no(ASRS_ind), loading_data(ASRS_ind), 'FaceColor', col_(contains(col_desc,'ASRS'),:));
    bar(item_no(AQ10_ind), loading_data(AQ10_ind), 'FaceColor', col_(contains(col_desc,'AQ10'),:));
    bar(item_no(CFS_ind), loading_data(CFS_ind), 'FaceColor', col_(contains(col_desc,'CFS'),:));
    bar(item_no(OCIR_ind), loading_data(OCIR_ind), 'FaceColor', col_(contains(col_desc,'OCIR'),:));
    bar(item_no(SDS_ind), loading_data(SDS_ind), 'FaceColor', col_(contains(col_desc,'SDS'),:));
    bar(item_no(STAI_ind), loading_data(STAI_ind), 'FaceColor', col_(contains(col_desc,'STAI'),:));
    bar(item_no(IUS_ind), loading_data(IUS_ind), 'FaceColor', col_(contains(col_desc,'IUS'),:));
    bar(item_no(LSAS_ind), loading_data(LSAS_ind), 'FaceColor', col_(contains(col_desc,'LSAS'),:));
    
    % properties
    leg_desc = {'Impulsivity', 'ADHD', 'Autism', 'Cognitive flexibility', 'OCD', 'Depression', 'Trait Anxiety', 'Uncertainty intolerance', 'Social Anxiety'};
    legend(leg_desc,'Orientation','horizontal','Location', 'SouthWest');
    legend boxoff;
    
    ylim([-1.2, 1.2])
    xlabel('Items','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel('Loading','FontName','Arial','Fontweight','bold','FontSize',12);
    
    title(title_, 'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    set(gca,'box','off');
   

end

