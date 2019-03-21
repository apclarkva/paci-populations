% This script is my first-pass at generating potential parameter sets for
% inputs to the Paci cell. I use the LHS method to generate the parameter
% sets. These parameter sets will be used to set the parameters in a Paci
% cell. From there, I will output readings from Paci cells with each of the
% different parameter sets.

% Parameters include: Na, Ca, to, f, Kr, Ks, K1
g_CaL = 8.635702e-5;   % metre_cube_per_F_per_s (in i_CaL)
g_K1 = 28.1492;   % S_per_F (in i_K1)
g_Kr = 29.8667;   % S_per_F (in i_Kr)
g_Ks = 2.041;   % S_per_F (in i_Ks)
g_Na = 3671.2302;   % S_per_F (in i_Na)
g_PCa = 0.4125;   % A_per_F (in i_PCa)
g_b_Ca = 0.69264;   % S_per_F (in i_b_Ca)
g_b_Na = 0.9;   % S_per_F (in i_b_Na)
% tau_fCa = 0.002;   % second (in i_CaL_fCa_gate)
% tau_g = 0.002;   % second (in calcium_dynamics)

% Consider time constants

% Set parameter values from Paci
parameter_values = [g_CaL, g_K1, g_Kr, g_Ks, g_Na, g_PCa, g_b_Ca, g_b_Na];

% % % % 
min_percent = .001; % .1 percent
max_percent = 3; % 200%
parameter_ranges = generate_parameter_ranges(parameter_values, min_percent, max_percent);

% % % % 
number_of_models = 40000;
number_of_parameters = length(parameter_values);
random_bin_selections = generate_lhs_selection(number_of_models, number_of_parameters);

% % % 
bin_limits = generate_parameter_bins(parameter_ranges, number_of_models);


lhs_parameters = generate_lhs_parameters(random_bin_selections, bin_limits);







