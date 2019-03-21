%===============================================================================
% CellML file:   C:\Users\pax\Downloads\Atrial_SI_working.cellml
% CellML model:  paci_hyttinen_aaltosetala_severi_atrial
% Date and time: 24/05/2013 at 09:00:22
%-------------------------------------------------------------------------------
% Conversion from CellML 1.0 to MATLAB (init) was done using COR (0.9.31.1371)
%    Copyright 2002-2013 Dr Alan Garny
%    http://cor.physiol.ox.ac.uk/ - cor@physiol.ox.ac.uk
%-------------------------------------------------------------------------------
% http://www.cellml.org/
%===============================================================================


function [dYs, dati] = Compute_Clustered_Voltage(time, Ys, cell_params, junctions)

%-------------------------------------------------------------------------------
% Initial conditions
%-------------------------------------------------------------------------------
size_grid = size(junctions);
size_grid = size_grid(1:2);
num_rows = size_grid(1);
num_cols = size_grid(2);
num_cells = num_rows * num_cols;

% Y = [-0.068733823452164, 0.149980051221604, 4.49232909234503e-5, 0.999995518037806, 0.000127632520741878, 0.98038400433601, 0.999953006710394, 0.997346890768643, 0.0257889110986083, 0.405046678739985, 0.0447460799149437, 0.642108593994587, 0.173566329483423, 0.141183142078492, 0.0607988713874682, 0.776163826643278, 0.000503296941001262, 14.4424010544424];


% YNames = {'Vm', 'Ca_SR', 'Cai', 'g', 'd', 'f1', 'f2', 'fCa', 'Xr1', 'Xr2', 'Xs', 'h', 'j', 'm', 'Xf', 'q', 'r', 'Nai'};
% YUnits = {'volt', 'millimolar', 'millimolar', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'dimensionless', 'millimolar'};
% YComponents = {'Membrane', 'calcium_dynamics', 'calcium_dynamics', 'calcium_dynamics', 'i_CaL_d_gate', 'i_CaL_f1_gate', 'i_CaL_f2_gate', 'i_CaL_fCa_gate', 'i_Kr_Xr1_gate', 'i_Kr_Xr2_gate', 'i_Ks_Xs_gate', 'i_Na_h_gate', 'i_Na_j_gate', 'i_Na_m_gate', 'i_f_Xf_gate', 'i_to_q_gate', 'i_to_r_gate', 'sodium_dynamics'};

%-------------------------------------------------------------------------------
% State variables
%-------------------------------------------------------------------------------

% 1: Vm (volt) (in Membrane)
% 2: Ca_SR (millimolar) (in calcium_dynamics)
% 3: Cai (millimolar) (in calcium_dynamics)
% 4: g (dimensionless) (in calcium_dynamics)
% 5: d (dimensionless) (in i_CaL_d_gate)
% 6: f1 (dimensionless) (in i_CaL_f1_gate)
% 7: f2 (dimensionless) (in i_CaL_f2_gate)
% 8: fCa (dimensionless) (in i_CaL_fCa_gate)
% 9: Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% 10: Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% 11: Xs (dimensionless) (in i_Ks_Xs_gate)
% 12: h (dimensionless) (in i_Na_h_gate)
% 13: j (dimensionless) (in i_Na_j_gate)
% 14: m (dimensionless) (in i_Na_m_gate)
% 15: Xf (dimensionless) (in i_f_Xf_gate)
% 16: q (dimensionless) (in i_to_q_gate)
% 17: r (dimensionless) (in i_to_r_gate)
% 18: Nai (millimolar) (in sodium_dynamics)


% Y = [-0.068733823452164, 0.149980051221604, 4.49232909234503e-5, 0.999995518037806, 0.000127632520741878, 0.98038400433601, 0.999953006710394, 0.997346890768643, 0.0257889110986083, 0.405046678739985, 0.0447460799149437, 0.642108593994587, 0.173566329483423, 0.141183142078492, 0.0607988713874682, 0.776163826643278, 0.000503296941001262, 14.4424010544424];
% Y=[
%     -0.070
%     0.3
%     0.0002
%     1
%     0
%     1
%     1
%     1
%     0
%     1
%     0
%     0.75
%     0.75
%     0
%     0.1
%     1
%     0
%     14.1
%     ];

