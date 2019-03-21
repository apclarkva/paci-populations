function [all_coupled] = couple_coefficients(row,column)
adjacent_couple = 7;
diag_couple = adjacent_couple/2;

zeros(row, column, 9);

% Grid is: {row, column}
% 1{-1, -1} 2{-1, 0} 3{-1, 1}
% 4{0, -1} 5{0, 0} 6{0, 1}
% 7{1, -1} 8{1, 0} 9{1, 1}

default_array = [diag_couple adjacent_couple diag_couple ...
                 adjacent_couple 0 adjacent_couple ...
                 diag_couple adjacent_couple diag_couple];

all_coupled = repmat(default_array, row*column, 1);
all_coupled = reshape(all_coupled, row, column, 9);

% Set row = 1 cells to have 0 for positions 1, 2, and 3 
all_coupled(1, :, 1:3) = 0;

% Set row = row cells to have 0 for positions 7, 8, and 9 
all_coupled(row, :, 7:9) = 0;

% Set column = 1 cells to have 0 for positions 1, 4, 7
all_coupled(:, 1, [1, 4, 7]) = 0;

% Set column = column cells to have 0 for positions 3, 6, 9
all_coupled(:, column, [3, 6, 9]) = 0;
end