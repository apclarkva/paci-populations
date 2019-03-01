function [Vmax] = calculate_vmax(times,voltages)
voltage_diffs = diff(voltages);
time_diffs = diff(times);

rates = voltage_diffs ./ time_diffs;

Vmax = max(rates);
Vmax = Vmax(1);
end