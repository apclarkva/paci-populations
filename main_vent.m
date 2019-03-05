function [] = main_vent(set_index)
    addpath(genpath('ap_features'))

    max_step = 1e-3;
    initial_step = 2e-5;% default: 2e-5
    options = odeset('MaxStep',max_step,'InitialStep',initial_step);
    Y=[
        -0.070
        0.3
        0.0002
        1
        0
        1
        1
        1
        0
        1
        0
        0.75
        0.75
        0
        0.1
        1
        0
        10
        ];

    time_period = 425;
    g_CaL = 8.635702e-5;   % metre_cube_per_F_per_s (in i_CaL)
    g_K1 = 28.1492;   % S_per_F (in i_K1)
    g_Kr = 29.8667;   % S_per_F (in i_Kr)
    g_Ks = 2.041;   % S_per_F (in i_Ks)
    g_Na = 3671.2302;   % S_per_F (in i_Na)
    g_PCa = 0.4125;   % A_per_F (in i_PCa)
    g_b_Ca = 0.69264;   % S_per_F (in i_b_Ca)
    g_b_Na = 0.9;   % S_per_F (in i_b_Na)

    % Set parameter values from Paci
    paci_parameters = [g_CaL, g_K1, g_Kr, g_Ks, g_Na, g_PCa, g_b_Ca, g_b_Na];
    load("data/lhs_parameters_40000.mat");
    all_parameters = [paci_parameters', lhs_parameters];

    conductances = all_parameters(:,set_index);

    num_features = 7;

    [T,Yc] = ode15s(@(T, Yc) Ventricular_SI_working_withSTIM(T, Yc, conductances),[0 time_period],Y' ,options);

    t = T;
    Vm=Yc(:,1);

    try
        features = solve_for_features(t, Vm, time_period-15);
        [is_acceptable_ap, is_acceptable_ap_array] = does_pass(features);

        if sum(is_acceptable_ap_array) > 3
            csvwrite( strcat('./data/files_par/file_in', num2str(set_index), ".csv"), is_acceptable_ap_array )
        end

    catch

    end

end