%-------------------------------------------------------------------------------
% Constants
%-------------------------------------------------------------------------------

Buf_C = 0.25;   % millimolar (in calcium_dynamics)
Buf_SR = 10.0;   % millimolar (in calcium_dynamics)
Kbuf_C = 0.001;   % millimolar (in calcium_dynamics)
Kbuf_SR = 0.3;   % millimolar (in calcium_dynamics)
Kup = 0.00025;   % millimolar (in calcium_dynamics)
V_leak = 0.00044444;   % per_second (in calcium_dynamics)
VmaxUp = 0.22;   % millimolar_per_second (in calcium_dynamics)
a_rel = 16.464;   % millimolar_per_second (in calcium_dynamics)
b_rel = 0.25;   % millimolar (in calcium_dynamics)
c_rel = 8.232;   % millimolar_per_second (in calcium_dynamics)
tau_g = 0.002;   % second (in calcium_dynamics)
PkNa = 0.03;   % dimensionless (in electric_potentials)
tau_fCa = 0.002;   % second (in i_CaL_fCa_gate)
g_CaL = 8.635702e-5;   % metre_cube_per_F_per_s (in i_CaL)
g_K1 = 19.1925;   % S_per_F (in i_K1)
L0 = 0.025;   % dimensionless (in i_Kr_Xr1_gate)
Q = 2.3;   % dimensionless (in i_Kr_Xr1_gate)
g_Kr = 29.8667;   % S_per_F (in i_Kr)
g_Ks = 2.041;   % S_per_F (in i_Ks)
KmCa = 1.38;   % millimolar (in i_NaCa)
KmNai = 87.5;   % millimolar (in i_NaCa)
Ksat = 0.1;   % dimensionless (in i_NaCa)
alpha = 2.8571432;   % dimensionless (in i_NaCa)
gamma = 0.35;   % dimensionless (in i_NaCa)
kNaCa = 2450.0;   % A_per_F (in i_NaCa)
Km_K = 1.0;   % millimolar (in i_NaK)
Km_Na = 40.0;   % millimolar (in i_NaK)
PNaK = 1.4731392;   % A_per_F (in i_NaK)
g_Na = 6646.185;   % S_per_F (in i_Na)
KPCa = 0.0005;   % millimolar (in i_PCa)
g_PCa = 0.4125;   % A_per_F (in i_PCa)
g_b_Ca = 0.69264;   % S_per_F (in i_b_Ca)
g_b_Na = 0.9;   % S_per_F (in i_b_Na)
E_f = -0.017;   % volt (in i_f)
g_f = 30.10312;   % S_per_F (in i_f)
g_to = 59.8077;   % S_per_F (in i_to)
Cao = 1.8;   % millimolar (in model_parameters)
Cm = 7.86671e-11;   % farad (in model_parameters)
F = 96485.3415;   % coulomb_per_mole (in model_parameters)
Ki = 150.0;   % millimolar (in model_parameters)
Ko = 5.4;   % millimolar (in model_parameters)
Nao = 151.0;   % millimolar (in model_parameters)
R = 8.314472;   % joule_per_mole_kelvin (in model_parameters)
T = 310.0;   % kelvin (in model_parameters)
V_SR = 465.2;   % micrometre_cube (in model_parameters)
Vc = 7012.0;   % micrometre_cube (in model_parameters)
i_stim_Amplitude = 5.5e-10;   % ampere (in stim_mode) should be: 5.5e-10
i_stim_End = 1000;   % second (in stim_mode)
i_stim_PulseDuration = 0.005;   % second (in stim_mode)
i_stim_Start = 0.0;   % second (in stim_mode)
i_stim_frequency = 60.0;   % per_second (in stim_mode)
stim_flag = 1;   % dimensionless (in stim_mode)
Ggap = 5.4; % conductance between cardiomyocytes (should be 5.4)
dYs = zeros(36,1);

%-------------------------------------------------------------------------------
% Computed variables
%-------------------------------------------------------------------------------

