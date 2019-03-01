function [lhs_parameters] = generate_lhs_parameters(random_bin_selections, bin_limits)
size_matrix = size(random_bin_selections);
num_rows = size_matrix(1);
num_cols = size_matrix(2);

lhs_parameters = zeros(size(random_bin_selections));

for row = 1:num_rows
    for column = 1:num_cols
       param_bin = random_bin_selections(row, column);
       lower_limit = bin_limits(row, param_bin);
       upper_limit = bin_limits(row, param_bin+1);
       bin_size = upper_limit - lower_limit;
       new_parameter = lower_limit + bin_size * rand;
       lhs_parameters(row, column) = new_parameter;
    end
end
end

