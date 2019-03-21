% Save constants to Y
% Set ODE options

% Increase grid to 5x5 and look at behavior

rows = 5;
columns = 5;
time_period = 450;

% Inputs:
% % Grid shape
% % Model parameter values
% % Eventually: coupling coefficients
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
load("../data/lhs_parameters_40000.mat");
all_parameters = [paci_parameters', lhs_parameters];

load("../data/passing_features.mat");
viable_parameters = feature_data(feature_data(:, 10) > 6, :);
viable_parameters(2,:) = viable_parameters(1,:);

indices_viable_parameters = viable_parameters(1:rows*columns,1);

indices_viable_parameters = repmat(indices_viable_parameters, 4,1);

% rows = 10;
% columns = 10;


% 8 x rows*columns -- 8 rows of parameters by 20 columns of models
conductances = all_parameters(:,indices_viable_parameters);

% rows x columns x coupling coefficents
all_coupling = couple_coefficients(rows, columns);
% all_coupling_zero = zeros(rows, columns, 9);

options = odeset('MaxStep',1e-3,'InitialStep',2e-5);
Y=repmat([-0.070 0.3 0.0002 1 0 1 1 1 0 1 0 0.75 0.75 0 0.1 1 0 14.1], 1, rows*columns);

[T,Yc] = ode15s(@(T, Yc) Compute_Clustered_Voltage(T, Yc, conductances, all_coupling),[0 time_period],Y, options);
t = T;
Vm_1=Yc(:,1);
Vm_2=Yc(:,19);
% dVm = [0; diff(Vm)./diff(t)];
% caSR = Yc(:,2);
% Cai = Yc(:,3);
% Nai = Yc(:,18);
