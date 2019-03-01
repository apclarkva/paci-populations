function [bin_limits] = generate_parameter_bins(parameter_ranges,number_of_models)
size_range = size(parameter_ranges);
num_parameters = size_range(1);

% Need n + 1 splits (including ends) to have n bins
bin_limits = zeros(num_parameters, number_of_models + 1);

for row = 1:num_parameters
   bin_limits(row,:) = linspace(parameter_ranges(row,1), parameter_ranges(row,2), number_of_models + 1);
end
end

