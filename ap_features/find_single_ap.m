function [times_single_ap, voltage_single_ap] = find_single_ap(times,voltages)
[apa_voltages,apa_locs] = findpeaks(voltages);

apa_current = apa_locs(length(apa_locs)-3);
apa_next = apa_locs(length(apa_locs)-2);

% Cycle length
time_start = times(apa_current) - .2;
time_end = times(apa_next) - .2;

% Find start and end location of AP
[time_start, start_location] = min(abs(times - time_start));
[time_end, end_location] = min(abs(times - time_end));

% Find ap_start first
times_single_ap = times(start_location:end_location);
voltage_single_ap = voltages(start_location:end_location);
end