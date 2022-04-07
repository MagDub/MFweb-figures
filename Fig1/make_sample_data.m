function [samples_1, samples_2, samples_3, samples_4] = make_sample_data(type_)

    % load
    folder_ = '../../../data_analysis/other/initial_samples_data/concat_data/';
    load(strcat(folder_, 'desc_split.mat'))

    cond = 'ABC';
    T=load(strcat(folder_,'split_mat_',type_,'_',cond,'.mat'));
    tmp_data = T.(strcat('split_mat_',type_,'_',cond));
    data_1 = tmp_data(:,[1,2,5,6]);

    cond = 'ABD';
    T=load(strcat(folder_,'split_mat_',type_,'_',cond,'.mat'));
    tmp_data = T.(strcat('split_mat_',type_,'_',cond));
    data_2 = tmp_data(:,[1,2,5,6]);

    cond = 'ACD';
    T=load(strcat(folder_,'split_mat_',type_,'_',cond,'.mat'));
    tmp_data = T.(strcat('split_mat_',type_,'_',cond));
    data_3 = tmp_data(:,[1,2,5,6]);

    cond = 'BCD';
    T=load(strcat(folder_,'split_mat_',type_,'_',cond,'.mat'));
    tmp_data = T.(strcat('split_mat_',type_,'_',cond));
    data_4 = tmp_data(:,[1,2,5,6]);
    
    data_all = [data_1; data_2; data_3; data_4];

    % remove nans
    tmp = data_all(:,1);
    tmp(isnan(tmp))=[];
    samples_1 = tmp;

    tmp = data_all(:,2);
    tmp(isnan(tmp))=[];
    samples_2 = tmp;

    tmp = data_all(:,3);
    tmp(isnan(tmp))=[];
    samples_3 = tmp;

    tmp = data_all(:,4);
    tmp(isnan(tmp))=[];
    samples_4 = tmp;

end

