features = solve_for_features(times, voltages, 1000);

[is_acceptable_ap, is_acceptable_ap_array] = does_pass(features);