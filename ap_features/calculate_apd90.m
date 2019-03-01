function [apd90] = calculate_apd90(times,voltages)
% Find ap_start time
ap_start_time = calculate_ap_start(times, voltages);

ap_start_time = calculate_ap_start(times, voltages);

% calculate time at apd_90
apd_90_time = calculate_apd90_time(times, voltages);

apd90 = apd_90_time - ap_start_time;
end

function [ap_start_time] = calculate_ap_start(times,voltages)
voltage_diffs = diff(voltages);
time_diffs = diff(times);

rates = voltage_diffs ./ time_diffs';

accel_vs_time = diff(rates);
% Find the first point above 0.25
ap_threshold = .2;
ap_start_index = find(accel_vs_time > ap_threshold,1);

ap_start_time = times(ap_start_index - 2);
end

function [ap_start_voltage] = calculate_ap_start_voltage(times,voltages)
voltage_diffs = diff(voltages);
time_diffs = diff(times);

rates = voltage_diffs ./ time_diffs';

accel_vs_time = diff(rates);
% Find the first point above 0.25
ap_threshold = .1;
ap_start_index = find(accel_vs_time > ap_threshold,1);

ap_start_voltage = voltages(ap_start_index - 2);
end

function [apd90_time, apd90_voltage] = calculate_apd90_time(times, voltages)
% Find voltage of apd90. Attempt 1: mdp + apa * .1
% Need to limit subrange from amplitude to next_mdp
% mdp_voltage = calculate_mdp(voltages);
peak_voltage = calculate_peak_voltage(voltages);
% 
% apd90_voltage = mdp_voltage + .1 * (peak_voltage - mdp_voltage);

% Find voltage of apd90. Attempt 2: 
ap_start_voltage = calculate_ap_start_voltage(times, voltages);

apd90_voltage = ap_start_voltage + .1 * (peak_voltage - ap_start_voltage);

% Find peak voltage
[peak_voltage, peak_voltage_loc] = max(voltages);

% 
[peak_to_end_range_min_v,  peak_to_end_range_min_v_loc]= min(abs(voltages(peak_voltage_loc:end) - apd90_voltage));
apd90_loc = peak_voltage_loc + peak_to_end_range_min_v_loc;

apd90_time = times(apd90_loc);
end


% function [ap_start_time] = calculate_ap_start(times,voltages)
% time_diffs = diff(times);
% voltage_diffs = diff(voltages);
% 
% rates = voltage_diffs ./ time_diffs';
% 
% [d, max_accel] = max(diff(rates));
% 
% ap_start_time = times(max_accel);
% end




% keyboard
% 
% plot(times(1:end-1), rates/max(rates));
% hold on
% [d, max_accel] = max(diff(rates))
% plot(times(1:end-2), diff(rates));
% hold on
% 
% 
% keyboard


% keyboard
% 
% hax=axes;
% plot(times, voltages)
% hold on
% line([ap_start_time ap_start_time],get(hax,'YLim'),'Color',[1 0 0])
% hold on
% line([apd_90_time apd_90_time],get(hax,'YLim'),'Color',[1 0 0])
% % plot(time_between_mdps(1:end-1), rates/max(rates));
% % hold on
% % [d, max_accel] = max(diff(rates))
% % plot(time_between_mdps(1:end-2), diff(rates)/max(diff(rates)));
% % hold on
% 
% 
% % apd90_voltage = mdp + .1*apa;
% apd90_voltage = -.060 + .1*apa;
% 
% 
% peak_current_loc = peak_locs(mdp_current < peak_locs & peak_locs < mdp_next);
% 
% voltage_subrange = voltages(peak_current_loc:mdp_next);
% 
% [d, apd90_loc_in_subrange] = min( abs(voltage_subrange - apd90_voltage) );
% 
% % This is the location of the relaxation at 90%
% apd90_loc = peak_current_loc + apd90_loc_in_subrange;
% 
% % Find the rough time of the start of AP
% 
% 
% 
% 
% pp = spline(time_between_mdps,voltage_between_mdps);
% [fppmax,fppmaxloc] = slmpar(pp,'maxfpp')
% [d, time_loc] = min(abs(time_between_mdps - fppmaxloc));
% 
% ap_start_time = time_between_mdps(time_loc);
% 
% % [ap_start_rate, ap_start_loc_in_subrange] = max(rates);
% % [ap_start_rate, ap_start_loc_in_subrange] = max(diff(rates));
% 
% keyboard
% 
% ap_start_loc = mdp_current + ap_start_loc_in_subrange + 1;
% 
% 
% apd90 = times(apd90_loc) - times(ap_start_loc);

