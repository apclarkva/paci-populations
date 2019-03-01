function [time_between_beats] = calculate_cycle_length(t_single_ap)
time_between_beats = t_single_ap(end) - t_single_ap(1);
end

