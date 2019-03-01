function [times_single_ap,voltage_single_ap] = ap_amplitude3x(times,voltages)
[apa_voltages,apa_locs] = findpeaks(voltages);

apa_current = apa_locs(2);
apa_next = apa_locs(4);

% Find ap_start first
times_single_ap = times(apa_current:apa_next);
voltage_single_ap = voltages(apa_current:apa_next);
end

