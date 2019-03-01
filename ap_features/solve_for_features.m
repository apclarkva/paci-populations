function [all_features] = solve_for_features(times,voltages,start_time)
% Check existence in a conditional
% if exist start_time == 0
%     start_time = 1000;
% end


time_range = [start_time, start_time + 10];

% Find locations closest to values in time_range
[time_small, smallest_time_location] = min(abs(times -  start_time));
[time_large, largest_time_location] = min(abs(times -  time_range(2)));

% Limit times and voltages to a 5-second range
t_of_interest = times(smallest_time_location:largest_time_location);
V_of_interest = voltages(smallest_time_location:largest_time_location);

% Find single AP -- from one mdp to the next
[t_single_ap, V_single_ap] = find_single_ap(t_of_interest, V_of_interest);

% Find cycle length -- time per beat: Ma ( 1.7 ± 0.1); Paci (1.6)
cycle_length = calculate_cycle_length(t_single_ap); % in seconds

% From Paci, spontaneous beating rate is inverse cyle length * 60: Ma (
% 35.3 ± 2.2); Paci ( 37.4)
spontaneous_heart_rate = calculate_spontaneous_heart_rate(t_single_ap); % in BPM

% MDP -- Maximum diastolic potential: Ma (-75.6 ± 1.2); Paci (76.7)
maximum_diastolic_potential = calculate_mdp(V_single_ap);

% Peak -- peak AP: Ma (28.3 ± 1.0 mV); Paci (28.1)
peak_voltage = calculate_peak_voltage(V_single_ap);

% APA -- AP amplitude: Ma (104.0 ± 1.1 mV); Paci (104.8 mV)
action_potential_amplitude = calculate_action_potential_amplitude(V_single_ap);

% Find Vmax -- maximum upstroke velocity: Ma ( 27.8 ± 4.8); Paci (24.4)
maximum_upstroke_velocity = calculate_vmax(t_single_ap, V_single_ap);

% APD90 -- Action potential duration at 90% repolarization: Ma (414.7 ±
% 21.8 ms); Paci (417.5 ms)
apd90 = calculate_apd90(t_single_ap, V_single_ap);

% All features: cycle_length,spontaneous_heart_rate,maximum_diastolic_potential,peak_voltage,action_potential_amplitude,maximum_upstroke_velocity,apd90
all_features = [cycle_length, ...
    spontaneous_heart_rate,...
    maximum_diastolic_potential,...
    peak_voltage,...
    action_potential_amplitude,...
    maximum_upstroke_velocity,...
    apd90];
end

