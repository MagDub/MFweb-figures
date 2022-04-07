function [col_, col_desc, leg_desc] = plot_factor_loads(loading_data, item_desc, title_, letter)

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

    % Colors matching with R
    col_desc = {'BIS', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'SDS', 'STAI', 'IUS', 'LSAS'};
    col_R = {'#999999', '#E69F00','#000000', '#4daf4a','#984ea3','#0072B2','#D55E00', '#56B4E9', '#f781bf'};
    % col_R = {'#999999', '#E69F00','#000000', '#76EE00','#F0E442','#0072B2','#D55E00', '#56B4E9', '#009E73'};

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
    bar(item_no(BIS_ind), loading_data(BIS_ind), 'FaceColor', col_(contains(col_desc,'BIS'),:),'LineStyle','none')
    bar(item_no(ASRS_ind), loading_data(ASRS_ind), 'FaceColor', col_(contains(col_desc,'ASRS'),:),'LineStyle','none')
    bar(item_no(AQ10_ind), loading_data(AQ10_ind), 'FaceColor', col_(contains(col_desc,'AQ10'),:),'LineStyle','none')
    bar(item_no(CFS_ind), loading_data(CFS_ind), 'FaceColor', col_(contains(col_desc,'CFS'),:),'LineStyle','none')
    bar(item_no(OCIR_ind), loading_data(OCIR_ind), 'FaceColor', col_(contains(col_desc,'OCIR'),:),'LineStyle','none')
    bar(item_no(SDS_ind), loading_data(SDS_ind), 'FaceColor', col_(contains(col_desc,'SDS'),:),'LineStyle','none')
    bar(item_no(STAI_ind), loading_data(STAI_ind), 'FaceColor', col_(contains(col_desc,'STAI'),:),'LineStyle','none')
    bar(item_no(IUS_ind), loading_data(IUS_ind), 'FaceColor', col_(contains(col_desc,'IUS'),:),'LineStyle','none')
    bar(item_no(LSAS_ind), loading_data(LSAS_ind), 'FaceColor', col_(contains(col_desc,'LSAS'),:),'LineStyle','none')
    
    % properties
    leg_desc = {'Impulsivity', 'ADHD', 'Autism', 'Cognitive flexibility', 'OCD', 'Depression', 'Trait Anxiety', 'Uncertainty intolerance', 'Social Anxiety'};
    
    ylim([-0.76, 0.76])
    xlabel('Items','FontName','Arial','Fontweight','bold','FontSize',10);
    xlim([0, size(loading_data,1)])
    ylabel('Loading','FontName','Arial','Fontweight','bold','FontSize',10);
    
    set(gca,'xtick',[])
    h = gca; h.XAxis.Visible = 'off';
        
    %Create a legend 
    %h=plot(nan,nan, 'w');
    %hl=legend(h,title_,'Orientation','horizontal','Location', 'NorthOutside');
    %set(hl,'FontSize',15);
    %legend boxoff;
    
   title(title_)
    
   text(0-0.1, 1+1,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)    

end

