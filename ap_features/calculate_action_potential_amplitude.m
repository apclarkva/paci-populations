function [apa] = calculate_action_potential_amplitude(voltages)
apa = calculate_peak_voltage(voltages) - calculate_mdp(voltages);
end

