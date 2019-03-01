function [parameter_ranges] = generate_parameter_ranges(parameter_values, min_percent, max_percent)
parameter_mins = parameter_values * min_percent;
parameter_maxs = parameter_values * max_percent;

parameter_ranges = [parameter_mins; parameter_maxs]';
end
