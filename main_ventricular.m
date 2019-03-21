%load ode15s_SS_stimolato_5p5_pA.mat
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

time_period = 450;
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

load("data/passing_features.mat");

% 1. parameter index
% 2. pass or not
% cycle_length 
% spontaneous_heart_rate 
% 5. maximum_diastolic_potential
% 6. peak_voltage,...
% 7. action_potential_amplitude,...
% 8. maximum_upstroke_velocity,...
% 9. apd90
% 10. sum of passing
viable_parameters_just_missed = feature_data(feature_data(:, 10) == 6, :);
paci = feature_data(1,:);

missed_CL = viable_parameters_just_missed(...
    viable_parameters_just_missed(:, 3) == 0,:);

missed_up = viable_parameters_just_missed(...
    viable_parameters_just_missed(:, 8) == 0,:);

missed_mdp = viable_parameters_just_missed(...
    viable_parameters_just_missed(:, 5) == 0,:);

missed_apa = viable_parameters_just_missed(...
    viable_parameters_just_missed(:, 7) == 0,:);

missed_apd90 = viable_parameters_just_missed(...
    viable_parameters_just_missed(:, 9) == 0,:);

% viable_parameters(26,:) = viable_parameters(1,:);


viable_parameters = [paci; missed_CL(1,:);...
                     paci; missed_mdp(1,:);
                     paci; missed_peak_v(1,:);
                     paci; missed_apd90(1,:)];

% for i = 1:length(viable_parameters(:, 1))
iteration = 1;
figure
for i = 1:8
%     set_index = i;
    set_index = viable_parameters(i,1);
%     set_index = indices(i);
    
    conductances = all_parameters(:,set_index);

    [T,Yc] = ode15s(@(T, Yc) Ventricular_SI_working_withSTIM(T, Yc, conductances),[0 time_period],Y' ,options);

    t = T;
    Vm=Yc(:,1);
    figure(1);
    try
        
        [t_single_ap, V_single_ap] = find_single_ap(t, Vm);
        
        if i < 3
           subplot(2,2,1);
        elseif i < 5
           subplot(2,2,2);
        elseif i < 7
           subplot(2,2,3); 
        else
           subplot(2,2,4); 
        end
        
        xlim([0, 2.5])
        
        if mod(i, 2) == 1
            plot(t_single_ap - min(t_single_ap), V_single_ap, "g", 'LineWidth',3);
        else
            plot(t_single_ap - min(t_single_ap), V_single_ap, "r", 'LineWidth',3);
        end
%         if i
%             plot(t_single_ap - min(t_single_ap), V_single_ap, "g", 'LineWidth',3);
%         else 
%             plot(t_single_ap - min(t_single_ap), V_single_ap, "k", 'LineWidth',2);
%         end
        
    hold on
    
    catch
%         figure(2);
%         plot(t, Vm, 'LineWidth', 3);
%         hold on
    end
%     
%     plot(t,Vm);
%     hold on;
    
end
% figure(2)
% gca
% title('Models w/o Spontaneous Beating', 'FontSize', 24)
% xlabel('Time (s)', 'FontSize', 20)
% ylabel('Voltage', 'FontSize', 20)

% 
% set_index = 1;
% conductances = all_parameters(:,set_index);
% [T,Yc] = ode15s(@(T, Yc) Ventricular_SI_working_withSTIM(T, Yc, conductances),[0 time_period],Y' ,options);
% t = T;
% Vm=Yc(:,1);
% [t_single_ap, V_single_ap] = find_single_ap(t, Vm);
% plot(t_single_ap - min(t_single_ap), V_single_ap, "y", 'LineWidth',3);
% 
% gca
% title('25 Passing Plots from 40,000 LHS-Gen Models', 'FontSize', 24)
% xlabel('Time (s)', 'FontSize', 20)
% ylabel('Voltage', 'FontSize', 20)

% save('ap-validation_40000.mat', 'is_acceptable_aps', 'is_acceptable_features', 'passing_cols')

