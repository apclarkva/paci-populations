function [is_acceptable_ap, is_acceptable_ap_array] = does_pass(input_features)
% Array order: 
% % cycle_length,
% % spontaneous_heart_rate,
% % maximum_diastolic_potential,
% % peak_voltage,
% % action_potential_amplitude,
% % maximum_upstroke_velocity,
% % apd90

ma_paper_data = [1.7, .1;...
                 35.3, 2.2;...
                 -.0756, .0012;...
                 .0283, .0010;...
                 .104, .0011;...
                 27.8, 4.8;...
                 .4147, .0218];

dims_ma = size(ma_paper_data);
is_acceptable_ap_array = zeros(7,1);

for feature_index = 1:dims_ma(1)
    input_val = input_features(feature_index);
    sd_range = 3;
    feature_min = ma_paper_data(feature_index,1) - sd_range*ma_paper_data(feature_index,2);
    feature_max = ma_paper_data(feature_index,1) + sd_range*ma_paper_data(feature_index,2);
    
    if (feature_min < input_val && input_val < feature_max)
        is_acceptable_ap_array(feature_index) = 1;
    else
        is_acceptable_ap_array(feature_index) = 0; 
    end
end

is_acceptable_ap = sum(is_acceptable_ap_array) == 7;
end