% Ca_SR_bufSR (dimensionless) (in calcium_dynamics)
% Cai_bufc (dimensionless) (in calcium_dynamics)
% const2 (dimensionless) (in calcium_dynamics)
% g_inf (dimensionless) (in calcium_dynamics)
% i_leak (millimolar_per_second) (in calcium_dynamics)
% i_rel (millimolar_per_second) (in calcium_dynamics)
% i_up (millimolar_per_second) (in calcium_dynamics)
% E_Ca (volt) (in electric_potentials)
% E_K (volt) (in electric_potentials)
% E_Ks (volt) (in electric_potentials)
% E_Na (volt) (in electric_potentials)
% alpha_d (dimensionless) (in i_CaL_d_gate)
% beta_d (dimensionless) (in i_CaL_d_gate)
% d_infinity (dimensionless) (in i_CaL_d_gate)
% gamma_d (dimensionless) (in i_CaL_d_gate)
% tau_d (second) (in i_CaL_d_gate)
% constf1 (dimensionless) (in i_CaL_f1_gate)
% f1_inf (dimensionless) (in i_CaL_f1_gate)
% tau_f1 (second) (in i_CaL_f1_gate)
% constf2 (dimensionless) (in i_CaL_f2_gate)
% f2_inf (dimensionless) (in i_CaL_f2_gate)
% tau_f2 (second) (in i_CaL_f2_gate)
% alpha_fCa (dimensionless) (in i_CaL_fCa_gate)
% beta_fCa (dimensionless) (in i_CaL_fCa_gate)
% constfCa (dimensionless) (in i_CaL_fCa_gate)
% fCa_inf (dimensionless) (in i_CaL_fCa_gate)
% gamma_fCa (dimensionless) (in i_CaL_fCa_gate)
% i_CaL (A_per_F) (in i_CaL)
% XK1_inf (dimensionless) (in i_K1)
% alpha_K1 (dimensionless) (in i_K1)
% beta_K1 (dimensionless) (in i_K1)
% i_K1 (A_per_F) (in i_K1)
% V_half (millivolt) (in i_Kr_Xr1_gate)
% Xr1_inf (dimensionless) (in i_Kr_Xr1_gate)
% alpha_Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% beta_Xr1 (dimensionless) (in i_Kr_Xr1_gate)
% tau_Xr1 (second) (in i_Kr_Xr1_gate)
% Xr2_infinity (dimensionless) (in i_Kr_Xr2_gate)
% alpha_Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% beta_Xr2 (dimensionless) (in i_Kr_Xr2_gate)
% tau_Xr2 (second) (in i_Kr_Xr2_gate)
% i_Kr (A_per_F) (in i_Kr)
% Xs_infinity (dimensionless) (in i_Ks_Xs_gate)
% alpha_Xs (dimensionless) (in i_Ks_Xs_gate)
% beta_Xs (dimensionless) (in i_Ks_Xs_gate)
% tau_Xs (second) (in i_Ks_Xs_gate)
% i_Ks (A_per_F) (in i_Ks)
% i_NaCa (A_per_F) (in i_NaCa)
% i_NaK (A_per_F) (in i_NaK)
% alpha_h (dimensionless) (in i_Na_h_gate)
% beta_h (dimensionless) (in i_Na_h_gate)
% h_inf (dimensionless) (in i_Na_h_gate)
% tau_h (second) (in i_Na_h_gate)
% alpha_j (dimensionless) (in i_Na_j_gate)
% beta_j (dimensionless) (in i_Na_j_gate)
% j_inf (dimensionless) (in i_Na_j_gate)
% tau_j (second) (in i_Na_j_gate)
% alpha_m (dimensionless) (in i_Na_m_gate)
% beta_m (dimensionless) (in i_Na_m_gate)
% m_inf (dimensionless) (in i_Na_m_gate)
% tau_m (second) (in i_Na_m_gate)
% i_Na (A_per_F) (in i_Na)
% i_PCa (A_per_F) (in i_PCa)
% i_b_Ca (A_per_F) (in i_b_Ca)
% i_b_Na (A_per_F) (in i_b_Na)
% Xf_infinity (dimensionless) (in i_f_Xf_gate)
% tau_Xf (second) (in i_f_Xf_gate)
% i_f (A_per_F) (in i_f)
% q_inf (dimensionless) (in i_to_q_gate)
% tau_q (second) (in i_to_q_gate)
% r_inf (dimensionless) (in i_to_r_gate)
% tau_r (second) (in i_to_r_gate)
% i_to (A_per_F) (in i_to)

