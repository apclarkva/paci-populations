function [surrounding_voltages] = find_adjacent_voltages(row, column, num_rows, num_cols, Y)
all_voltage_indices = (1:num_rows*num_cols)*18 - 17;
all_voltages = Y(all_voltage_indices);

row_starts = (1:num_rows) * num_cols -(num_cols-1);

% 1{-1, -1} 2{-1, 0} 3{-1, 1}
% 4{0, -1} 5{0, 0} 6{0, 1}
% 7{1, -1} 8{1, 0} 9{1, 1}

% first row
surrounding_voltages = zeros(1,9);

num_iteration = 1;

for i = -1:1
    for j = -1:1
       try
         r = row + i;
         c = column + j;
         if r > 0 && r <= num_rows && c > 0 && c <= num_cols
            curr_cell_index = (r - 1)*num_cols + c;
            surrounding_voltages(num_iteration) = all_voltages(curr_cell_index); 
         end
       catch 
       end
       
       if num_iteration == 5
           surrounding_voltages(num_iteration) = 0;
       end
       num_iteration = num_iteration + 1;
    end
end
end

