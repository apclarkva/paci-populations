files = dir('./files_par/*.csv');

num_files = length(files);
num_features = 7;

feature_data = zeros(num_files, num_features + 3);

% parameter index
% passes all 7 (1 or 0)
% rows 3-9 are 1 for passing given feature and 0 for not
i = 1;

for file = files'
    parameters_index = erase(file.name,'file_in');
    parameters_index = erase(parameters_index,'.csv');
    
    feature_values = csvread(strcat('./files_par/', file.name));
    
    sum_feature_values = sum(feature_values);
    
    feature_data(i, 1) = str2num(parameters_index);
    feature_data(i, 3:9) = feature_values';
    feature_data(i, 10) = sum_feature_values;
    
    if sum(feature_values) > 6
        feature_data(i, 2) = 1;
    end
    i = i + 1;
end


save('passing_features.mat', 'feature_data')


