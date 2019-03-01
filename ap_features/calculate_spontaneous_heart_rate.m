function [spontaneous_heart_rate] = calculate_spontancous_heart_rate(t_single_ap)
spontaneous_heart_rate = 1/calculate_cycle_length(t_single_ap) * 60;
end