%-------------------------------------------------------------------------------
% Computation
%-------------------------------------------------------------------------------

% time (second)
% Here is in range: https://www.ncbi.nlm.nih.gov/pubmed/8770204
%  - They find that the conductance is 7-8 for real / in silico conductance
% Here is not in range, but is mounse Cardiomyocyte: https://www.physiology.org/doi/pdf/10.1152/ajpheart.01218.2010



for curr_row = 1:num_rows
    for curr_col = 1:num_cols
        
        curr_cell = (curr_row - 1)*num_cols + curr_col;
        
        conductances = cell_params(:, curr_cell);
        gapFlag = 1;
        stimulated_cell = 13;
%         Try .25, .5, .75, 1, 2. 3, 4
        gap_magnitude = .75;
        
        gapFlag = gap_magnitude*gapFlag;
        
        
%         Flatten Y and conductances here?
        g_CaL = conductances(1);
        g_K1 = conductances(2);
        g_Kr = conductances(3);
        g_Ks = conductances(4);
        g_Na = conductances(5);
        g_PCa = conductances(6);
        g_b_Ca = conductances(7);
        g_b_Na = conductances(8);
   
        
        Y = Ys((curr_cell*18-17):curr_cell*18);
        adjacent_voltages = find_adjacent_voltages(curr_row, curr_col, num_rows, num_cols, Ys);
        curr_junctions = junctions(curr_row, curr_col,:);
        gap_conductance = curr_junctions(:)';
        
        
    
        E_K = R*T/F*log(Ko/Ki);
        alpha_K1 = 3.91/(1.0+exp(0.5942*(Y(1)*1000.0-E_K*1000.0-200.0)));
        beta_K1 = (-1.509*exp(0.0002*(Y(1)*1000.0-E_K*1000.0+100.0))+exp(0.5886*(Y(1)*1000.0-E_K*1000.0-10.0)))/(1.0+exp(0.4547*(Y(1)*1000.0-E_K*1000.0)));
        XK1_inf = alpha_K1/(alpha_K1+beta_K1);
        i_K1 = g_K1*XK1_inf*(Y(1)-E_K)*sqrt(Ko/5.4);
        i_to = g_to*(Y(1)-E_K)*Y(16)*Y(17);
        i_Kr = g_Kr*(Y(1)-E_K)*Y(9)*Y(10)*sqrt(Ko/5.4);
        E_Ks = R*T/F*log((Ko+PkNa*Nao)/(Ki+PkNa*Y(18)));
        i_Ks = g_Ks*(Y(1)-E_Ks)*Y(11)^2.0*(1.0+0.6/(1.0+(3.8*0.00001/Y(3))^1.4));
        i_CaL = g_CaL*4.0*Y(1)*F^2.0/(R*T)*(Y(3)*exp(2.0*Y(1)*F/(R*T))-0.341*Cao)/(exp(2.0*Y(1)*F/(R*T))-1.0)*Y(5)*Y(6)*Y(7)*Y(8);
        i_NaK = PNaK*Ko/(Ko+Km_K)*Y(18)/(Y(18)+Km_Na)/(1.0+0.1245*exp(-0.1*Y(1)*F/(R*T))+0.0353*exp(-Y(1)*F/(R*T)));
        E_Na = R*T/F*log(Nao/Y(18));
        i_Na = g_Na*Y(14)^3.0*Y(12)*Y(13)*(Y(1)-E_Na);
        i_NaCa = kNaCa*(exp(gamma*Y(1)*F/(R*T))*Y(18)^3.0*Cao-exp((gamma-1.0)*Y(1)*F/(R*T))*Nao^3.0*Y(3)*alpha)/((KmNai^3.0+Nao^3.0)*(KmCa+Cao)*(1.0+Ksat*exp((gamma-1.0)*Y(1)*F/(R*T))));
        i_PCa = g_PCa*Y(3)/(Y(3)+KPCa);
        i_f = g_f*Y(15)*(Y(1)-E_f);
        i_b_Na = g_b_Na*(Y(1)-E_Na);
        E_Ca = 0.5*R*T/F*log(Cao/Y(3));
        i_b_Ca = g_b_Ca*(Y(1)-E_Ca);

        i_stim_Period = 60.0/i_stim_frequency;

        if ((time >= i_stim_Start) && (time <= i_stim_End) && (time-i_stim_Start-floor((time-i_stim_Start)/i_stim_Period)*i_stim_Period <= i_stim_PulseDuration) && curr_cell == stimulated_cell)
            i_stim = stim_flag*i_stim_Amplitude/Cm;
        else
            i_stim = 0.0;
        end

        gapDY = gap_magnitude*gap_conductance*(Y(1) - adjacent_voltages)';
        
        dY(1, 1) = -(i_K1+i_to+i_Kr+i_Ks+i_CaL+i_NaK+i_Na+i_NaCa+i_PCa+i_f+i_b_Na+i_b_Ca-i_stim + ...
            + gapDY*gapFlag);

        i_rel = (c_rel+a_rel*Y(2)^2.0/(b_rel^2.0+Y(2)^2.0))*Y(5)*Y(4)*0.0556;
        i_up = VmaxUp/(1.0+Kup^2.0/Y(3)^2.0);
        i_leak = (Y(2)-Y(3))*V_leak;

        g_inf= (Y(3)<=0.00035)*(1/(1+(Y(3)/0.00035)^6))+(Y(3)>0.00035)*(1/(1+(Y(3)/0.00035)^16));
        % if (Y(3) <= 0.00035)
        %    g_inf = 1.0/(1.0+(Y(3)/0.00035)^6.0);
        % else
        %    g_inf = 1.0/(1.0+(Y(3)/0.00035)^16.0);
        % end;

        const2=(1-(g_inf > Y(4))*(Y(1)>-0.06));
        % if ((g_inf > Y(4)) && (Y(1) > -0.06))
        %    const2 = 0.0;
        % else
        %    const2 = 1.0;
        % end;

        dY(4, 1) = const2*(g_inf-Y(4))/tau_g;
        Cai_bufc = 1.0/(1.0+Buf_C*Kbuf_C/(Y(3)+Kbuf_C)^2.0);
        Ca_SR_bufSR = 1.0/(1.0+Buf_SR*Kbuf_SR/(Y(2)+Kbuf_SR)^2.0);
        dY(3, 1) = Cai_bufc*(i_leak-i_up+i_rel-(i_CaL+i_b_Ca+i_PCa-2.0*i_NaCa)*Cm/(2.0*Vc*F*1.0e-18));
        dY(2, 1) = Ca_SR_bufSR*Vc/V_SR*(i_up-(i_rel+i_leak));
        d_infinity = 1.0/(1.0+exp(-(Y(1)*1000.0+5.986)/7.0));
        alpha_d = 0.25+1.4/(1.0+exp((-Y(1)*1000.0-35.0)/13.0));
        beta_d = 1.4/(1.0+exp((Y(1)*1000.0+5.0)/5.0));
        gamma_d = 1.0/(1.0+exp((-Y(1)*1000.0+50.0)/20.0));
        tau_d = (alpha_d*beta_d+gamma_d)*1.0/1000.0;
        dY(5, 1) = (d_infinity-Y(5))/tau_d;
        f1_inf = 1.0/(1.0+exp((Y(1)*1000.0+25.226)/3.0));

        if (f1_inf-Y(6) > 0.0)
            constf1 = 1.0+1433.0*(Y(3)-50.0*1.0e-6);
        else
            constf1 = 1.0;
        end

        tau_f1 = (20.0+1102.5*exp(-((Y(1)*1000.0+27.0)^2.0/15.0)^2.0)+200.0/(1.0+exp((13.0-Y(1)*1000.0)/10.0))+180.0/(1.0+exp((30.0+Y(1)*1000.0)/10.0)))*constf1/1000.0;
        dY(6, 1) = (f1_inf-Y(6))/tau_f1;
        f2_inf = 0.33+0.67/(1.0+exp((Y(1)*1000.0+31.226)/4.0));
        constf2 = 2.0;
        tau_f2 = (600.0*exp(-(Y(1)*1000.0+25.0)^2.0/170.0)+31.0/(1.0+exp((25.0-Y(1)*1000.0)/10.0))+16.0/(1.0+exp((30.0+Y(1)*1000.0)/10.0)))*constf2/1000.0;
        dY(7, 1) = (f2_inf-Y(7))/tau_f2;
        alpha_fCa = 1.0/(1.0+(Y(3)/0.0006)^8.0);
        beta_fCa = 0.1/(1.0+exp((Y(3)-0.0009)/0.0001));
        gamma_fCa = 0.3/(1.0+exp((Y(3)-0.00075)/0.0008));
        fCa_inf = (alpha_fCa+beta_fCa+gamma_fCa)/1.3156;

        if ((Y(1) > -0.06) && (fCa_inf > Y(8)))
            constfCa = 0.0;
        else
            constfCa = 1.0;
        end;

        dY(8, 1) = constfCa*(fCa_inf-Y(8))/tau_fCa;
        V_half = 1000.0*(-R*T/(F*Q)*log((1.0+Cao/2.6)^4.0/(L0*(1.0+Cao/0.58)^4.0))-0.019);
        Xr1_inf = 1.0/(1.0+exp((V_half-Y(1)*1000.0)/4.9));
        alpha_Xr1 = 450.0/(1.0+exp((-45.0-Y(1)*1000.0)/10.0));
        beta_Xr1 = 6.0/(1.0+exp((30.0+Y(1)*1000.0)/11.5));
        tau_Xr1 = 1.0*alpha_Xr1*beta_Xr1/1000.0;
        dY(9, 1) = (Xr1_inf-Y(9))/tau_Xr1;
        Xr2_infinity = 1.0/(1.0+exp((Y(1)*1000.0+88.0)/50.0));
        alpha_Xr2 = 3.0/(1.0+exp((-60.0-Y(1)*1000.0)/20.0));
        beta_Xr2 = 1.12/(1.0+exp((-60.0+Y(1)*1000.0)/20.0));
        tau_Xr2 = 1.0*alpha_Xr2*beta_Xr2/1000.0;
        dY(10, 1) = (Xr2_infinity-Y(10))/tau_Xr2;
        Xs_infinity = 1.0/(1.0+exp((-Y(1)*1000.0-20.0)/16.0));
        alpha_Xs = 1100.0/sqrt(1.0+exp((-10.0-Y(1)*1000.0)/6.0));
        beta_Xs = 1.0/(1.0+exp((-60.0+Y(1)*1000.0)/20.0));
        tau_Xs = 1.0*alpha_Xs*beta_Xs/1000.0;
        dY(11, 1) = (Xs_infinity-Y(11))/tau_Xs;
        h_inf = 1.0/sqrt(1.0+exp((Y(1)*1000.0+72.1)/5.7));

        if (Y(1) < -0.04)
            alpha_h = 0.057*exp(-(Y(1)*1000.0+80.0)/6.8);
        else
            alpha_h = 0.0;
        end;

        if (Y(1) < -0.04)
            beta_h = 2.7*exp(0.079*Y(1)*1000.0)+3.1*10.0^5.0*exp(0.3485*Y(1)*1000.0);
        else
            beta_h = 0.77/(0.13*(1.0+exp((Y(1)*1000.0+10.66)/-11.1)));
        end;

        if (Y(1) < -0.04)
            tau_h = 1.5/((alpha_h+beta_h)*1000.0);
        else
            tau_h = 2.542/1000.0;
        end;

        dY(12, 1) = (h_inf-Y(12))/tau_h;
        j_inf = 1.0/sqrt(1.0+exp((Y(1)*1000.0+72.1)/5.7));

        if (Y(1) < -0.04)
            alpha_j = (-25428.0*exp(0.2444*Y(1)*1000.0)-6.948*10.0^-6.0*exp(-0.04391*Y(1)*1000.0))*(Y(1)*1000.0+37.78)/(1.0+exp(0.311*(Y(1)*1000.0+79.23)));
        else
            alpha_j = 0.0;
        end;

        if (Y(1) < -0.04)
            beta_j = 0.02424*exp(-0.01052*Y(1)*1000.0)/(1.0+exp(-0.1378*(Y(1)*1000.0+40.14)));
        else
            beta_j = 0.6*exp(0.057*Y(1)*1000.0)/(1.0+exp(-0.1*(Y(1)*1000.0+32.0)));
        end;

        tau_j = 7.0/((alpha_j+beta_j)*1000.0);
        dY(13, 1) = (j_inf-Y(13))/tau_j;
        m_inf = 1.0/(1.0+exp((-Y(1)*1000.0-34.1)/5.9))^(1.0/3.0);
        alpha_m = 1.0/(1.0+exp((-Y(1)*1000.0-60.0)/5.0));
        beta_m = 0.1/(1.0+exp((Y(1)*1000.0+35.0)/5.0))+0.1/(1.0+exp((Y(1)*1000.0-50.0)/200.0));
        tau_m = 1.0*alpha_m*beta_m/1000.0;
        dY(14, 1) = (m_inf-Y(14))/tau_m;
        Xf_infinity = 1.0/(1.0+exp((Y(1)*1000.0+77.85)/5.0));
        tau_Xf = 1900.0/(1.0+exp((Y(1)*1000.0+15.0)/10.0))/1000.0;
        dY(15, 1) = (Xf_infinity-Y(15))/tau_Xf;
        q_inf = 1.0/(1.0+exp((Y(1)*1000.0+53.0)/13.0));
        %        q_inf = 1/(1 + exp((1000*Y(1)+ 49+4)/13*1));
        tau_q =       (6.06+39.102/(0.57*exp(-0.08*(Y(1)*1000.0+44.0))+0.065*exp(0.1*(Y(1)*1000.0+45.93))))/1000.0;
        %         tau_q = (6.06+39.102/(0.57*exp(-0.08*(1000*Y(1)+44    ))+0.065*exp(0.1*(1000*Y(1)+45.93  ))))/1000;
        dY(16, 1) = (q_inf-Y(16))/tau_q;
        r_inf =    1.0/(1.0+exp(-(Y(1)*1000.0-22.3)/18.75 ));
        %        r_inf = 1/(1+exp((-1000*Y(1)+19.3+3) /15*0.8));
        tau_r =       (2.75352+14.40516/(1.037*exp(0.09*(Y(1)*1000.0+30.61))+0.369*exp(-0.12*(Y(1)*1000.0+23.84))))/1000.0;
        %         tau_r = (2.75352+14.40516/(1.037*exp(0.09*(1000*Y(1)+30.61  ))+0.369*exp(-0.12*(1000*Y(1)+23.84  ))))/1000;
        dY(17, 1) = (r_inf-Y(17))/tau_r;
        dY(18, 1) = -Cm*(i_Na+i_b_Na+3.0*i_NaK+3.0*i_NaCa)/(F*Vc*1.0e-18);


        Ik1 = i_K1;
        Ito = i_to;
        Ikr = i_Kr;
        Iks = i_Ks;
        ica = i_CaL;
        INaK = i_NaK;
        INa = i_Na;
        inaca = i_NaCa;
        IpCa = i_PCa;
        If = i_f;
        IbNa = i_b_Na;
        IbCa = i_b_Ca;
        Irel = i_rel;
        Iup = i_up;
        Ileak = i_leak;
        Istim = i_stim;

        dati = [Ik1, Ito, Ikr, Iks, ica, INaK, INa, inaca, IpCa, If, IbNa, IbCa, Irel, Iup, Ileak, Istim, E_K, E_Na];
        
        

        dYs((curr_cell*18-17):curr_cell*18) = dY;    
    end
end


        
%         if curr_row == 1 && curr_col == 1 && gap_conductance_flag == 1
%            curr_cell_i = 1;
%            new_voltage_indices = (1:(num_rows*num_cols))*18 - 17;
%            start_voltages = Ys(new_voltage_indices);   
% 
%            
%            for curr_row_i = 1:num_rows
%                for curr_col_i = 1:num_cols
%                    adjacent_voltages = find_adjacent_voltages(curr_row_i, curr_col_i, num_rows, num_cols, Ys)';
%                    curr_junctions = junctions(curr_row_i, curr_col_i,:);
%                    gap_conductance = curr_junctions(:);
%                     
%           
%                    for iteration = 1:9
%                        start_voltages(curr_cell_i) = start_voltages(curr_cell_i) + .005*gap_conductance(iteration) * (start_voltages(curr_cell_i) - adjacent_voltages(iteration));
%                    end    
%                    curr_cell_i = curr_cell_i + 1;
%                end
%            end
%             Ys(new_voltage_indices) = start_voltages;
%         end

%===============================================================================
% End of file
%===============================================================================
